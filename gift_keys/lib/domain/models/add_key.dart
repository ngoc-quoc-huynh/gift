import 'package:equatable/equatable.dart';

final class AddGiftKey extends Equatable {
  const AddGiftKey({
    required this.imagePath,
    required this.name,
    required this.birthday,
    required this.aid,
    required this.password,
  });

  final String imagePath;
  final String name;
  final DateTime birthday;
  final String aid;
  final String password;

  @override
  List<Object?> get props => [imagePath, name, birthday, aid, password];
}
