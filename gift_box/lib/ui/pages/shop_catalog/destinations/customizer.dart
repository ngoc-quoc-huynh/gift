import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/domain/models/shop_item_id.dart';
import 'package:gift_box/ui/pages/shop_catalog/destinations/body.dart';

class ShopCustomizerDestination extends ShopDestination {
  const ShopCustomizerDestination({super.key})
    : super(
        ids: const [ShopItemId.darkMode, ShopItemId.germanDrive],
        detailRoute: AppRoute.shopCustomizerDetail,
      );
}
