import 'package:gift_box/domain/blocs/awesome_shop_item_metas/bloc.dart';
import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/ui/pages/awesome_shop_catalog/destinations/body.dart';

class AwesomeShopCustomizerDestination extends AwesomeShopDestination {
  const AwesomeShopCustomizerDestination({super.key})
    : super(
        createBloc: AwesomeShopItemMetasCustomizerBloc.new,
        detailRoute: AppRoute.awesomeShopCustomizerDetail,
      );
}
