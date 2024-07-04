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
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          fit: StackFit.expand,

          // alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: SingleChildScrollView(
                child: Wrap(
                  children: [
                    Text(
                      "${quran.getVerse(2, 282)} ${quran.getVerseEndSymbol(arabicNumeral: true, 282)}",
                      textDirection: TextDirection.rtl,
                      style: GoogleFonts.amiriQuran().copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 2,
                      ),
                    ),
                    Text(
                      "${quran.getVerse(2, 282)} ${quran.getVerseEndSymbol(arabicNumeral: true, 282)}",
                      textDirection: TextDirection.rtl,
                      style: GoogleFonts.amiriQuran().copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 2,
                      ),
                    ),
                    Text(
                      "${quran.getVerse(2, 282)} ${quran.getVerseEndSymbol(arabicNumeral: true, 282)}",
                      textDirection: TextDirection.rtl,
                      style: GoogleFonts.amiriQuran().copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              width: width,
              child: Align(
              
                
                alignment: Alignment.bottomCenter,
                child: CustomAudio(
                  url: quran.getAudioURLByVerse(2, 282),
                ),
              ),
            )
           
          ],
        ),
      ),
    );
  }
}
