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

## API stability

The public API of this package is additive-only:

- Anything declared `public` is part of the contract. That includes the generated
  types in `Components.Schemas`, the `Edited` and `Facade` schema types, and every
  hand-written query, result and protocol.
- New functionality arrives as new optional parameters, new methods, new types or
  new enum cases. Existing symbols are not renamed, removed or retyped.
- A symbol that has to go away is marked `@available(*, deprecated, message:)`
  with the reason and the replacement, and stays until the next major version.
- A result type changes only when the API itself changed shape, and even then
  prefer keeping the old member as a deprecated computed property over removing it.

swift-openapi-generator's own docs recommend against exposing generated code as
part of a package's public API, precisely because a `oneOf` schema gaining a
case, a response gaining a content type, and similar spec changes are breaking
in generated Swift even when they're additive in OpenAPI (see
[API stability of generated code](https://swiftpackageindex.com/apple/swift-openapi-generator/documentation/swift-openapi-generator/api-stability-of-generated-code)).
This package does it anyway, because generating and exposing `Components.Schemas`
directly is what makes it practical to track a spec as large and fast-moving as
OpenAI's: hand-writing and maintaining a wrapper type behind every generated
schema would make keeping up with new APIs far slower. This section, and the
*API Breakage* CI workflow described below, exist to make that trade-off safe:
every such break has to be noticed and consciously accepted rather than
silently shipped.

### Adding endpoints

New endpoint groups are added as namespaces, following the Responses API: one
`var responses: ResponsesEndpointProtocol { get }` style property on
`OpenAIProtocol`, with the methods on the endpoint protocol in completion-handler,
async and Combine flavours. Introducing a namespace costs one new protocol
requirement, and adding a method to an existing endpoint protocol costs one as
well; both are recorded in the allowlist with a changelog entry, because external
conformers such as test mocks have to add the member. Do not add new methods
directly to `OpenAIProtocol`, `OpenAIAsync` or `OpenAICombine`.

### How it is enforced

The *API Breakage* workflow runs `swift package diagnose-api-breaking-changes` on
every pull request, comparing the public API with the latest release tag. It fails
on every reported break that is not listed in `.github/api-breakage-allowlist.txt`.
Run the same check locally before opening a pull request, replacing `0.5.1` with
the latest tag:

```sh
swift package diagnose-api-breaking-changes 0.5.1
```

### Accepting a break

Sometimes the OpenAI spec forces a change that cannot be expressed additively, for
example a field whose JSON type changed. In that case:

1. Try the additive route first: extract the type into
   `Sources/OpenAI/Public/Schemas/Edited/`, keep the old member as a deprecated
   alias, and let the generated type change underneath.
2. If a break is unavoidable, add the exact message from the workflow output to
   `.github/api-breakage-allowlist.txt`, and describe the break and the migration
   in the *Unreleased* section of `CHANGELOG.md`. The file holds one message per
   line and nothing else: with a comment or blank line present, the checker
   matches none of the entries. Explain accepted breaks in the changelog, not in
   the file.
3. Accepted breaks ship in a minor release with a call-out at the top of the
   release notes. The allowlist is emptied when that release is tagged, because
   the comparison baseline moves to the new tag.

### Generated types

`Components.swift` is regenerated from `openapi.yaml`, and each regeneration is a
public API change. Run the breakage check on the regeneration diff, review every
reported line, and add shims (typealiases, deprecated overloads, extracted `Edited`
types) before accepting anything into the allowlist. Expose new API through
hand-written or `Facade` types where possible, so that users depend on generated
types as little as possible.

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

1. downloads the latest `openapi.yaml` from
   [openai/openai-openapi](https://github.com/openai/openai-openapi), overwriting
   the repository's copy;
2. prepares a generator-compatible copy of that spec under `.build/`;
3. applies the narrowly scoped workarounds documented in [`Scripts/`](Scripts/);
4. runs Swift OpenAPI Generator with the repository's configuration; and
5. extracts the generated `Components` enum into
   `Sources/OpenAI/Public/Schemas/Generated/Components.swift` while preserving
   that file's imports and header.

The downloaded `openapi.yaml` is committed as-is; only the working copy under
`.build/` receives the workarounds. The final preparation diff is written to
`.build/openapi-generator/openapi.patch`; review it, the `openapi.yaml` diff,
and the generated Swift diff together. Build the package and run the relevant
tests before submitting the change.

Run `make download-spec` on its own to refresh `openapi.yaml` without
regenerating types.

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
