import 'package:get/get.dart';
import 'package:quran/quran.dart' as quran;
import 'package:quran_app/controller/audio_controller.dart';

class ListenController extends GetxController {
  int index = 1;
  final AudioController audioController = Get.put(AudioController());

  @override
  void onInit() {
    audioController.setAudioUrl(quran.getAudioURLBySurah(index));

    super.onInit();
  }

  void next() {
    if (index < quran.totalSurahCount) {
      index++;
      audioController.setAudioUrl(quran.getAudioURLBySurah(index));

      update();
    }
  }

  void previous() {
    if (index > 1) {
      index--;
      audioController.setAudioUrl(quran.getAudioURLBySurah(index));

      update();
    }
  }
}
