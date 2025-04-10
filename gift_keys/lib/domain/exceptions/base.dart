import 'package:equatable/equatable.dart';

abstract base class CustomException extends Equatable implements Exception {
  const CustomException();

  @override
  List<Object?> get props => [];
}
