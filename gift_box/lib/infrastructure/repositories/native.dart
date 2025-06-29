import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gift_box/domain/interfaces/native.dart';
import 'package:gift_box/domain/models/locale.dart';
import 'package:gift_box/injector.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

final class NativeRepository implements NativeApi {
  const NativeRepository(this.widgetsBinding);

  final WidgetsBinding widgetsBinding;

  static final _loggerApi = Injector.instance.loggerApi;

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
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    _loggerApi.logInfo('Opened ${uri.path}');
  }

  static const _assetDir = 'assets';

  @override
  Future<List<String>> loadImagePaths() async {
    final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);

    return assetManifest
        .listAssets()
        .where(
          (string) => string.startsWith(join(_assetDir, 'images', 'carousel')),
        )
        .toList();
  }
}
