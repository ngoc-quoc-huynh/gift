part of 'cubit.dart';

class ImageCarouselState extends Equatable {
  const ImageCarouselState({required this.index, required this.isReverse});

  final int index;
  final bool isReverse;

  @override
  List<Object?> get props => [index, isReverse];
}
