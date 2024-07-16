import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/controller/audio_controller.dart';
import 'package:quran_app/widget/audio/seek_bar.dart';

class CustomAudio extends StatelessWidget {
  final AudioController controller = Get.put(AudioController());
  final String audioUrl;

  CustomAudio({Key? key, required this.audioUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // controller.setAudioUrl(audioUrl);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() {
            final mediaItem = controller.mediaItem.value;
            return Text(mediaItem?.title ?? '');
          }),
          Obx(() {
            final isPlaying = controller.isPlaying.value;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // _button(Icons.fast_rewind, controller.rewind),
                if (isPlaying)
                  _button(Icons.pause, controller.pause)
                else
                  _button(Icons.play_arrow, controller.play),
                _button(Icons.stop, controller.stop),
                // _button(Icons.fast_forward, controller.fastForward),
              ],
            );
          }),
          SeekBar(),
          Obx(() {
            final processingState = controller.processingState.value;
            return Text("Processing state: ${describeEnum(processingState)}");
          }),
        ],
      ),
    );
  }

  IconButton _button(IconData iconData, VoidCallback onPressed) => IconButton(
        icon: Icon(iconData),
        iconSize: 64.0,
        onPressed: onPressed,
      );
}
