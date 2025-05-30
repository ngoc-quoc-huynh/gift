import 'package:gift_box/domain/blocs/awesome_shop_item_metas/bloc.dart';
import 'package:gift_box/domain/models/route.dart';
import 'package:gift_box/ui/pages/awesome_shop_catalog/destinations/body.dart';

class AwesomeShopSpecialsDestination extends AwesomeShopDestination {
  const AwesomeShopSpecialsDestination({super.key})
    : super(
        createBloc: AwesomeShopItemMetasSpecialsBloc.new,
        detailRoute: AppRoute.awesomeShopSpecialsDetail,
      );
}
