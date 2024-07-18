import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioController extends GetxController {
  final AudioPlayer _player = AudioPlayer();
  final mediaItem = Rxn<MediaItem>();
  final isPlaying = false.obs;
  final position = Duration.zero.obs;
  final bufferedPosition = Duration.zero.obs;
  final duration = Duration.zero.obs;
  final processingState = AudioProcessingState.idle.obs;
  int countReplay = 1;
  AudioController() {
    _player.playbackEventStream.listen((event) {
      position.value = _player.position;
      bufferedPosition.value = _player.bufferedPosition;
      duration.value = _player.duration ?? Duration.zero;
      isPlaying.value = _player.playing;
      processingState.value = _getProcessingState(_player.processingState);
    });

    _player.positionStream.listen((pos) {
      position.value = pos;
    });

    _player.bufferedPositionStream.listen((bufferPos) {
      bufferedPosition.value = bufferPos;
    });

    _player.durationStream.listen((dur) {
      duration.value = dur ?? Duration.zero;
    });
  }

  Future<void> setAudioUrl(String url) async {
    final newItem = MediaItem(
      id: url,
      album: "Unknown Album",
      title: "Unknown Title",
      artist: "Unknown Artist",
      duration: const Duration(milliseconds: 0),
    );
    mediaItem.value = newItem;
    await _player.setAudioSource(AudioSource.uri(Uri.parse(url)));
    _player.play();
    update();
  }

  void increaseCountReplay() {
    countReplay++;
    update();
  }

  void decreaseCountReplay() {
    if (countReplay > 1) {
      countReplay--;
      update();
    }
  }

  Future<void> play() => _player.play();
  Future<void> replay() async {
    for (var i = 0; i < countReplay; i++) {
      await _player.seek(Duration.zero);
      await Future.delayed(_player.duration ?? Duration.zero);
    }
    //  _player.seek(Duration.zero);
  }

  Future<void> pause() => _player.pause();
  Future<void> seek(Duration position) => _player.seek(position);
  Future<void> stop() => _player.stop();

  Future<void> rewind(String url) async {
    await setAudioUrl(url);
  }

  AudioProcessingState _getProcessingState(ProcessingState state) {
    switch (state) {
      case ProcessingState.idle:
        return AudioProcessingState.idle;
      case ProcessingState.loading:
        return AudioProcessingState.loading;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
      default:
        return AudioProcessingState.idle;
    }
  }
}
