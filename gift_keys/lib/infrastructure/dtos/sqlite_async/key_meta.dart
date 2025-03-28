import 'package:equatable/equatable.dart';
import 'package:gift_keys/domain/models/key_meta.dart' as domain;

final class GiftKeyMeta extends Equatable {
  const GiftKeyMeta({
    required this.id,
    required this.name,
    required this.birthday,
  });

  factory GiftKeyMeta.fromJson(Map<String, dynamic> json) => switch (json) {
    {
      'id': final int id,
      'name': final String name,
      'birthday': final String birthday,
    } =>
      GiftKeyMeta(id: id, name: name, birthday: DateTime.parse(birthday)),
    _ => throw ArgumentError('Invalid json structure for GiftKeyMeta.'),
  };

  final int id;
  final String name;
  final DateTime birthday;

  domain.GiftKeyMeta toDomain() =>
      domain.GiftKeyMeta(id: id, name: name, birthday: birthday);

  @override
  List<Object?> get props => [id, name, birthday];
}
