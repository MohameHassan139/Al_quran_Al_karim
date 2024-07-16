import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/const/Globals.dart';
import 'package:quran_app/widget/audio/audio_play_handler.dart';
// import 'package:quran_app/test2.dart';
// import 'package:quran_app/test.dart';
// import 'package:quran_app/widget/audio/audio_play_handler.dart';
import 'Index.dart';
import 'SplashScreen.dart';
import 'screens/select.dart';

import 'package:quran/quran.dart' as quran;

// import 'widget/audio/audio_play_handler.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await initDocument();


  audioHandler = await AudioService.init(
      builder: () => AudioPlayerHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.yourcompany.yourapp.channel.audio',
        androidNotificationChannelName: 'Audio playback',
        androidNotificationOngoing: true,
        androidNotificationClickStartsActivity: true,
        androidResumeOnClick: true,
        androidStopForegroundOnPause: true,
        androidShowNotificationBadge: true,
      ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {
        'index': (context) => Index(),
        'select': (context) => SelectPage(),
      },
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
      ),
      home: SplashScreen(),
      // home: MainScreen(
      //   audioUrl: quran.getAudioURLBySurah(3),
      // ),
      // home: AudioPlayerScreen(),
      // home: Test(),
      // home: VesreScreen(
      //   surhindex: '002',
      // ),
    );
  }
}
