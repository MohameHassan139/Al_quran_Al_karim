import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/controller/audio_controller.dart';

import '../widget/audio/custom_audio.dart';
import 'package:quran/quran.dart' as quran;

class ListenPage extends StatefulWidget {
  ListenPage({super.key, required this.surhNumber});
  String surhNumber;

  @override
  State<ListenPage> createState() => _ListenPageState();
}

class _ListenPageState extends State<ListenPage> {
  int get surhindex => int.parse(widget.surhNumber);
  final AudioController audioController = Get.put(AudioController());

  @override
  void initState() {
    audioController.setAudioUrl(quran.getAudioURLBySurah(surhindex));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          " ${quran.getSurahNameArabic(surhindex)}",
          textDirection: TextDirection.rtl,
          style: GoogleFonts.amiriQuran().copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            height: 2,
          ),
        ),
      ),
      body: Column(
        children: [
          Spacer(),
          Image.asset('assets/images/logo.png'),
          Spacer(),
          CustomAudio(
            audioUrl: quran.getAudioURLBySurah(surhindex),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
