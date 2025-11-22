import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/domain/models/shop_item_id.dart';
import 'package:gift_box/ui/pages/shop_catalog/destinations/body.dart';

class ShopSpecialsDestination extends ShopDestination {
  const ShopSpecialsDestination({super.key})
    : super(
        ids: const [
          ShopItemId.ada,
          ShopItemId.musicTape,
          ShopItemId.reset,
        ],
        detailRoute: AppRoute.shopSpecialsDetail,
      );
}
