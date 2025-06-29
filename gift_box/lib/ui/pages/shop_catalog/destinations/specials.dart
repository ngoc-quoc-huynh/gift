import 'package:gift_box/domain/blocs/shop_item_metas/bloc.dart';
import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/ui/pages/shop_catalog/destinations/body.dart';

class ShopSpecialsDestination
    extends ShopDestination<ShopItemMetasSpecialsBloc> {
  const ShopSpecialsDestination({super.key})
    : super(detailRoute: AppRoute.shopSpecialsDetail);
}
