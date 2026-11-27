# Architecture

Three layers. Dependencies point toward `domain`.

## Layers

| Layer            | Contains                                                      | May import                                                                |
|------------------|---------------------------------------------------------------|---------------------------------------------------------------------------|
| `domain`         | models, repository interfaces, use cases, exceptions          | Dart SDK, pure Dart packages (`equatable`, `collection`, `meta`, `clock`) |
| `infrastructure` | repository implementations, DTOs                              | `domain`, sqlite, `nfc_manager`, `file`, plugins                          |
| `ui`             | cubits, blocs, pages, widgets, router, utils                  | `domain`, `static`, Flutter, bloc, `material_ui`, `injector.dart` (only in `BlocProvider.create`) |
| `static`         | build-time constants, resources, generated slang translations | Flutter                                                                   |

`injector.dart` is the only file that knows all layers.

```
lib/
  domain/
    exceptions/        <area>_exception.dart
    models/            <model>.dart
    repositories/      <concept>_repository.dart
    use_cases/         <verb>_<noun>_use_case.dart
    utils/             pure Dart helpers and extensions
  infrastructure/
    dtos/              <model>_dto.dart
    repositories/      <technology>_<concept>_repository.dart
  static/
    i18n/
    resources/
    config.dart
  ui/
    blocs/             <name>_cubit.dart (+ part <name>_state.dart)
                       <name>_bloc.dart (+ part <name>_event.dart, <name>_state.dart)
    pages/<name>/      <name>_page.dart, page-specific widgets
    router/
    utils/             UI helpers and extensions
    widgets/
  injector.dart
  main.dart
```

Files are named after their main class in `snake_case`. `utils/` holds stateless helpers and extensions; feature logic
belongs in its building block.

## Where code goes

| Task                                        | Place                                      |
|---------------------------------------------|--------------------------------------------|
| Database, files, NFC, platform, logging     | Repository                                 |
| Rows or JSON to model                       | DTO                                        |
| Business rule, sorting, validation          | Domain model or `domain/utils`             |
| Any action or observed stream a cubit needs | Use case                                   |
| Data shared between cubits                  | Repository `Stream`, observed via use case |
| Loading, success, failure state             | Cubit or bloc                              |
| Text, color, icon, size, formatting         | UI and `static`                            |
| Navigation, dialog, snackbar                | UI (`BlocListener`)                        |

## Building blocks

**Repository:** Interface named after the domain concept (`<Concept>Repository`), implementation prefixed with its
technology (`<Technology><Concept>Repository`). Converts DTOs to models, logs failures, and translates every technical
error to an `AppException`. Streams emit the current value on listen.

**DTO:** Suffix `Dto`. Fields plus `fromJson`, `toJson`, `toDomain`, `fromDomain`. `fromJson` validates with pattern
matching and throws `FormatException`.

**Model:** Business data and rules, `Equatable`. Knows no JSON or rows.

**Use case:** Every cubit action and every stream a cubit observes goes through a use case. One action per class with a
single `call()`. Depends on repository interfaces only.

**Cubit / bloc:** Cubit by default. Bloc when events need a transformer (`droppable`, `restartable`, debounce), e.g. NFC
streams. Receives use cases via constructor. Emits sealed states and catches `AppException` subtypes. Text, navigation
and `BuildContext` stay in the UI. Cubits communicate only through repository streams. UI preferences (theme,
language) use `HydratedCubit` directly, without use case or repository.

**UI:** The page provides the cubit via `BlocProvider(create: (_) => Injector.instance<XCubit>())`. Widgets
render with `BlocBuilder` and an exhaustive `switch` over the sealed state. One-off actions use `BlocListener`.

## Errors

- Exceptions extend `AppException` (abstract base, `Equatable`), one file per area.
- Repositories catch the technology's exception and `FormatException`, log, then call
  `Error.throwWithStackTrace(const XException(), stackTrace)`.
- Expected cases get their own exception, e.g. `UserNotFoundException`.
- Bugs (`Error` subclasses) propagate to the handlers in `main.dart` (`PlatformDispatcher.instance.onError`,
  `FlutterError.onError`, `BlocObserver`), which log them.

## Dependency injection

get_it, registered in `injector.dart` and read only there and in `BlocProvider.create`. Every other class receives its
dependencies via constructor. Repositories are lazy singletons, or async singletons awaited with `allReady()` when they
need initialization. Use cases, cubits and blocs are factories.

## Example

```dart
// domain/use_cases/watch_user_use_case.dart
final class WatchUserUseCase {
  const WatchUserUseCase(this._userRepository);

  final UserRepository _userRepository;

  Stream<User> call(int id) => _userRepository.watchUser(id);
}

// ui/blocs/user_cubit.dart
final class UserCubit extends Cubit<UserState> {
  UserCubit(this._watchUser) : super(const UserLoadInProgress());

  final WatchUserUseCase _watchUser;
  StreamSubscription<User>? _subscription;

  Future<void> watch(int id) async {
    await _subscription?.cancel();
    _subscription = _watchUser(id).listen(
      (user) => emit(UserLoadOnSuccess(user)),
      onError: (Object error, StackTrace stackTrace) {
        if (error is! AppException) Error.throwWithStackTrace(error, stackTrace);
        emit(const UserLoadOnFailure());
      },
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}

// infrastructure/repositories/sqlite_user_repository.dart
final class SqliteUserRepository implements UserRepository {
  const SqliteUserRepository(this._db, this._loggerRepository);

  final SqliteDatabase _db;
  final LoggerRepository _loggerRepository;

  @override
  Future<User> loadUser(int id) async {
    try {
      final row = await _db.getOptional('SELECT id, name, birthday FROM users WHERE id = ?', [id]);
      if (row == null) throw const UserNotFoundException();

      return UserDto.fromJson(row).toDomain();
    } on SqliteException catch (e, stackTrace) {
      _fail('Failed to load user.', e, stackTrace);
    } on FormatException catch (e, stackTrace) {
      _fail('Failed to load user.', e, stackTrace);
    }
  }

  Never _fail(String message, Exception e, StackTrace stackTrace) {
    _loggerRepository.logException(message, exception: e, stackTrace: stackTrace);
    Error.throwWithStackTrace(const UserStorageException(), stackTrace);
  }
}

// infrastructure/dtos/user_dto.dart
factory UserDto.fromJson(Map<String, dynamic> json) => switch (json) {
  {'id': final int id, 'name': final String name, 'birthday': final String birthday} =>
    UserDto(id: id, name: name, birthday: DateTime.parse(birthday)),
  _ => throw const FormatException('Invalid json structure for UserDto.'),
};
```

## Tests

Each layer is tested in isolation: use cases with mocked repositories, cubits with mocked use cases, widgets with mock
cubits.

Existing code may differ. New and changed code follows this document.
