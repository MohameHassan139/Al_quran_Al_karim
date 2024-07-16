library quran.globals;

// import 'package:audio_service/audio_service.dart';
import 'package:audio_service/audio_service.dart';
import 'package:pdfx/pdfx.dart';
import 'package:quran_app/model/enum.dart';
import 'package:quran_app/test.dart';

import '../widget/audio/audio_play_handler.dart';



/// -------------- @Global values
/// changes when onChanged Callback
int currentPage =0;

/// contains bookmarkedPage
int bookmarkedPage =0;

/// refer to last viewed page (stored in sharedPreferences)
int lastViewedPage =0;

/// Default Screen Brightness level [Default value = 0.5] (medium)
double brightnessLevel =0;

/// -------------- @Defaults values
/// if bookmarkedPage not defined
/// Default Bookmarked page equals to surat Al-baqara index [Default value =569] (Reversed)
const DEFAULT_BOOKMARKED_PAGE = 569;

const DEFAULT_BRIGHTNESS_LEVEL = 0.5;

/// -------------- @SharedPreferences Const
const LAST_VIEWED_PAGE = 'lastViewedPage';
const BRIGHTNESS_LEVEL = 'brightness_level';
const BOOKMARKED_PAGE = 'bookmarkedPage';

Future<PdfDocument>? document;
Future<void> initDocument() async {
  document = PdfDocument.openAsset('assets/pdf/quran.pdf');
}

TypeView? typeView;

// late AudioPlayerHandler audioHandler;
// late int sdkInt;
//
// List<Song>? songs;
//
// final albumArtPaths = <int, String>{};
//
// /// Whether running on scoped storage (Android 10 and above),
// /// and should use bytes to load album arts from `MediaStore`.
// bool get useScopedStorage => sdkInt >= 29;
late AudioHandler  audioHandler;
