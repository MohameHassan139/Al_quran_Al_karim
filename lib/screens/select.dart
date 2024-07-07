import 'package:flutter/material.dart';
import 'package:quran_app/const/Globals.dart';
import 'package:quran_app/model/enum.dart';

import '../Index.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                typeView = TypeView.readpdf;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Index(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: Text(
                    'قراء',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                typeView = TypeView.readtext;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Index(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: Text(
                    'قراء',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                typeView = TypeView.saved;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Index(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: Text(
                    'حفظ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
