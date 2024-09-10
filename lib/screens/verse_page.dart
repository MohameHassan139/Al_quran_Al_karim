import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/controller/audio_controller.dart';
import 'package:quran_app/controller/verse_controller.dart';
import 'package:quran_app/widget/audio/custom_audio.dart';
import 'package:quran/quran.dart' as quran;

import '../widget/custom_dialog.dart';

class VesreScreen extends StatefulWidget {
  VesreScreen({super.key, required this.surhindex});
  String surhindex;

  @override
  State<VesreScreen> createState() => _VesreScreenState();
}

class _VesreScreenState extends State<VesreScreen> {
  @override
  void initState() {
    verseController.setVerse(widget.surhindex);
    verseController.currentVerseIndex.value = 0;
    audioController.setAudioUrl(verseController.getCurrentAudioUrl());
    super.initState();
  }

  final VerseController verseController = Get.put(VerseController());

  final AudioController audioController = Get.put(AudioController());
  @override
  Widget build(BuildContext context) {
    VerseController().setVerse(widget.surhindex);

    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          " ${verseController.getSurahNameArabic()}",
          textDirection: TextDirection.rtl,
          style: GoogleFonts.amiriQuran().copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            height: 2,
          ),
        ),
        actions: [
          IconButton(
            onPressed: audioController.decreaseCountReplay,
            icon: const Icon(Icons.exposure_minus_1),
          ),
          GetBuilder<AudioController>(
            builder: (controller) {
              return Text('${audioController.countReplay}');
            },
          ),
          IconButton(
            onPressed: audioController.increaseCountReplay,
            icon: const Icon(Icons.plus_one),
          ),
          IconButton(
            onPressed: () {
              Get.dialog(CustomDialog());
            },
            icon: const Icon(Icons.skip_next),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: PageView.builder(
            reverse: true,
            controller: verseController.pageController,
            itemCount: verseController.getVerseCount() + 1,
            onPageChanged: (int index) {
              verseController.setCurrentVerse(index);
              audioController.setAudioUrl(verseController.getCurrentAudioUrl());
            },
            itemBuilder: (context, index) => Stack(
              fit: StackFit.expand,
              alignment: Alignment.topCenter,
              children: [
                const SizedBox(height: 15),
                GestureDetector(
                  onScaleStart: verseController.onScaleStart,
                  onScaleUpdate: verseController.updateTextScaler,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 110.0),
                    child: SingleChildScrollView(
                      child: Center(
                        child: Obx(() => Text(
                              (verseController.currentVerseIndex.value == 0)
                                  ? quran.basmala
                                  : "${verseController.getCurrentVerse()} ${verseController.getCurrentVerseEndSymbol()}",
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              textScaler: TextScaler.linear(
                                  verseController.textScaler.value),
                              style: GoogleFonts.amiri().copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                height: 2,
                                wordSpacing: 1.1,
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  width: width,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomAudio(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
