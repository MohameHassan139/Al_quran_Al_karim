import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/quran.dart' as quran;

class VerseController extends GetxController {
  String? surahIndex;
  PageController pageController = PageController();
  int get surahNumber => int.parse(surahIndex ?? 1.toString());
  TextEditingController versIndexController = TextEditingController();
  RxInt currentVerseIndex = 0.obs;
  RxDouble textScaler = 1.0.obs;

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

  void updateTextScaler(double scale) {
    textScaler.value = scale;
  }

  void setVerse(String verse) {
    surahIndex = verse;
  }

  String getCurrentAudioUrl() {
    return quran.getAudioURLByVerse(surahNumber, currentVerseIndex.value + 1);
  }

  String getCurrentVerse() {
    return quran.getVerse(surahNumber, currentVerseIndex.value + 1);
  }

  String getCurrentVerseEndSymbol() {
    return quran.getVerseEndSymbol(
        arabicNumeral: true, currentVerseIndex.value + 1);
  }

  int getVerseCount() {
    return quran.getVerseCount(surahNumber);
  }

  String getSurahNameArabic() {
    return quran.getSurahNameArabic(surahNumber);
  }
}
