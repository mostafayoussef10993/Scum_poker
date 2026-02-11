**Unused / Removable Code Analysis**

- **Summary:** I scanned the repository and found several fully commented, duplicated, or empty files that are not referenced by the running app and can be removed safely to simplify the codebase.

**Files and folders recommended for removal**

- [lib/src](lib/src)
  - Reason: Entire folder contains legacy / commented-out code (duplicate of `lib/app`) and several empty files. The app uses `lib/main.dart` and `lib/app/*`. Keeping `lib/src` only adds confusion.
  - Action: Remove the whole directory.

- [lib/src/main.dart](lib/src/main.dart)
  - Reason: Entire file is commented out and not used as the app entrypoint.

- [lib/src/bloc/user_cubit.dart](lib/src/bloc/user_cubit.dart)
  - Reason: Fully commented legacy implementation; duplicate concepts exist in `lib/app/bloc`.

- [lib/src/bloc/voting_cubit.dart](lib/src/bloc/voting_cubit.dart)
  - Reason: Fully commented legacy implementation; not referenced.

- [lib/src/data/session_repository.dart](lib/src/data/session_repository.dart)
  - Reason: Fully commented; duplicate repository logic exists in `lib/app/data`.

- [lib/src/data/firebase_service.dart](lib/src/data/firebase_service.dart)
  - Reason: Empty file (no content).

- [lib/src/models/session.dart](lib/src/models/session.dart)
  - Reason: Fully commented model definition; unused since the app uses `lib/app/models/session_model.dart`.

- [lib/src/models/vote.dart](lib/src/models/vote.dart)
  - Reason: Fully commented model definition; unused.

- [lib/src/presentation/**](lib/src/presentation)
  - Reason: Presentation pages under `lib/src/presentation` are commented legacy screens/implementations and are not used by the app.

- [lib/app/presentations/results/result_screen.dart](lib/app/presentations/results/result_screen.dart)
  - Reason: The file contains a large commented-out implementation (dead code) and is not used; an active `VoteScreen` shows results instead.

**Why remove these**
- Reduces repository clutter and cognitive overhead.
- Avoids confusion about which files are active vs. legacy.
- Makes static analysis, linters, and future refactors easier.

**Suggested git commands**

- Remove `lib/src` directory:

  git rm -r lib/src
  git commit -m "chore: remove legacy commented src/ folder"

- Remove the commented result screen file:

  git rm lib/app/presentations/results/result_screen.dart
  git commit -m "chore: remove dead commented result_screen.dart"

**Safety notes**
- If you want to keep a backup before deleting, create a branch first:

  git checkout -b safe/backup-legacy-src
  git commit -m "backup: preserve legacy src before cleanup"

- After verifying the app still runs and tests pass, merge cleanup to main.

**Next steps I can take for you**
- I can apply these deletions for you and run a quick static analysis (and fix any resulting import issues), or
- I can create a clean branch with the deletions so you can review before merging.

