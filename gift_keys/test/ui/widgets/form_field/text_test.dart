import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_keys/ui/widgets/form_field/text.dart';

import '../../../utils.dart';

void main() {
  testGolden('renders correctly.', (tester) async {
    final widget = CustomTextFormField(
      icon: Icons.person,
      label: 'Name',
      textInputAction: TextInputAction.done,
      validator: (_) => null,
    );
    await tester.pumpGoldenWidget(widget);

    await expectGoldenFile('text', find.byWidget(widget));
  }, surfaceSize: const Size(250, 50));

  testWidgets('submits correctly.', (tester) async {
    bool submitted = false;
    final widget = MaterialApp(
      home: Material(
        child: CustomTextFormField(
          icon: Icons.person,
          label: 'Name',
          textInputAction: TextInputAction.done,
          validator: (_) => null,
          onSubmitted: () => submitted = true,
        ),
      ),
    );
    await tester.pumpWidget(widget);
    await tester.enterText(find.byType(TextField), 'test');
    await tester.testTextInput.receiveAction(TextInputAction.done);

    expect(submitted, isTrue);
  });
}
