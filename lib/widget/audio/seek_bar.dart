import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/widget/audio/hidden_thumb_component_shape.dart';
import 'package:quran_app/controller/audio_controller.dart';

class SeekBar extends StatelessWidget {
  final AudioController controller = Get.find();

  SeekBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final duration = controller.duration.value;
      final position = controller.position.value;
      final bufferedPosition = controller.bufferedPosition.value;
      final value = min(position.inMilliseconds.toDouble(),
          duration.inMilliseconds.toDouble());

      return Stack(
        children: [
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 2.0,
              thumbShape: HiddenThumbComponentShape(),
              activeTrackColor: Colors.blue.shade100,
              inactiveTrackColor: Colors.grey.shade300,
            ),
            child: ExcludeSemantics(
              child: Slider(
                min: 0.0,
                max: duration.inMilliseconds.toDouble(),
                value: min(bufferedPosition.inMilliseconds.toDouble(),
                    duration.inMilliseconds.toDouble()),
                onChanged: (value) {},
              ),
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              inactiveTrackColor: Colors.transparent,
            ),
            child: Slider(
              min: 0.0,
              max: duration.inMilliseconds.toDouble(),
              value: value,
              onChanged: (value) {
                controller.seek(Duration(milliseconds: value.round()));
              },
              onChangeEnd: (value) {
                controller.seek(Duration(milliseconds: value.round()));
              },
            ),
          ),
          Positioned(
            right: 16.0,
            bottom: 0.0,
            child: Text(
              _remainingText(duration, position),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      );
    });
  }

  String _remainingText(Duration duration, Duration position) {
    final remaining = duration - position;
    final minutes =
        remaining.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds =
        remaining.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {}
}
