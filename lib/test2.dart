// // ignore_for_file: public_member_api_docs

// // FOR MORE EXAMPLES, VISIT THE GITHUB REPOSITORY AT:
// //
// //  https://github.com/ryanheise/audio_service
// //
// // This example implements a minimal audio handler that renders the current
// // media item and playback state to the system notification and responds to 4
// // media actions:
// //
// // - play
// // - pause
// // - seek
// // - stop
// //
// // To run this example, use:
// //
// // flutter run

// import 'dart:async';
// import 'package:quran/quran.dart' as quran;

// import 'package:audio_service/audio_service.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:quran_app/common.dart';
// import 'package:quran_app/const/Globals.dart';
// import 'package:quran_app/widget/audio/seek_bar.dart';
// import 'package:rxdart/rxdart.dart';

// import 'widget/audio/seek_bar.dart';

// // You might want to provide this using dependency injection rather than a
// // global variable.

// class MainScreen extends StatelessWidget {
//   MainScreen({Key? key}) : super(key: key);
//   int surhNumber = 1;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Audio Service Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Show media item title
//             StreamBuilder<MediaItem?>(
//               stream: audioHandler.mediaItem,
//               builder: (context, snapshot) {
//                 final mediaItem = snapshot.data;
//                 return Text(mediaItem?.title ?? '');
//               },
//             ),
//             // Play/pause/stop buttons.
//             StreamBuilder<bool>(
//               stream: audioHandler.playbackState
//                   .map((state) => state.playing)
//                   .distinct(),
//               builder: (context, snapshot) {
//                 final playing = snapshot.data ?? false;
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _button(Icons.fast_rewind, () {
//                       if (surhNumber > 1 && surhNumber <= 114) {
//                         surhNumber--;
//                       }
//                     }),
//                     if (playing)
//                       _button(Icons.pause, audioHandler.pause)
//                     else
//                       _button(Icons.play_arrow, audioHandler.play),
//                     _button(Icons.stop, audioHandler.stop),
//                     _button(Icons.fast_forward, () {
//                       if (surhNumber > 1 && surhNumber <= 114) {
//                         surhNumber++;
//                       }
//                     }),
//                   ],
//                 );
//               },
//             ),
//             // A seek bar.
//             StreamBuilder<MediaState>(
//               stream: _mediaStateStream,
//               builder: (context, snapshot) {
//                 final mediaState = snapshot.data;
//                 return SeekBar(
//                   duration: mediaState?.mediaItem?.duration ?? Duration.zero,
//                   position: mediaState?.position ?? Duration.zero,
//                   onChangeEnd: (newPosition) {
//                     audioHandler.seek(newPosition);
//                   },
//                   bufferedPosition:
//                       audioHandler.playbackState.value.bufferedPosition,
//                 );
//               },
//             ),
//             // Display the processing state.
//             StreamBuilder<AudioProcessingState>(
//               stream: audioHandler.playbackState
//                   .map((state) => state.processingState)
//                   .distinct(),
//               builder: (context, snapshot) {
//                 final processingState =
//                     snapshot.data ?? AudioProcessingState.idle;
//                 return Text(
//                     "Processing state: ${describeEnum(processingState)}");
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// A stream reporting the combined state of the current media item and its
//   /// current position.
//   Stream<MediaState> get _mediaStateStream {
//     return Rx.combineLatest2<MediaItem?, Duration, MediaState>(
//       audioHandler.mediaItem,
//       AudioService.position,
//       (mediaItem, position) => MediaState(
//         mediaItem,
//         position,
//       ),
//     );
//   }

//   IconButton _button(IconData iconData, VoidCallback onPressed) => IconButton(
//         icon: Icon(iconData),
//         iconSize: 64.0,
//         onPressed: onPressed,
//       );
// }

// class MediaState {
//   final MediaItem? mediaItem;
//   final Duration position;

//   MediaState(
//     this.mediaItem,
//     this.position,
//   );
// }

// /// An [AudioHandler] for playing a single item.
// class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
//   int? surhNumber = 1;
//   // AudioPlayerHandler();
//   final _player = AudioPlayer();

//   static MediaItem? _item;

//   AudioPlayerHandler({this.surhNumber}) {
//     _init();
//   }

//   Future<void> _init() async {
//     final audioUrl = quran.getAudioURLBySurah(surhNumber!);
//     final duration = await _getAudioDuration(audioUrl);
//     _item = MediaItem(
//       id: audioUrl,
//       album: "Al Quran Al Krame",
//       title: quran.getSurahNameArabic(surhNumber!),
//       duration: duration,
//       artist: "",
//       artUri: Uri.parse(
//           'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
//     );

//     _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
//     mediaItem.add(_item!);

//     _player.setAudioSource(AudioSource.uri(Uri.parse(_item!.id)));
//   }

//   Future<Duration> _getAudioDuration(String url) async {
//     final duration = await _player.setUrl(url);
//     return duration ?? Duration.zero;
//   }

//   @override
//   Future<void> play() => _player.play();

//   @override
//   Future<void> pause() => _player.pause();

//   @override
//   Future<void> seek(Duration position) => _player.seek(position);

//   @override
//   Future<void> stop() => _player.stop();

//   PlaybackState _transformEvent(PlaybackEvent event) {
//     return PlaybackState(
//       controls: [
//         MediaControl.rewind,
//         if (_player.playing) MediaControl.pause else MediaControl.play,
//         MediaControl.stop,
//         MediaControl.fastForward,
//       ],
//       systemActions: const {
//         MediaAction.seek,
//         MediaAction.seekForward,
//         MediaAction.seekBackward,
//       },
//       androidCompactActionIndices: const [0, 1, 3],
//       processingState: const {
//         ProcessingState.idle: AudioProcessingState.idle,
//         ProcessingState.loading: AudioProcessingState.loading,
//         ProcessingState.buffering: AudioProcessingState.buffering,
//         ProcessingState.ready: AudioProcessingState.ready,
//         ProcessingState.completed: AudioProcessingState.completed,
//       }[_player.processingState]!,
//       playing: _player.playing,
//       updatePosition: _player.position,
//       bufferedPosition: _player.bufferedPosition,
//       speed: _player.speed,
//       queueIndex: event.currentIndex,
//     );
//   }
// }
