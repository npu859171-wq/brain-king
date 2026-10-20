# Brain King — Phase 1 starter

Royal Black & Gold Flutter prototype for the first development phase.

## Included
- Splash screen
- Login/sign-up UI (demo only; no real authentication)
- Home dashboard
- Profile placeholder
- Small sample quiz and result screen

## Important
This is a UI prototype. Firebase is not connected. Login does not create or verify accounts, and the quiz does not issue real coins, XP, or rewards. Do not use this as a production app until authentication, database rules, server-side validation, privacy/security, and tests are implemented.

## Run
1. Install Flutter SDK and Android tooling.
2. Extract this ZIP.
3. In the extracted folder run:
   flutter pub get
   flutter run

For Android APK after Flutter and Android SDK are configured:
   flutter build apk --release

## Next phase
Connect Firebase Authentication and Firestore securely, then implement real profiles and server-validated quiz progress/rewards.
