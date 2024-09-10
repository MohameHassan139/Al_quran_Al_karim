import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;

class SurhPage extends StatefulWidget {
  SurhPage({super.key, required this.surhNumber});
  String surhNumber;

  @override
  State<SurhPage> createState() => _SurhPageState();
}

class _SurhPageState extends State<SurhPage> {
  int get surhindex => int.parse(widget.surhNumber);

  double textScaler = 1;
  double previousScale = 1;

  @override
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
                  textScaler = previousScale * (1 + (details.scale - 1) * 0.1);
                });
              },
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "${quran.basmala}",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.justify,
                        softWrap: true,
                        style: GoogleFonts.amiri().copyWith(
                          fontSize: 20 * textScaler,
                          fontWeight: FontWeight.bold,
                          height: 2,
                        ),
                      ),
                      Text(

                        List<String>.generate(
                          quran.getVerseCount(surhindex),
                          (int index) =>
                              "${quran.getVerse(surhindex, index + 1)} ${quran.getVerseEndSymbol(arabicNumeral: true, index + 1)}",
                        ).join(""),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.justify,
                        softWrap: true,
                        style: GoogleFonts.amiri().copyWith(
                          fontSize: 20 * textScaler,
                          fontWeight: FontWeight.bold,
                          height: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
