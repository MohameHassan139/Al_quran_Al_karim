import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/const/Globals.dart';
import 'package:quran_app/controller/audio_controller.dart';
import 'package:quran_app/controller/verse_controller.dart';
import 'package:quran_app/model/enum.dart';
import 'package:quran_app/widget/audio/seek_bar.dart';

import '../../controller/listen_controller.dart';

class CustomAudio extends StatelessWidget {
  final AudioController controller = Get.put(AudioController());
  final VerseController verseController = Get.put(VerseController());
  final ListenController listenController = Get.put(ListenController());

  CustomAudio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() {
            final isPlaying = controller.isPlaying.value;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               
                _button(Icons.fast_rewind, () {
                  typeView == TypeView.lisen
                      ? listenController.next()
                      : verseController.next();
                }),
                if (typeView == TypeView.saved)
                _button(Icons.replay, () {
                  controller.replay();
                }),
                if (isPlaying)
                  _button(Icons.pause, controller.pause)
                else
                  _button(Icons.play_arrow, controller.play),
                _button(Icons.stop, controller.stop),
                _button(Icons.fast_forward, () {
                  typeView == TypeView.lisen
                      ? listenController.previous()
                      : verseController.previous();
                }
                    // controller.fastForward('') as VoidCallback
                    ),
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

  IconButton _button(IconData iconData, VoidCallback? onPressed) => IconButton(
        icon: Icon(iconData),
        iconSize: 50.0,
        onPressed: onPressed,
      );
}
