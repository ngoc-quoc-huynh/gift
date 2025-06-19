import 'package:flutter/material.dart' hide Route;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_box/domain/blocs/awesome_shop_item_metas/bloc.dart';
import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/static/resources/sizes.dart';
import 'package:gift_box/ui/pages/awesome_shop_catalog/item.dart';

abstract class AwesomeShopDestination<Bloc extends AwesomeShopItemMetasBloc>
    extends StatelessWidget {
  const AwesomeShopDestination({
    required this.detailRoute,
    super.key,
  });

  final AppRoute detailRoute;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Bloc, AwesomeShopItemMetasState>(
      builder: (context, state) => switch (state) {
        AwesomeShopItemMetasLoadInProgress() => const SizedBox.shrink(),
        AwesomeShopItemMetasLoadOnSuccess(:final metas) => ListView.builder(
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
            child: AwesomeShopCatalogItem(
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
