import 'package:equatable/equatable.dart';
import 'package:gift_box/domain/models/ada_audio.dart';
import 'package:gift_box/domain/models/asset.dart';
import 'package:gift_box/domain/models/awesome_shop_item.dart';
import 'package:gift_box/domain/models/awesome_shop_item_meta.dart';

final class RawAwesomeShopItem extends Equatable {
  const RawAwesomeShopItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.asset,
    required this.metaHeight,
    required this.height,
    required this.audio,
  });

  final String id;
  final String name;
  final String description;
  final int price;
  final Asset asset;
  final double metaHeight;
  final double height;
  final AdaAudio audio;

  AwesomeShopItemMeta toMeta({required bool isPurchased}) =>
      AwesomeShopItemMeta(
        id: id,
        name: name,
        price: price,
        asset: asset,
        height: metaHeight,
        isPurchased: isPurchased,
      );

  AwesomeShopItem toItem() => AwesomeShopItem(
    id: id,
    name: name,
    description: description,
    price: price,
    asset: asset,
    height: height,
  );

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    asset,
    metaHeight,
    height,
    audio,
  ];
}
