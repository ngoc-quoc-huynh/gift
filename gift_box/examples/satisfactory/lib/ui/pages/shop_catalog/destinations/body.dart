import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box_satisfactory/domain/blocs/shop_item_metas/bloc.dart';
import 'package:gift_box_satisfactory/domain/models/route.dart';
import 'package:gift_box_satisfactory/domain/models/shop_item_id.dart';
import 'package:gift_box_satisfactory/static/resources/sizes.dart';
import 'package:gift_box_satisfactory/ui/pages/shop_catalog/item.dart';

abstract class ShopDestination extends StatelessWidget {
  const ShopDestination({
    required this.ids,
    required this.detailRoute,
    super.key,
  });

  final List<ShopItemId> ids;
  final AppRoute detailRoute;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      ShopItemMetasBloc,
      ShopItemMetasState,
      ShopItemMetasState
    >(
      selector: (state) => switch (state) {
        ShopItemMetasLoadOnSuccess(:final metas) => ShopItemMetasLoadOnSuccess(
          metas
              .where((meta) => ids.contains(ShopItemId.byId(meta.id)))
              .toList(growable: false),
        ),
        _ => state,
      },
      builder: (context, state) => switch (state) {
        ShopItemMetasLoadInProgress() => const SizedBox.shrink(),
        ShopItemMetasLoadOnSuccess(:final metas) => ListView.builder(
          padding: const EdgeInsets.only(
            left: Sizes.horizontalPadding,
            right: Sizes.horizontalPadding,
            bottom: Sizes.verticalPadding,
            top: Sizes.verticalPadding * 2,
          ),
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(
              bottom: switch (index == metas.length - 1) {
                false => 50,
                true => 0,
              },
            ),
            child: ShopCatalogItem(
              meta: metas[index],
              detailRoute: detailRoute,
            ),
          ),
          itemCount: metas.length,
        ),
      },
    );
  }
}
