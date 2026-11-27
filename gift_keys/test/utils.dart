import 'package:gift_keys/static/resources/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class TestGoRouter extends StatelessWidget {
  const TestGoRouter({required this.onTestSetup, super.key});

  final void Function(BuildContext) onTestSetup;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: CustomTheme.lightTheme(const TextTheme()),
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, _) {
              onTestSetup.call(context);

              return const Scaffold();
            },
          ),
        ],
      ),
    );
  }
}
