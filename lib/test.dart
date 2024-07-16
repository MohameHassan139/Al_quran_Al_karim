// import 'dart:async';
// import 'package:audio_service/audio_service.dart';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:get/get.dart';

// late AudioHandler _audioHandler;

// Future<void> main() async {
//   _audioHandler = await AudioService.init(
//     builder: () => AudioPlayerHandler(),
//     config: const AudioServiceConfig(
//       androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
//       androidNotificationChannelName: 'Audio playback',
//       androidNotificationOngoing: true,
//     ),
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Audio Service Demo',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const MainScreen(),
//     );
//   }
// }

// class MainScreen extends StatelessWidget {
//   const MainScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(AudioController());

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Audio Service Demo'),
//       ),
//       body:   );
//   }

//   IconButton _button(IconData iconData, VoidCallback onPressed) => IconButton(
//         icon: Icon(iconData),
//         iconSize: 64.0,
//         onPressed: onPressed,
//       );
// }

// class AudioController extends GetxController {
//   var mediaItem = Rxn<MediaItem>();
//   var isPlaying = false.obs;
//   var mediaState = Rxn<MediaState>();
//   var processingState = AudioProcessingState.idle.obs;

//   AudioController() {
//     _audioHandler.mediaItem.listen((item) {
//       mediaItem.value = item;
//     });

//     _audioHandler.playbackState.listen((state) {
//       isPlaying.value = state.playing;
//       processingState.value = state.processingState;
//     });

//     Rx.combineLatest3<MediaItem?, Duration, Duration, MediaState>(
//       _audioHandler.mediaItem,
//       AudioService.position,
//       _audioHandler.playbackState.map((state) => state.bufferedPosition),
//       (mediaItem, position, bufferedPosition) =>
//           MediaState(mediaItem, position, bufferedPosition),
//     ).listen((state) {
//       mediaState.value = state;
//     });
//   }

//   Future<void> setAudioUrl(String url) async {
//     final newItem = MediaItem(
//       id: url,
//       album: "Unknown Album",
//       title: "Unknown Title",
//       artist: "Unknown Artist",
//       duration: const Duration(
//           milliseconds: 0), // Duration should be updated later if available
//     );
//     await (_audioHandler as AudioPlayerHandler).setAudioSource(newItem);
//   }
// }

// class MediaState {
//   final MediaItem? mediaItem;
//   final Duration position;
//   final Duration bufferedPosition;

//   MediaState(this.mediaItem, this.position, this.bufferedPosition);
// }

// class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
//   final _player = AudioPlayer();
//   final _mediaItemController = BehaviorSubject<MediaItem?>();

//   AudioPlayerHandler() {
//     _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
//     _mediaItemController.stream.listen(mediaItem.add);
//   }

//   Future<void> setAudioSource(MediaItem mediaItem) async {
//     _mediaItemController.add(mediaItem);
//     await _player.setAudioSource(AudioSource.uri(Uri.parse(mediaItem.id)));
//     _player.play();
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

// // SeekBar widget code should be added here
// class SeekBar extends StatefulWidget {
//   final Duration duration;
//   final Duration position;
//   final ValueChanged<Duration>? onChangeEnd;

//   const SeekBar({
//     required this.duration,
//     required this.position,
//     this.onChangeEnd,
//   });

//   @override
//   _SeekBarState createState() => _SeekBarState();
// }

// class _SeekBarState extends State<SeekBar> {
//   double? _dragValue;

//   @override
//   Widget build(BuildContext context) {
//     return Slider(
//       min: 0.0,
//       max: widget.duration.inMilliseconds.toDouble(),
//       value: _dragValue ?? widget.position.inMilliseconds.toDouble(),
//       onChanged: (value) {
//         setState(() {
//           _dragValue = value;
//         });
//       },
//       onChangeEnd: (value) {
//         setState(() {
//           _dragValue = null;
//         });
//         if (widget.onChangeEnd != null) {
//           widget.onChangeEnd!(Duration(milliseconds: value.round()));
//         }
//       },
//     );
//   }
// }
