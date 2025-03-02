import 'dart:io';

import 'package:equatable/equatable.dart';

final class GiftKey extends Equatable {
  const GiftKey({
    required this.image,
    required this.name,
    required this.birthday,
    required this.aid,
    required this.password,
  });

  final File image;
  final String name;
  final DateTime birthday;
  final String aid;
  final String password;

  @override
  // ignore: list-all-equatable-fields, we can only determine the file path.
  List<Object?> get props => [image.path, name, birthday, aid, password];
}
