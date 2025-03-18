import 'package:flutter/material.dart';
import 'package:gift_keys/domain/utils/extensions/build_context.dart';
import 'package:gift_keys/injector.dart';
import 'package:gift_keys/ui/router/routes.dart';
import 'package:gift_keys/ui/widgets/form_field/fade_out.dart';

class KeyAddButton extends StatelessWidget {
  const KeyAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = context.colorScheme.primary;

    return FadeBox(
      child: ActionChip(
        onPressed: () => context.goRoute(Routes.addKeyPage),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: primaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        padding: const EdgeInsets.all(20),
        label: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(radius: 30, child: Icon(Icons.add, size: 50)),
            const SizedBox(height: 10),
            Text(
              Injector.instance.translations.pages.keys.add,
              style: context.textTheme.headlineMedium?.copyWith(
                color: primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
