import 'package:equatable/equatable.dart';
import 'package:gift_box/domain/models/asset.dart';

final class ShopItem extends Equatable {
  const ShopItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.asset,
    required this.height,
  });

  final String id;
  final String name;
  final String description;
  final int price;
  final Asset asset;
  final double height;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    asset,
    height,
  ];
}
