# Clean Architecture Flutter

A friendly Flutter CRUD demo that shows how clean architecture feels in a small posts app.

## What you'll find

- Feature-first folders split into presentation, domain, and data layers.
- BLoC + GetIt wiring for predictable state and dependency injection.
- Remote posts via JSONPlaceholder with SharedPreferences caching and connection checks.
- Pull-to-refresh list plus add, update, and delete flows with feedback.

## Quickstart

1. Install Flutter 3.x and a device/emulator.
2. Fetch packages: `flutter pub get`.
3. Run the app: `flutter run -d <device-id>`.
4. Need fresh data? Pull down on the posts list to refresh.

## Project map

- `lib/main.dart` boots the app theme and BLoC providers, then opens `PostsPage`.
- `lib/injection_container.dart` registers use cases, repositories, data sources, and externals.
- `lib/features/posts/` holds the entire posts feature (data/domain/presentation).
- `lib/core/` keeps shared styling, network helpers, widgets, and exceptions.

## Configuration notes

- API base: <https://jsonplaceholder.typicode.com>
- Cached posts key: `CACHED_POSTS` (see `post_local_data_sources.dart`).
- Connectivity checks rely on `internet_connection_checker`.

## Extending the app

- Mirror the posts layers for new features and register them in `injection_container.dart`.
- Swap the backend by changing `BASE_URL` and updating the models/use cases to match.
