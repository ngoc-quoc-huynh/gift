import 'package:gift_box/domain/models/locale.dart';

abstract interface class NativeApi {
  const NativeApi();

  TranslationLocale get locale;

  Future<void> openUrl(Uri uri);

  Future<List<String>> loadImagePaths();

  Future<List<String>> loadMusicTape();

  Future<void> vibrate();
}
