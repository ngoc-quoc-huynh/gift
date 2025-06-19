import 'package:equatable/equatable.dart';
import 'package:gift_box/domain/models/asset.dart';

final class AwesomeShopItemMeta extends Equatable {
  const AwesomeShopItemMeta({
    required this.id,
    required this.name,
    required this.price,
    required this.asset,
    required this.height,
    required this.isPurchased,
  });

  final String id;
  final String name;
  final int price;
  final Asset asset;
  final double height;
  final bool isPurchased;

  AwesomeShopItemMeta copyWith({
    String? id,
    String? name,
    int? price,
    Asset? asset,
    double? height,
    bool? isPurchased,
  }) => AwesomeShopItemMeta(
    id: id ?? this.id,
    name: name ?? this.name,
    price: price ?? this.price,
    asset: asset ?? this.asset,
    height: height ?? this.height,
    isPurchased: isPurchased ?? this.isPurchased,
  );

  @override
  List<Object?> get props => [
    id,
    name,
    price,
    asset,
    height,
    isPurchased,
  ];
}
