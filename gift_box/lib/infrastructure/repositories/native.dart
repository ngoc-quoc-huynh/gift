import 'package:gift_box/domain/interfaces/native.dart';
import 'package:url_launcher/url_launcher.dart';

final class NativeRepository implements NativeApi {
  const NativeRepository();

  @override
  Future<void> openUrl(Uri uri) => launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  );
}
