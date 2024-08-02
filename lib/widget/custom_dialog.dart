import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/controller/verse_controller.dart';
import 'package:quran_app/widget/custom_textformfield.dart';

class CustomDialog extends StatelessWidget {
  CustomDialog({
    super.key,
  });

  final VerseController verseController = Get.put(VerseController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 230,
        child: Column(
          children: [
            Text("ادخل رقم الايه",
                style: GoogleFonts.amiriQuran().copyWith(fontSize: 24)),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomTextFormField(
                labelText: 'رقم الايه',
                fieldType: TextInputType.number,
                textController: verseController.versIndexController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: MaterialButton(
                onPressed: () {
                  verseController.goToVers();
                  Get.back();
                },
                color: Theme.of(context).primaryColor,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                  child: Text(
                    'اذهب',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
