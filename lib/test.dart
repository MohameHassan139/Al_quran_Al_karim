// This is a minimal example demonstrating a play/pause button and a seek bar.
// More advanced examples demonstrating other features can be found in the same
// directory as this example in the GitHub repository.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/widget/audio/custom_audio.dart';
import 'package:quran/quran.dart' as quran;

class VesreScreen extends StatefulWidget {
  const VesreScreen({super.key});

  @override
  State<VesreScreen> createState() => _VesreScreenState();
}

class _VesreScreenState extends State<VesreScreen> {
  PageController? controller;
  int surhNumber = 2;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: PageView.builder(
            reverse: true,
            itemCount: quran.getVerseCount(surhNumber),
            itemBuilder: (context, index) => Stack(
              fit: StackFit.expand,
              alignment: Alignment.topCenter,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 110.0),
                  child: SingleChildScrollView(
                    child: Center(
                      child: Text(
                        "${quran.getVerse(surhNumber, index + 1)} ${quran.getVerseEndSymbol(arabicNumeral: true, index + 1)}",
                        textDirection: TextDirection.rtl,
                          
                        textAlign: TextAlign.center,
                        style: GoogleFonts.amiriQuran().copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                
                Positioned(
                  bottom: 0,
                  width: width,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomAudio(
                      url: quran.getAudioURLByVerse(surhNumber, index + 1),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
