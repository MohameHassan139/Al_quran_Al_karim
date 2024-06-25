import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/const/Globals.dart';
import 'package:quran_app/test2.dart';
import 'Index.dart';
import 'SplashScreen.dart';
import 'controller/cubit/verse_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDocument();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<VerseCubit>(
          create: (context) => VerseCubit(),
        )
      ],
      child: MaterialApp(
        routes: {
          'index': (context) => Index(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Colors.green,
        ),
        // home: SplashScreen(),
        // home: QuranExample(),
        home: AudioPlayerScreen(),
      ),
    );
  }
}
