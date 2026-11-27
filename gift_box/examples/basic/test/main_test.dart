import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box_basic/main.dart';

void main() {
  testWidgets('renders app title', (tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('Gift Box'), findsOneWidget);
  });
}
