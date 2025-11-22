import 'package:equatable/equatable.dart';
import 'package:gift_box_satisfactory/domain/models/asset.dart';

final class AdaAudio extends Equatable {
  const AdaAudio(this.asset, this.transcript);

  final Asset asset;
  final List<TranscriptSegment> transcript;

  @override
  List<Object?> get props => [asset, transcript];
}

final class TranscriptSegment extends Equatable {
  const TranscriptSegment(this.text, [this.offset = Duration.zero]);

  final String text;
  final Duration offset;

  @override
  List<Object?> get props => [text, offset];
}
