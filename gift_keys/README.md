# gift_keys

Source code for the Gift Keys Flutter app.

## Prerequisites

### Flutter setup

We recommend using [asdf](https://asdf-vm.com/) as a version manager. Follow these steps to set up:

- Install [asdf](https://asdf-vm.com/guide/getting-started.html).
- Use the Flutter version specified in [.tool-versions](.tool-versions) by running this command:

```sh
asdf install
````

- Check whether your system is properly set up: `flutter doctor`

### Android setup

- Install the [Android SDK](https://developer.android.com/studio)
- Set environment variable `ANDROID_HOME` to the location of the SDK

### iOS setup

- Be a Mac OS user
- Install XCode
    - You'll need to be logged in with an Apple Developer account to download XCode
- Start XCode once and follow the instructions

## Code generation for translations

The app relies on code generation for translations. This is handled using the 
[slang](https://pub.dev/packages/slang) package.
A few parts of the app rely on automatic code generation. Translations generation can be executed at
once using [`slang`](#slang).

### slang

You can generate all the necessary translation files using:

```sh
make generate
```

## Code style

In our project, we follow a consistent code style to ensure readability, maintainability, and
collaboration among team members. Adhering to a unified code style not only improves code quality
but also enhances the overall development process.

To ensure adherence to our code style guidelines, we have developed custom lint rules and
metrics ([cosee_lints](https://pub.dev/packages/cosee_lints)).

To format and analyze the codebase, you can run the following command:

```sh
make style
```

## Tests

To execute the tests, run the following command in your terminal:

```sh
make test
```

### Golden tests

We utilize Golden Tests for our UI testing process. These tests are specifically designed to verify
the visual output of our application and guarantee consistent appearance across UI components, thus
mitigating any potential UI regression issues.

The golden files for our UI tests are located in the `test/ui/**/goldens` directory.

To update these golden files, simply execute the following command:

```sh
make update-goldens
```

This will update all golden files, so be careful when running this command to ensure that all
changes to the UI are intentional.

## Git hooks

We use [lefthook](https://github.com/evilmartians/lefthook) to run all coding convention checks as
git pre-commit/pre-push hook.

### Installation

To install lefthook run the following command:

```sh
brew install lefthook
```

### Usage

To initialize lefthook run the following command:

```sh
lefthook install
```

This will set up git pre-commit/pre-push hooks containing checks as configured
in [`lefthook.yaml`](lefthook.yaml).
