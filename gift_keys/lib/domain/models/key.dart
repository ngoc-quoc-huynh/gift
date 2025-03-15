import 'package:equatable/equatable.dart';

final class GiftKey extends Equatable {
  const GiftKey({
    required this.id,
    required this.imageFileName,
    required this.name,
    required this.birthday,
    required this.aid,
    required this.password,
  });

  final int id;
  final String imageFileName;
  final String name;
  final DateTime birthday;
  final String aid;
  final String password;

  @override
  List<Object?> get props => [id, imageFileName, name, birthday, aid, password];
}
