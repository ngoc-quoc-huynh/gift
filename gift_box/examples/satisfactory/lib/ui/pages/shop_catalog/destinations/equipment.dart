import 'package:gift_box_satisfactory/domain/models/route.dart';
import 'package:gift_box_satisfactory/domain/models/shop_item_id.dart';
import 'package:gift_box_satisfactory/ui/pages/shop_catalog/destinations/body.dart';

class ShopEquipmentDestination extends ShopDestination {
  const ShopEquipmentDestination({super.key})
    : super(
        ids: const [ShopItemId.coffeeCup],
        detailRoute: AppRoute.shopEquipmentDetail,
      );
}
