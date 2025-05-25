import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:gift_box/domain/models/asset.dart';
import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/static/resources/sizes.dart';
import 'package:gift_box/ui/widgets/rive_player.dart';

class AwesomeShopPage extends StatelessWidget {
  const AwesomeShopPage({super.key});

  static const _typerAnimationSpeed = Duration(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextTheme.of(context).headlineLarge;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => context.goRoute(AppRoute.awesomeShopCatalog),
        child: Stack(
          children: [
            RivePlayer(
              asset: Asset.satisfactory(),
              artboardName: 'Awesome Shop',
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.horizontalPadding,
                  vertical: Sizes.verticalPadding,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedTextKit(
                    repeatForever: true,
                    pause: const Duration(seconds: 3),
                    animatedTexts: [
                      TyperAnimatedText(
                        _translations.volumeUp,
                        textStyle: textStyle,
                        speed: _typerAnimationSpeed,
                      ),
                      TyperAnimatedText(
                        _translations.tap,
                        textAlign: TextAlign.center,
                        textStyle: textStyle,
                        speed: _typerAnimationSpeed,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static TranslationsPagesAwesomeShopEn get _translations =>
      Injector.instance.translations.pages.awesomeShop;
}
