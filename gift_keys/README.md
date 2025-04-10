# Gift Keys

[![build status](https://github.com/ngoc-quoc-huynh/gift/actions/workflows/gift_keys.yaml/badge.svg?branch=main)](https://github.com/ngoc-quoc-huynh/gift/actions/workflows/gift_keys.yaml?query=branch%3Amain)
[![style](https://img.shields.io/badge/style-cosee__lints-brightgreen)](https://pub.dev/packages/cosee_lints)
[![license](https://img.shields.io/github/license/ngoc-quoc-huynh/gift)](https://raw.githubusercontent.com/ngoc-quoc-huynh/gift/refs/heads/main/LICENSE)

## Overview

The Gift Keys App is a Flutter application that allows users to manage digital keys unlock the Gifts
from [Gift Box](../gift_box). Users can **add new keys** by providing an **AID (Application
Identifier)**, a **password (PIN)**, and additional metadata. The app interacts with the
**Gift Box** project, which uses **NFC Host Card Emulation (HCE)**. When scanned, the Gift Keys App
transmits the stored AID and PIN for verification, enabling secure access to the associated gift.

## Getting Started

### asdf

We are using [asdf](https://asdf-vm.com/) to manage the dependencies. Make sure you have it
installed and then run the following command to install the required versions:

```bash
asdf install
```

If you don't have asdf installed or prefer not to use it, you can
install [Flutter](https://docs.flutter.dev/) directly by following the
official[Flutter installation guide](https://docs.flutter.dev/get-started/install). Make sure to use
the version specified in the [.tool-versions ](../.tool-versions) file to avoid compatibility
issues.

### Code generation for translations

We are using [slang](https://pub.dev/packages/slang) to manage the translations.

Run the following command to generate the translations:

```bash
make i18n
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

### Code style enforcement with lefthook

To automatically format staged code before committing, we
use [lefthook](https://github.com/evilmartians/lefthook) as a pre-commit hook.
Our configuration ensures that only staged Dart files in the app directory are formatted with dart
format.

```sh
lefthook install
```

## Create a release APK

To generate a release APK for your application, follow the steps below:

1. Create a `key.properties` file in the android root directory. Use the
   [`key.example.properties`](android/key.example.properties) file as a template:

   ```sh
   cp android/key.example.properties android/key.properties
   ```
2. Create a `keystore` file:
   - **Option 1**: Using Android Studio

     You can generate a keystore directly from Android Studio by following
     the [official guide](https://developer.android.com/studio/publish/app-signing#generate-key).
   - **Option 2**: Using the Command Line

     Alternatively, use the `keytool` command to generate a keystore:
      ```sh
     make jks 
     ```
3. Create an environment on  [GitHub](https://github.com) with `gift_keys` as name (optional, for
   GitHub Actions):
4. Set up secrets in GitHub (optional, for GitHub Actions):

   Next, you need to set up the following secrets in your GitHub repository:

   - **KEY_PASSWORD**: The password for the key.
   - **STORE_PASSWORD**: The password for the keystore.
   - **KEY_ALIAS**: The alias of the key, by default it is `gift_keys`.
   - **KEYSTORE**: The base64-encoded version of your keystore file.

### Encoding the keystore file

1. Run the following command to encode your [`gift_keys.jks`](android/app/gift_keys.jks) file:

   ```sh
   make encode-jks
   ```

2. Copy the content, and then paste it into the `KEYSTORE` secret on GitHub.

### Generate the release APK

Once your `keystore` and `key.properties` are set up, you can generate the release APK by running
the following command:

```sh
make apk
```

## Tests

To execute the tests, run the following command in your terminal:

```sh
make test
```

This will run the test in random order.
If you want to specify a seed for randomizing the test order, you can use the following command:

```sh
make test seed=1
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
