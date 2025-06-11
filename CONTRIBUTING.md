## Contribution Guidelines
Make your Pull Requests clear and obvious to anyone viewing them.  
Set `main` as your target branch.

#### Use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) principles in naming PRs and branches:

- `Feat: ...` for new features and new functionality implementations.
- `Bug: ...` for bug fixes.
- `Fix: ...` for minor issues fixing, like typos or inaccuracies in code.
- `Chore: ...` for boring stuff like code polishing, refactoring, deprecation fixing etc.

PR naming example: `Feat: Add Threads API handling` or `Bug: Fix message result duplication`

Branch naming example: `feat/add-threads-API-handling` or `bug/fix-message-result-duplication`

#### Write description to pull requests in following format:
- What

  ...
- Why

  ...
- Affected Areas

  ...
- More Info

  ...

We'll appreciate you including tests to your code if it is needed and possible. ❤️

## Implementing an API

> Using Code generation in this project is a bit nuanced. For small additions and edits it is OK to write everything manually. For larger changes consider asking a maintaner to implement the wanted piece. Read on if you'd like to implement larger parts and you're ok to dig into the nits-and-bits of the approach.

Currently there are 2 ways we can implement or edit an API:
1. By implementing all the needed methods and types ourselves manually.
2. By generating Types and using them in the code we write.

Before attempting the Code Generation, see if the spec contains what you need:
1. When a need to implement a new API arises - check if it's implemented in [openai-openapi](https://github.com/openai/openai-openapi)*. For an easier exploration use [Swagger Editor](https://editor.swagger.io) to browse `OpenAPI Specification` file and see if the needed Types are described there (yes, it may not be there, it may take time for OpenAI to update the spec).
2. If the Paths and Types required for implementation are not in the spec file - [implement everything by hand](#implementing-by-hand).
3. If the spec contains what's needed - proceed to [generate the code](#implementing-using-code-generation).

> * [openai-openapi](https://github.com/openai/openai-openapi) repo may not contain the latest spec. Try checking `.stats.yml` of an official OpenAI SDK like [openai-python](https://github.com/openai/openai-python) or [openai-node](https://github.com/openai/openai-node), it may contain a more up-to-date spec.

#### Pros and cons of using Code Generation

##### + Implementation speed

It's super fast to implement a large API like Responses API using Code Generation. Even though top-level types of the API are hand-crafted, they use so many smaller generated types, it would take very long to implement myself.

##### + The generated types are structured

OpenAPI spec is provided by OpenAPI - it has all the insights on the DB scheme used by OpenAI. It may contain insights about the schemes future which we, as an outside developers, may not be able to see. 

For example, a generated `EasyInputMessage` type is used in both `Responses` and `Evals` APIs.

##### - OpenAI lags behind

OpenAI doesn't update the OpenAPI spec too frequently, which may lead to a nede to extract a generated type.

##### - Generated code is not "beautiful"

There are drawbacks in the looks of the generated code, like enums have upper case etc., which may lead to a desire to extract a type to make the code look more user friendly.

### Implementing by hand

Implementing by hand is straightforward. See `ChatQuery`, `ChatResult` and their dependant types for an example.

### Implementing using Code Generation

#### What we generate and what we don't
1. Currently the only thing we generate is Types. I.e. we don't generate API methods. So for example, during implementing `Responses API` I didn't generate `ResponsesEndpoint` file and its `createResponse` and `createResponseStreaming` methods.
2. This is optional, but I haven't used generated types at the top level. In the `Reponses API` example, the 3 main (top level) types are `CreateModelResponseQuery`, `ResponseObject` and `ResponseStreamEvent`. They are all written by hand to make the API and documentation comments look good and full. What's generated are the types they depend on. `CreateModelResponseQuery` depends on `Schemas.Includable`, `ResponseObject` depends on `Schemas.ResponseError` and so on.

#### How to generate Types
1. Use [Swift OpenAPI Generator](https://github.com/apple/swift-openapi-generator) to generate the code using OpenAI's OpenAPI spec file. See comments at the top of `Components.swift` on the configuration that was used for the last generation, append your configs to that so that a new generation doesn't miss something out. I used CLI to generate the files outside of the project folder and then just copied the generated code into the project.
2. When you've got `Types.swift` generated - copy only the `Components` enum into `/Sources/OpenAI/Public/Schemas/Generated/Components.swift`. Replace the existing enum. See comments at the top of `Components.swift` file (section "Manual operations after Types.swift file was generated") for any operations that have to be done manually after the generated code is in place. If you need to edit anything manually in `Components` enum - note it in the mentioned section.
3. Use the types from `Components.Schemas` as you need.

#### What to do if a Generated Type is incomplete
Let's say you've [come across an issue](https://github.com/MacPaw/OpenAI/issues/347) when a generated Types has missing fields, and the latest OpenAI-OpenAPI spec still doesn't have it implemented. Consider the constraints:

1. We can't wait for them to update the spec, we don't even know if they are going to.
2. We don't want to edit `Components.swift`, as we want to keep it easily replacable with new generations.

So, this is a case where we would [extract a type](#extracting-a-generated-type).

#### Extracting a generated Type
If for any reason a generated Type doesn't meet your needs - you can always just extract it and edit, or just write a type manually.

If a type is a direct edit or extension of a type - put it into `Sources/OpenAI/Public/Schemas/Edited/`. It is preferred to keep the name and the structure of a file so that when OpenAPI spec is updated we could removed the edited file and use a generated code.

If the new type is not part of OpenAI provided spec - just name it the way you think right and put it into another folder. See `Sources/OpenAI/Public/Schemas/Facade/` for examples, where new types are introduced facading the generated code to make the Responses API in Swift more friendly.