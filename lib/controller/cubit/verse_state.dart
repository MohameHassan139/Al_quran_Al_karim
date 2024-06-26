// part of 'verse_cubit.dart';

// @immutable
// abstract class VerseState {}

// class VerseInitial extends VerseState {}

// class AduioPlaying extends VerseState {}

// class AudioPlayerLoaded extends VerseState {
//   final Duration position;
//   final Duration bufferedPosition;
//   final Duration duration;
//   final double volume;
//   final double speed;
//   final bool playing;

//   AudioPlayerLoaded({
//     required this.position,
//     required this.bufferedPosition,
//     required this.duration,
//     required this.volume,
//     required this.speed,
//     required this.playing,
//   });

//   AudioPlayerLoaded copyWith({
//     Duration? position,
//     Duration? bufferedPosition,
//     Duration? duration,
//     double? volume,
//     double? speed,
//     bool? playing,
//   }) {
//     return AudioPlayerLoaded(
//       position: position ?? this.position,
//       bufferedPosition: bufferedPosition ?? this.bufferedPosition,
//       duration: duration ?? this.duration,
//       volume: volume ?? this.volume,
//       speed: speed ?? this.speed,
//       playing: playing ?? this.playing,
//     );
//   }
// }

// class AudioPlayerError extends VerseState {
//   final String message;

//   AudioPlayerError(this.message);
// }

part of 'verse_cubit.dart';

@immutable
abstract class VerseState {}

class VerseInitial extends VerseState {}

class AduioPlaying extends VerseState {}

class AudioPlayerLoaded extends VerseState {
  final Stream<PositionData> positionDataStream;
  final Duration duration;
  final double volume;
  final double speed;
  final bool playing;

  AudioPlayerLoaded({
    required this.positionDataStream,
    required this.duration,
    required this.volume,
    required this.speed,
    required this.playing,
  });

  AudioPlayerLoaded copyWith({
    Stream<PositionData>? positionDataStream,
    Duration? duration,
    double? volume,
    double? speed,
    bool? playing,
  }) {
    return AudioPlayerLoaded(
      positionDataStream: positionDataStream ?? this.positionDataStream,
      duration: duration ?? this.duration,
      volume: volume ?? this.volume,
      speed: speed ?? this.speed,
      playing: playing ?? this.playing,
    );
  }
}

class AudioPlayerError extends VerseState {
  final String message;

  AudioPlayerError(this.message);
}
