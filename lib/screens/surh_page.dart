import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;
import 'package:quran_app/controller/audio_controller.dart';

class SurhPage extends StatefulWidget {
  SurhPage({super.key, required this.surhNumber});
  String surhNumber;

  @override
  State<SurhPage> createState() => _SurhPageState();
}

class _SurhPageState extends State<SurhPage> {
  @override
  int get surhindex => int.parse(widget.surhNumber);

  double textScaler = 1;
  double previousScale = 1;
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onScaleStart: (details) {
                  previousScale = textScaler;
                },
                onScaleUpdate: (details) {
                  setState(() {
                    textScaler = previousScale * details.scale;
                  });
                },
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "${quran.basmala} ",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          textScaler: TextScaler.linear(textScaler),
                          style: GoogleFonts.amiriQuran().copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            height: 2,
                          ),
                        ),
                        Text(
                          List<String>.generate(
                            quran.getVerseCount(surhindex),
                            (int index) =>
                                "${quran.getVerse(surhindex, index + 1)} ${quran.getVerseEndSymbol(arabicNumeral: true, index + 1)}",
                          )
                              .toString()
                              .replaceAll(',', '')
                              .replaceAll("[", '')
                              .replaceAll(']', ''),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          textScaler: TextScaler.linear(textScaler),
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
              )),
        ),
      ),
    );
  }
}

