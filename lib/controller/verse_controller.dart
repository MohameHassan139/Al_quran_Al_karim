import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/quran.dart' as quran;
import 'package:quran_app/controller/audio_controller.dart';

class VerseController extends GetxController {
  String? surahIndex;
  PageController pageController = PageController();
  int get surahNumber => int.parse(surahIndex ?? 1.toString());

  TextEditingController versIndexController = TextEditingController();

  RxInt currentVerseIndex = 0.obs;
  RxDouble textScaler = 1.0.obs;

  RxDouble previousScale = 1.0.obs;

  final AudioController audioController = Get.put(AudioController());

  // llll

  @override
  void onInit() {
    // audioController.setAudioUrl(quran.getAudioURLByVerse(1, 1));
    // TODO: implement onInit

    super.onInit();
  }

  void next() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
    update();
  }

  void previous() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    update();
  }

  void goToVers() {
    int index = int.parse(versIndexController.text);
    if (versIndexController.text.isNotEmpty &&
        index > 0 &&
        index < quran.getVerseCount(surahNumber)) {
      pageController.jumpToPage(int.parse(versIndexController.text));
      versIndexController.clear();
      update();
    }
  }

  void setCurrentVerse(int index) {
    currentVerseIndex.value = index;
  }

  void onScaleStart(ScaleStartDetails details) {
    previousScale.value = textScaler.value;
  }

  void updateTextScaler(ScaleUpdateDetails details) {
    textScaler.value = previousScale.value * (1 + (details.scale - 1) * 0.1);
  }

  void setVerse(String verse) {
    surahIndex = verse;
  }

  String getCurrentAudioUrl() {
    if (currentVerseIndex.value == 0) {
      return quran.getAudioURLByVerseNumber(1);
    } else {
      return quran.getAudioURLByVerse(surahNumber, currentVerseIndex.value);
    }
  }

  String getCurrentVerse() {
    return quran.getVerse(surahNumber, currentVerseIndex.value);
  }

  String getCurrentVerseEndSymbol() {
    return quran.getVerseEndSymbol(
        arabicNumeral: true, currentVerseIndex.value);
  }

  int getVerseCount() {
    return quran.getVerseCount(surahNumber);
  }

  String getSurahNameArabic() {
    return quran.getSurahNameArabic(surahNumber);
  }
}
