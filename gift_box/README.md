# gift_box

Shared Flutter package for gift box domain logic and infrastructure.

## Structure

- `lib/` contains the public package API exported by `package:gift_box/gift_box.dart`.
- `examples/satisfactory/` is the example application that consumes this package.

## Usage

Add the package to an app and import:

```dart
import 'package:gift_box/gift_box.dart';
```

This package currently exposes:

- domain models and interfaces
- NFC infrastructure
- logger infrastructure
