import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/audio/custom_audio.dart';
import 'package:quran/quran.dart' as quran;

class ListenPage extends StatelessWidget {
  ListenPage({super.key, required this.surhNumber});
  String surhNumber;
  int get surhindex => int.parse(surhNumber);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          " ${quran.getSurahNameArabic(2)}",
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
            url: quran.getAudioURLBySurah(2),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
