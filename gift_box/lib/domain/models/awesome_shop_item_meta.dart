import 'package:equatable/equatable.dart';
import 'package:gift_box/domain/models/asset.dart';

final class AwesomeShopItemMeta extends Equatable {
  const AwesomeShopItemMeta({
    required this.id,
    required this.name,
    required this.price,
    required this.asset,
    required this.height,
  });

  final String id;
  final String name;
  final int price;
  final Asset asset;
  final double height;

  @override
  List<Object?> get props => [
    id,
    name,
    price,
    asset,
    height,
  ];
}
