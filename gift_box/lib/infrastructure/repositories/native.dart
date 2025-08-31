import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gift_box/domain/interfaces/native.dart';
import 'package:gift_box/domain/models/locale.dart';
import 'package:gift_box/injector.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

final class NativeRepository implements NativeApi {
  const NativeRepository(this.widgetsBinding);

  final WidgetsBinding widgetsBinding;

  static final _loggerApi = Injector.instance.loggerApi;

  static const _imagePath = 'assets/images/carousel';
  static const _imageType = '.webp';
  static const _musicTapePath = 'assets/audios/music_tape';
  static const _musicType = '.m4a';

  @override
  TranslationLocale get locale {
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    final translationsLocale = switch (locale.languageCode) {
      final code when code.startsWith('de') => TranslationLocale.german,
      _ => TranslationLocale.english,
    };
    _loggerApi.logInfo('Retrieved system locale: $translationsLocale.');

    return translationsLocale;
  }

  @override
  Future<void> openUrl(Uri uri) async {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
    _loggerApi.logInfo('Opened URL: $uri');
  }

  @override
  Future<List<String>> loadImagePaths() => _loadAssetPaths(
    prefix: _imagePath,
    suffix: _imageType,
  );

  @override
  Future<List<String>> loadMusicTape() => _loadAssetPaths(
    prefix: _musicTapePath,
    suffix: _musicType,
  );

  Future<List<String>> _loadAssetPaths({
    required String prefix,
    required String suffix,
  }) async {
    final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);

    return assetManifest
        .listAssets()
        .where((asset) => asset.startsWith(prefix) && asset.endsWith(suffix))
        .toList();
  }

  @override
  Future<void> vibrate() => Vibration.vibrate(duration: 50);
}
