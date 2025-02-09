import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/domain/models/asset.dart';

void main() {
  test(
    'call returns correctly.',
    () => expect(Asset('test.jpg')(), 'test.jpg'),
  );
}
