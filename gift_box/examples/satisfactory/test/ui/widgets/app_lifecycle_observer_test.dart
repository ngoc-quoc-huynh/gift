import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_box/ui/widgets/app_lifecycle_observer.dart';

void main() {
  testWidgets('calls onResume when app resumes.', (tester) async {
    bool wasCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: AppLifecycleObserver(
          onResume: () => wasCalled = true,
          child: const Scaffold(),
        ),
      ),
    );
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();

    expect(wasCalled, isTrue);
  });
}
