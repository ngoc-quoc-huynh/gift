import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/awesome_shop_item/bloc.dart';
import 'package:gift_box/domain/models/awesome_shop_item.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/static/resources/sizes.dart';
import 'package:gift_box/ui/widgets/asset_image.dart';
import 'package:gift_box/ui/widgets/coupon_display.dart';
import 'package:go_router/go_router.dart';

class AwesomeShopItemPage extends StatelessWidget {
  const AwesomeShopItemPage({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return BlocProvider<AwesomeShopItemBloc>(
      create: (_) =>
          AwesomeShopItemBloc()..add(AwesomeShopItemInitializeEvent(id)),
      child: BlocBuilder<AwesomeShopItemBloc, AwesomeShopItemState>(
        builder: (context, state) => switch (state) {
          AwesomeShopItemLoadInProgress() => Scaffold(
            appBar: AppBar(),
          ),
          AwesomeShopItemLoadOnSuccess(
            item: AwesomeShopItem(
              :final name,
              :final description,
              :final price,
              :final asset,
              :final height,
            ),
          ) =>
            Scaffold(
              appBar: AppBar(
                title: Text(name),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.horizontalPadding,
                    vertical: Sizes.verticalPadding,
                  ),
                  child: Column(
                    spacing: 20,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: height),
                        child: CustomAssetImage(
                          asset: asset,
                          height: height,
                        ),
                      ),
                      Text(
                        description,
                        style: textTheme.bodyLarge,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _translations.price,
                            style: textTheme.headlineMedium,
                          ),
                          CouponDisplay.large(amount: price),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () => context.pop(),
                          child: Text(_translations.checkOut),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        },
      ),
    );
  }

  static TranslationsPagesAwesomeShopItemEn get _translations =>
      Injector.instance.translations.pages.awesomeShopItem;
}
