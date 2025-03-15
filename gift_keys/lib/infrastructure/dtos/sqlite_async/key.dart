import 'package:equatable/equatable.dart';
import 'package:gift_keys/domain/models/key.dart' as domain;

final class GiftKey extends Equatable {
  const GiftKey({
    required this.id,
    required this.imageFileName,
    required this.name,
    required this.birthday,
    required this.aid,
    required this.password,
  });

  factory GiftKey.fromJson(Map<String, dynamic> json) => switch (json) {
    {
      'id': final int id,
      'imageFileName': final String imageFileName,
      'name': final String name,
      'birthday': final String birthday,
      'aid': final String aid,
      'password': final String password,
    } =>
      GiftKey(
        id: id,
        imageFileName: imageFileName,
        name: name,
        birthday: DateTime.parse(birthday),
        aid: aid,
        password: password,
      ),
    _ => throw ArgumentError('Invalid json structure for GiftKey.'),
  };

  final int id;
  final String imageFileName;
  final String name;
  final DateTime birthday;
  final String aid;
  final String password;

  domain.GiftKey toDomain() => domain.GiftKey(
    id: id,
    imageFileName: imageFileName,
    name: name,
    birthday: birthday,
    aid: aid,
    password: password,
  );

  @override
  List<Object?> get props => [id, imageFileName, name, birthday, aid, password];
}
