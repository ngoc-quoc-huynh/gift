import 'package:gift_keys/domain/interfaces/native.dart';
import 'package:gift_keys/domain/utils/mixins/logger.dart';
import 'package:url_launcher/url_launcher.dart';

final class NativeRepository with LoggerMixin implements NativeApi {
  @override
  Future<void> launchUri(Uri uri) async {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
    logInfo('Launched $uri');
  }
}
