// // import 'package:bloc/bloc.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bloc/bloc.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:meta/meta.dart';
// import 'package:quran/quran.dart' as quran;

// import '../../model/audio/position_data.dart';

// part 'verse_state.dart';

// // class VerseCubit extends Cubit<VerseState> {
// //   VerseCubit() : super(VerseInitial());
// // }

// class VerseCubit extends Cubit<VerseState> {
//   final AudioPlayer player = AudioPlayer();
//   VerseCubit() : super(VerseInitial()) {
//     _init();
//   }
//   Future<void> _init() async {
//     try {
//       // final session = await AudioSession.instance;
//       // await session.configure(const AudioSessionConfiguration.speech());

//       player.playbackEventStream.listen((event) {
//         emit(AudioPlayerLoaded(
//           position: player.position,
//           bufferedPosition: player.bufferedPosition,
//           duration: player.duration ?? Duration.zero,
//           volume: player.volume,
//           speed: player.speed,
//           playing: player.playing,
//         ));
//       }, onError: (Object e, StackTrace stackTrace) {
//         print('A stream error occurred: $e');
//         emit(AudioPlayerError(e.toString()));
//       });

//       await player.setAudioSource(
//         ConcatenatingAudioSource(
//           children: [
//             AudioSource.uri(Uri.parse(quran.getAudioURLByVerse(2, 15))),
//           ],
//         ),
//       );
//       emit(AudioPlayerLoaded(
//         position: player.position,
//         bufferedPosition: player.bufferedPosition,
//         duration: player.duration ?? Duration.zero,
//         volume: player.volume,
//         speed: player.speed,
//         playing: player.playing,
//       ));
//     } on PlayerException catch (e) {
//       print("Error loading audio source: $e");
//       emit(AudioPlayerError(e.toString()));
//     }
//   }

//   void play() {
//     emit(AduioPlaying());

//     player.play();
//   }

//   void pause() => player.pause();

//   void seek(Duration position) {
//     emit(AduioPlaying());
//     player.seek(position);
//   }

//   void setVolume(double volume) {
//     player.setVolume(volume);
//     if (state is AudioPlayerLoaded) {
//       emit((state as AudioPlayerLoaded).copyWith(volume: volume));
//     }
//   }

//   void setSpeed(double speed) {
//     player.setSpeed(speed);
//     if (state is AudioPlayerLoaded) {
//       emit((state as AudioPlayerLoaded).copyWith(speed: speed));
//     }
//   }

//   void seekToNext() => player.seekToNext();

//   void seekToPrevious() => player.seekToPrevious();

//   @override
//   Future<void> close() {
//     player.dispose();
//     return super.close();
//   }
// }


import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';
import 'package:quran/quran.dart' as quran;
import 'package:rxdart/rxdart.dart';

part 'verse_state.dart';

class VerseCubit extends Cubit<VerseState> {
  final AudioPlayer player = AudioPlayer();
  VerseCubit() : super(VerseInitial()) {
    _init();
  }

  Future<void> _init() async {
    try {
      player.playbackEventStream.listen((event) {
        emit(AudioPlayerLoaded(
          positionDataStream:
              Rx.combineLatest2<Duration, Duration, PositionData>(
            player.positionStream,
            player.bufferedPositionStream,
            (position, bufferedPosition) =>
                PositionData(position, bufferedPosition),
          ),
          duration: player.duration ?? Duration.zero,
          volume: player.volume,
          speed: player.speed,
          playing: player.playing,
        ));
      }, onError: (Object e, StackTrace stackTrace) {
        print('A stream error occurred: $e');
        emit(AudioPlayerError(e.toString()));
      });

      await player.setAudioSource(
        ConcatenatingAudioSource(
          children: [
            AudioSource.uri(Uri.parse(quran.getAudioURLByVerse(2, 15))),
          ],
        ),
      );
      emit(AudioPlayerLoaded(
        positionDataStream: Rx.combineLatest2<Duration, Duration, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          (position, bufferedPosition) =>
              PositionData(position, bufferedPosition),
        ),
        duration: player.duration ?? Duration.zero,
        volume: player.volume,
        speed: player.speed,
        playing: player.playing,
      ));
    } on PlayerException catch (e) {
      print("Error loading audio source: $e");
      emit(AudioPlayerError(e.toString()));
    }
  }

  void play() {
    emit(AduioPlaying());
    player.play();
  }

  void pause() => player.pause();

  void seek(Duration position) {
    emit(AduioPlaying());
    player.seek(position);
  }

  void setVolume(double volume) {
    player.setVolume(volume);
    if (state is AudioPlayerLoaded) {
      emit((state as AudioPlayerLoaded).copyWith(volume: volume));
    }
  }

  void setSpeed(double speed) {
    player.setSpeed(speed);
    if (state is AudioPlayerLoaded) {
      emit((state as AudioPlayerLoaded).copyWith(speed: speed));
    }
  }

  void seekToNext() => player.seekToNext();

  void seekToPrevious() => player.seekToPrevious();

  @override
  Future<void> close() {
    player.dispose();
    return super.close();
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;

  PositionData(this.position, this.bufferedPosition);
}
