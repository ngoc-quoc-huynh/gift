import 'package:gift_box/domain/blocs/shop_item_metas/bloc.dart';
import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/ui/pages/shop_catalog/destinations/body.dart';

class ShopEquipmentDestination
    extends ShopDestination<ShopItemMetasEquipmentBloc> {
  const ShopEquipmentDestination({super.key})
    : super(detailRoute: AppRoute.shopEquipmentDetail);
}
