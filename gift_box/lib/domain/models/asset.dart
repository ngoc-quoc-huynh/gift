import 'package:path/path.dart';

enum Asset {
  gift('rive/gift.riv')
  ,
  satisfactory('rive/satisfactory.riv');

  const Asset(this.path);

  final String path;

  static const _assetDir = 'assets';

  String call() => join(_assetDir, path);
}
