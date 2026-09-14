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

The workflow is automated by [`make generate`](Makefile). It needs a Swift
toolchain, `python3` with `venv`, and network access on the first run. No fork
of the generator and no sibling checkout are required: the Makefile clones and
builds the pinned Swift OpenAPI Generator release under `.build/` and installs
the Python dependency (PyYAML) into a virtualenv there.

Before running generation, update
[`openapi-generator-config.yaml`](openapi-generator-config.yaml) with every path
and standalone schema the change needs. Then run:

```sh
make generate
```

The command:

1. applies the conditional, line-based spec fixes in [`Scripts/`](Scripts/)
   (`prepare_openapi.py`, `remove_required_properties.py`) and writes their diff
   to `.build/openapi-generator/openapi.patch`;
2. runs `Scripts/transform_openapi.py`, which collapses OpenAI's
   `anyOf: [X, {type: 'null'}]` nullability into optional properties (the
   generator does not support that form, see apple/swift-openapi-generator#906)
   and records the wire values of every discriminated union, because the spec's
   discriminators have no `mapping` (openai/openai-openapi#542);
3. runs Swift OpenAPI Generator (types only) with the repository's configuration;
4. runs `Scripts/postprocess_components.py`, which re-wraps the generated schemas
   under the existing header of `Components.swift`, appends the wire values to
   each union's decoder, and adds a fallback for the one value that names two
   schemas (`message` in `Item` and `ItemResource`).

Review `.build/openapi-generator/openapi.patch` and the generated Swift diff, run
`swift package diagnose-api-breaking-changes` against the latest tag (every
regeneration is a public API change, see *API stability*), build the package and
run the tests. The `Generation` workflow in CI runs `make generate` and fails
when the committed `Components.swift` does not match the pipeline's output.

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
