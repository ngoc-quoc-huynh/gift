import 'package:equatable/equatable.dart';
import 'package:gift_box_satisfactory/domain/models/ada_audio.dart';
import 'package:gift_box_satisfactory/domain/models/asset.dart';
import 'package:gift_box_satisfactory/domain/models/shop_item.dart';
import 'package:gift_box_satisfactory/domain/models/shop_item_meta.dart';

final class RawShopItem extends Equatable {
  const RawShopItem({
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

  ShopItemMeta toMeta({required bool isPurchased}) => ShopItemMeta(
    id: id,
    name: name,
    price: price,
    asset: asset,
    height: metaHeight,
    isPurchased: isPurchased,
  );

  ShopItem toItem() => ShopItem(
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
