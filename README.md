# Security — Biometric App Lock Demo

A Flutter demo showing how FaceID (iOS) and fingerprint biometrics (Android) can gate access to a mobile app.

## Features

- **Lock on launch** — app starts locked, requires biometrics to open
- **Lock on background** — sending the app to background re-locks it
- **Biometric unlock** — FaceID / TouchID / Android fingerprint prompt
- **Platform error display** — shows specific error (e.g., "Face didn't match", "No biometrics enrolled")
- **Retry on failure** — tap "Unlock" to try again
- **Manual lock** — "Lock App" button in the unlocked area

## How to run

```bash
flutter pub get
flutter run
```

### Prerequisites

- Flutter SDK 3.11.4+
- Android emulator with API 28+ or iOS simulator

### Enrolling biometrics

**Android emulator:**
1. Open Settings → Security → Fingerprint → Add fingerprint
2. Set a backup PIN if prompted
3. When it says "Touch the sensor", open **Extended Controls** (⋮ toolbar)
4. Go to **Fingerprint** → click **Touch the fingerprint sensor**
5. Finish enrollment, then launch the app

**iOS simulator:**
1. Simulator → Features → Face ID → Enrolled
2. Launch the app — the Face ID prompt will appear automatically

## Architecture

```
BiometricAuthService    — wraps local_auth plugin (authenticate, lastErrorMessage)
App (main.dart)         — lifecycle-aware lock state (WidgetsBindingObserver)
├── LockScreen          — lock icon + Unlock button + error text
└── HomeScreen          — secure placeholder + Lock App button
```

## Platform setup

**iOS** — `ios/Runner/Info.plist` includes `NSFaceIDUsageDescription`.

**Android** — `AndroidManifest.xml` includes `USE_BIOMETRIC` permission. `MainActivity` extends `FlutterFragmentActivity` (required by `local_auth`).

## Dependencies

- [`local_auth`](https://pub.dev/packages/local_auth) — platform biometric authentication
