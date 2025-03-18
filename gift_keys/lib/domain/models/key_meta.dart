import 'package:equatable/equatable.dart';

final class GiftKeyMeta extends Equatable {
  const GiftKeyMeta({
    required this.id,
    required this.name,
    required this.birthday,
  });

  final int id;
  final String name;
  final DateTime birthday;

  @override
  List<Object?> get props => [id, name, birthday];
}
