import 'package:equatable/equatable.dart';

final class GiftKey extends Equatable {
  const GiftKey({
    required this.id,
    required this.name,
    required this.birthday,
    required this.aid,
    required this.password,
  });

  final int id;
  final String name;
  final DateTime birthday;
  final String aid;
  final String password;

  @override
  List<Object?> get props => [id, name, birthday, aid, password];
}
