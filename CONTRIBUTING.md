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

There are two ways to add or change an API in this project: write the required
methods and types by hand, or use the OpenAPI specification to generate the
supporting types. Code generation is especially useful for a large API with many
nested schemas, but it is not a requirement for every change.

Start by checking the repository's [`openapi.yaml`](openapi.yaml). A tool such as
[Swagger Editor](https://editor.swagger.io) can make the document easier to
explore. If it describes the paths and schemas you need, use the generation
workflow below. If it does not, implement the missing API by hand rather than
editing the generated file. See [openai-openapi](https://github.com/openai/openai-openapi) for the latest spec.

### Implementing by hand

See `ChatQuery`, `ChatResult`, and their dependent types for examples. Handwritten
top-level types are often preferable because they let us present a focused Swift
API with carefully written documentation. Generated types can still supply the
larger collection of nested schemas behind that API.

### Implementing using Code Generation

Generation produces types only. API methods, endpoints, and the public top-level
models that wrap those types remain handwritten. For example, the Responses API
uses handwritten `CreateModelResponseQuery`, `ResponseObject`, and
`ResponseStreamEvent` types, while their supporting schemas come from
`Components.Schemas`.

The workflow is automated by [`make generate`](Makefile). The Makefile is the
source of truth for prerequisites and the exact commands; in particular, it
documents the required sibling checkout of the project's Swift OpenAPI Generator
fork and the generator changes that fork must contain.

Before running generation, update
[`openapi-generator-config.yaml`](openapi-generator-config.yaml) with every path
and standalone schema the change needs. Then run:

```sh
make generate
```

The command:

1. prepares a generator-compatible copy of `openapi.yaml` under `.build/`;
2. applies the narrowly scoped workarounds documented in [`Scripts/`](Scripts/);
3. runs Swift OpenAPI Generator with the repository's configuration; and
4. extracts the generated `Components` enum into
   `Sources/OpenAI/Public/Schemas/Generated/Components.swift` while preserving
   that file's imports and header.

The source specification is not modified during this process. The final
preparation diff is written to `.build/openapi-generator/openapi.patch`; review
it along with the generated Swift diff. Build the package and run the relevant
tests before submitting the change.

Do not edit `Components.swift` by hand. It is deliberately replaceable output,
so a later generation would discard such edits.

#### When a generated type is not suitable

The specification can lag behind the live API, and generated types are not
always the best public Swift interface. If a generated type is incomplete or
awkward, extract or recreate it as a handwritten type instead of patching the
generated file.

Put a direct replacement or adaptation in
`Sources/OpenAI/Public/Schemas/Edited/`. Keep its name and structure close to the
generated schema where practical so it can be replaced again when the upstream
specification catches up. Types that are not part of the specification belong in
an appropriate handwritten area; `Sources/OpenAI/Public/Schemas/Facade/`
contains examples that provide a friendlier API over generated schemas.
