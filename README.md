# DIFM Attendance App

A Flutter attendance management app for DIFM with role-based login, policy acknowledgement, dashboards for Intern, HR, and Admin users, and basic shift assignment flows.

## Features

- Role-based login portal for Intern, HR, and Admin users
- Policy acceptance gate for interns with version tracking
- Intern dashboard with today's shift and attendance quick actions
- HR dashboard with attendance stats and shift assignment
- Admin dashboard with shift assignment and administrative action cards
- Shift assignment form with intern selection, shift type, and start/end time pickers
- Local shift persistence with `shared_preferences`
- Token and user session storage with `flutter_secure_storage`
- API service layer prepared for backend login, refresh, and logout endpoints

## Tech Stack

- Flutter
- Dart SDK `^3.11.5`
- `http` for API requests
- `shared_preferences` for local app preferences
- `flutter_secure_storage` for tokens and user details

## Project Structure

```text
lib/
  core/
    constants/       App colors, API constants, and policy text
    models/          Shared data models
    services/        API, auth, and storage services
    widgets/         Reusable dashboard widgets
  features/
    admin/           Admin dashboard
    auth/            Login, policy screen, and auth controller
    hr/              HR dashboard
    intern/          Intern dashboard
    shift/           Shift models, controllers, services, screens, and widgets
  routes/            App route definitions
  main.dart          App entry point
```

## Getting Started

### Prerequisites

- Flutter installed and configured
- Android Studio, Xcode, VS Code, or another Flutter-compatible IDE
- A connected device, emulator, simulator, or browser target

Check your Flutter setup:

```sh
flutter doctor
```

### Install Dependencies

```sh
flutter pub get
```

### Run the App

```sh
flutter run
```

To run on a specific platform:

```sh
flutter run -d chrome
flutter run -d windows
flutter run -d android
```

## Demo Login Credentials

The current login screen includes local demo credentials:

| Role | Email | Password |
| --- | --- | --- |
| Intern | `intern@difm.com` | `intern123` |
| HR | `hr@difm.com` | `hr123` |
| Admin | `admin@difm.com` | `admin123` |

Intern users are routed through the policy screen when the stored policy version does not match the current version in `PolicyConstants.currentPolicyVersion`.

## Backend Configuration

API endpoints are defined in:

```text
lib/core/constants/api_constants.dart
```

Update the backend base URL before using real API authentication:

```dart
static const String baseUrl = 'http://YOUR_IP:5000/api';
```

The app currently defines these auth paths:

- `/auth/login`
- `/auth/refresh`
- `/auth/logout`

`AuthService` expects login responses to include:

```json
{
  "accessToken": "...",
  "refreshToken": "...",
  "user": {
    "email": "...",
    "role": "...",
    "policyAccepted": true
  }
}
```

## Useful Commands

Analyze the project:

```sh
flutter analyze
```

Run tests:

```sh
flutter test
```

Format Dart files:

```sh
dart format lib test
```

Build a release APK:

```sh
flutter build apk --release
```

## Notes

- Shift assignment is currently stored locally through `SharedPreferences`.
- Several dashboard cards are placeholders and show "coming soon" messages.
- The login UI currently uses local demo credentials directly; the `AuthController` and `AuthService` are available for backend-based authentication.
- Policy version acceptance is stored locally, so changing `PolicyConstants.currentPolicyVersion` will require users to accept the policy again.
