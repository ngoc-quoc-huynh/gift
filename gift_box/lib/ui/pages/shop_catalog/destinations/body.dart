import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/shop_item_metas/bloc.dart';
import 'package:gift_box/domain/blocs/shop_item_metas_reset/bloc.dart'
    hide ShopItemMetasResetEvent;
import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/static/resources/sizes.dart';
import 'package:gift_box/ui/pages/shop_catalog/item.dart';

abstract class ShopDestination<Bloc extends ShopItemMetasBloc>
    extends StatelessWidget {
  const ShopDestination({
    required this.detailRoute,
    super.key,
  });

  final AppRoute detailRoute;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShopItemMetasResetBloc, ShopItemMetasResetState>(
      listener: _onShopItemMetasResetStateChanged,
      child: BlocBuilder<Bloc, ShopItemMetasState>(
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
      ),
    );
  }

  void _onShopItemMetasResetStateChanged(
    BuildContext context,
    ShopItemMetasResetState _,
  ) => context.read<Bloc>().add(const ShopItemMetasResetEvent());
}
