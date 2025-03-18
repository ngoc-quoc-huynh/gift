import 'package:equatable/equatable.dart';
import 'package:gift_keys/domain/models/key_meta.dart' as domain;

final class GiftKeyMeta extends Equatable {
  const GiftKeyMeta({
    required this.id,
    required this.imageFileName,
    required this.name,
    required this.birthday,
  });

  factory GiftKeyMeta.fromJson(Map<String, dynamic> json) => switch (json) {
    {
      'id': final int id,
      'imageFileName': final String imageFileName,
      'name': final String name,
      'birthday': final String birthday,
    } =>
      GiftKeyMeta(
        id: id,
        imageFileName: imageFileName,
        name: name,
        birthday: DateTime.parse(birthday),
      ),
    _ => throw ArgumentError('Invalid json structure for GiftKey.'),
  };

  final int id;
  final String imageFileName;
  final String name;
  final DateTime birthday;

  domain.GiftKeyMeta toDomain() => domain.GiftKeyMeta(
    id: id,
    imageFileName: imageFileName,
    name: name,
    birthday: birthday,
  );

  @override
  List<Object?> get props => [id, imageFileName, name, birthday];
}
