import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:quran/quran.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Text(
          "${quran.getVersesTextByPage(
            100,
            verseEndSymbol: true,
            surahSeperator: SurahSeperator.surahNameArabic,
          )}",
          style: TextStyle(
            fontSize: 30,
          ),
          softWrap: true,
        ),
        // heightFactor: size.height / size.width,
        // widthFactor: 2,
      ),
    );
  }
}
