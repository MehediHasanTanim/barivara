# Contributing to Bari Vara

## Branches and commits

Use short-lived branches named `feature/<area>`, `fix/<area>`, or
`chore/<area>`. Keep commits focused and use Conventional Commit style, for
example `feat(billing): generate a draft monthly bill`.

## Local checks

Run these checks before opening a pull request:

```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart format --set-exit-if-changed .
flutter analyze
flutter test
flutter build apk --debug
```

For iOS validation on macOS, run:

```sh
flutter build ios --debug --no-codesign
```

## Implementation rules

- Follow the visual references in `docs/UX` exactly.
- Keep core product workflows fully offline.
- Never use binary floating point for money.
- Preserve finalized financial history; use adjustments or reversals.
- Keep tenant PII and financial details out of logs.
