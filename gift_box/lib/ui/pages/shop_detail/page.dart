import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/ada_audio/bloc.dart';
import 'package:gift_box/domain/blocs/hydrated_value/cubit.dart';
import 'package:gift_box/domain/blocs/music_tape/bloc.dart';
import 'package:gift_box/domain/blocs/shop_item/bloc.dart';
import 'package:gift_box/domain/blocs/shop_item_metas/bloc.dart';
import 'package:gift_box/domain/models/locale.dart';
import 'package:gift_box/domain/models/shop_item.dart';
import 'package:gift_box/domain/models/shop_item_id.dart';
import 'package:gift_box/domain/utils/extensions/build_context.dart';
import 'package:gift_box/injector.dart';
import 'package:gift_box/static/resources/sizes.dart';
import 'package:gift_box/ui/pages/shop_detail/confirmation_dialog.dart';
import 'package:gift_box/ui/widgets/asset_image.dart';
import 'package:gift_box/ui/widgets/coupon_display.dart';
import 'package:gift_box/ui/widgets/max_width_box.dart';
import 'package:go_router/go_router.dart';

// ignore_for_file: prefer-single-widget-per-file

class ShopDetailPage extends StatelessWidget {
  const ShopDetailPage({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return BlocProvider<ShopItemBloc>(
      create: (_) => ShopItemBloc()..add(ShopItemInitializeEvent(id)),
      child: BlocBuilder<ShopItemBloc, ShopItemState>(
        builder: (context, state) => switch (state) {
          ShopItemLoadInProgress() => Scaffold(
            appBar: AppBar(),
          ),
          ShopItemLoadOnSuccess(
            item: ShopItem(
              :final id,
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
                  child: MaxWidthBox(
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
                            onPressed: () => _onPressed(
                              context: context,
                              id: id,
                              name: name,
                              price: price,
                            ),
                            child: Text(_translations.checkOut),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        },
      ),
    );
  }

  Future<void> _onPressed({
    required BuildContext context,
    required String id,
    required String name,
    required int price,
  }) async {
    final hasBought = await ShopItemConfirmationDialog.show(
      context: context,
      name: name,
      price: price,
    );

    if (context.mounted && hasBought) {
      context
        ..read<ShopItemMetasBloc>().add(ShopItemMetasBuyEvent(id))
        ..read<AdaAudioBloc>().add(AdaAudioPlayUnlockEvent(id))
        ..pop();

      final cubit = context.read<HydratedIntCubit>();
      cubit.update(cubit.state - price);

      _applyShopItemEffect(context, id);
    }
  }

  void _applyShopItemEffect(BuildContext context, String id) {
    final shopItemId = ShopItemId.byId(id);
    switch (shopItemId) {
      case ShopItemId.darkMode:
        context.read<HydratedThemeModeCubit>().update(ThemeMode.dark);
      case ShopItemId.germanDrive:
        context.read<HydratedTranslationLocalePreferenceCubit>().update(
          TranslationLocalePreference.german,
        );
      case ShopItemId.musicTape:
        context.read<MusicTapeBloc>().add(const MusicTapePlayEvent());
      case ShopItemId.reset:
        context
          ..read<HydratedThemeModeCubit>().update(ThemeMode.light)
          ..read<HydratedTranslationLocalePreferenceCubit>().update(
            TranslationLocalePreference.english,
          )
          ..read<MusicTapeBloc>().add(const MusicTapeStopEvent())
          ..read<HydratedIntCubit>().update(
            10 -
                getPriceIfPurchased(
                  context,
                  ShopItemId.ada,
                ) -
                getPriceIfPurchased(
                  context,
                  ShopItemId.coffeeCup,
                ),
          );
      default:
        break;
    }
  }

  int getPriceIfPurchased(
    BuildContext context,
    ShopItemId id,
  ) => switch (context.read<ShopItemMetasBloc>().state) {
    ShopItemMetasLoadOnSuccess(:final metas) =>
      metas
              .firstWhereOrNull(
                (meta) => ShopItemId.byId(meta.id) == id && meta.isPurchased,
              )
              ?.price ??
          0,
    ShopItemMetasLoadInProgress() => 0,
  };

  static TranslationsPagesShopItemEn get _translations =>
      Injector.instance.translations.pages.shopItem;
}
