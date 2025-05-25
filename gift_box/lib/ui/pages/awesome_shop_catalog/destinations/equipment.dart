import 'package:gift_box/domain/blocs/awesome_shop_item_metas/bloc.dart';
import 'package:gift_box/ui/pages/awesome_shop_catalog/destinations/body.dart';

class AwesomeShopEquipmentDestination extends AwesomeShopDestination {
  const AwesomeShopEquipmentDestination({super.key})
    : super(createBloc: AwesomeShopItemMetasEquipmentBloc.new);
}
