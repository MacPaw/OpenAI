# OSS-Fuzz integration templates

The actual OSS-Fuzz project descriptor for MacPaw/OpenAI lives upstream
at [`google/oss-fuzz/projects/macpaw-openai/`](https://github.com/google/oss-fuzz/tree/master/projects).
The three files here (`project.yaml`, `Dockerfile`, `build.sh`) are the
templates a maintainer applies to their fork of `google/oss-fuzz` when
they want to register the project.

This directory is intentionally checked in so the integration source of
truth lives next to the harnesses they describe. Update these files
whenever you add or rename a harness in `FuzzTesting/Package.swift`.

## How to submit upstream

1. **Confirm Swift support is acceptable for the project.** OSS-Fuzz
   Swift support uses `gcr.io/oss-fuzz-base/base-builder-swift`. It
   works but is not as mature as the C/C++/Rust/Go/Python paths — read
   <https://google.github.io/oss-fuzz/getting-started/new-project-guide/swift-lang/>
   before committing.

2. **Decide on contacts.** Edit `project.yaml`:
   - `primary_contact` must be an email tied to a Google account
     (so OSS-Fuzz can grant access to the private bug-report
     dashboard).
   - `auto_ccs` is optional and accepts multiple addresses.

3. **Fork `google/oss-fuzz`.**
   ```sh
   gh repo fork google/oss-fuzz --clone
   cd oss-fuzz
   ```

4. **Copy these templates into the fork.**
   ```sh
   mkdir -p projects/macpaw-openai
   cp /path/to/OpenAI/FuzzTesting/oss-fuzz-integration/project.yaml \
      /path/to/OpenAI/FuzzTesting/oss-fuzz-integration/Dockerfile \
      /path/to/OpenAI/FuzzTesting/oss-fuzz-integration/build.sh \
      projects/macpaw-openai/
   chmod +x projects/macpaw-openai/build.sh
   ```
   Then fill in the `TODO(maintainer)` contact lines in
   `projects/macpaw-openai/project.yaml`.

5. **Smoke-test the integration locally.** OSS-Fuzz ships a helper
   driver:
   ```sh
   python infra/helper.py build_image macpaw-openai
   python infra/helper.py build_fuzzers --sanitizer address macpaw-openai
   python infra/helper.py check_build macpaw-openai
   python infra/helper.py run_fuzzer macpaw-openai FuzzResponseStreamEventDecoder
   ```

6. **Open the PR upstream.**
   ```sh
   git checkout -b macpaw-openai
   git add projects/macpaw-openai
   git commit -m "Add MacPaw/OpenAI project"
   git push -u origin macpaw-openai
   gh pr create --repo google/oss-fuzz --base master
   ```

## Keeping these templates in sync

When `FuzzTesting/Package.swift` gains or renames a harness, update the
`HARNESSES=(...)` array in `build.sh`. Once your upstream project is
live, mirror the change into `projects/macpaw-openai/build.sh` in the
`google/oss-fuzz` repo (a small follow-up PR).
