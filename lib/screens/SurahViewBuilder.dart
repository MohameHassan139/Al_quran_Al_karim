import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:pdfx/pdfx.dart';
import 'package:quran_app/const/Globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/Bookmark.dart';
import '../Index.dart';
import 'package:quran_app/const/Globals.dart';

class SurahViewBuilder extends StatefulWidget {
  SurahViewBuilder({Key? key, required this.pages}) : super(key: key);
  final int pages;

  @override
  _SurahViewBuilderState createState() => _SurahViewBuilderState();
}

class _SurahViewBuilderState extends State<SurahViewBuilder> {
  static const List<double> _doubleTapScales = <double>[1.0, 1.1];
  int currentPage = 0;
  late PdfController pageController;
  bool isBookmarked = false;
  Widget _bookmarkWidget = Container();
  int _selectedIndex = 0;

  Future<PdfDocument>? _getDocument() async {
    if (document != null) {
      return document!;
    }
    if (document != null) {
      // document = await PdfDocument.openAsset('assets/pdf/quran.pdf');
      return document!;
    } else {
      throw Exception(
        'المعذرة لا يمكن طباعة المحتوى'
        'يرجي التحقق من أن جهازك يدعم نظام أندرويد بنسخته 5 على الأقل',
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      setState(() {
        if (globals.bookmarkedPage == null) {
          globals.bookmarkedPage = globals.DEFAULT_BOOKMARKED_PAGE;
        }
   
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
                SurahViewBuilder(pages: globals.bookmarkedPage - 1)),
      );
      setState(() {
        checkBookMark();
      });
    } else if (index == 1) {
      setState(() {
        globals.bookmarkedPage = globals.currentPage;
        checkBookMark();

        print("toSave: ${globals.bookmarkedPage}");
      });
      if (globals.bookmarkedPage != null) {
        setBookmark(globals.bookmarkedPage);
      }
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Index()));
    
    }
  }

  PdfController _pageControllerBuilder() {
    return PdfController(
      document: document!,
    );
  }

  void setBookmark(int page) async {
    await prefs.setInt(globals.BOOKMARKED_PAGE, page);
    
    
  }

  void setLastViewedPage(int currentPage) async {
    await prefs.setInt(globals.LAST_VIEWED_PAGE, currentPage);
    globals.lastViewedPage = prefs.getInt(globals.LAST_VIEWED_PAGE)!;
    checkBookMark();
  }

  void checkBookMark() {
    isBookmarked =
        globals.currentPage == prefs.getInt(globals.BOOKMARKED_PAGE) ||
            globals.currentPage == globals.bookmarkedPage;
  }

  @override
  void initState() {
    super.initState();
    
    globals.currentPage = widget.pages + 1;
      pageController = _pageControllerBuilder();

      pageController.initialPage = widget.pages + 1;

    
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder<PdfDocument>(
        future: _getDocument(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: Stack(
                children: [
                  PdfView(
                    controller: pageController,
                    renderer: (PdfPage page) => page.render(
                      width: width * 1.1,
                      height: height * 1,
                      format: PdfPageImageFormat.jpeg,
                      backgroundColor: '#FFFFFF',
                    ),
                    scrollDirection: Axis.horizontal,
                    onDocumentLoaded: (document) {
                      setState(() {
                        document = document;
                      });
                    },
                    onPageChanged: (page) {
                      setState(() {
                        currentPage = page;
                        globals.currentPage = currentPage;
                        setLastViewedPage(currentPage);
                        checkBookMark();
                      });
                    },
                  ),
                  Visibility(
                    visible: isBookmarked,
                    child: Positioned(
                      height: 0,
                      left: 0,
                      child: Bookmark(),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error.toString());
            return const Center(
              child: Text(
                'المعذرة لا يمكن طباعة المحتوى'
                'يرجي التحقق من أن جهازك يدعم نظام أندرويد بنسخته 5 على الأقل',
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'الإنتقال إلى العلامة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'حفظ العلامة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_numbered_rtl),
            label: 'الفهرس',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.grey[600],
        selectedFontSize: 12,
        onTap: (index) => _onItemTapped(index),
      ),
    );
  }

  Future<bool> hasSupport() async {
    // Always assume support for emulators
    if (isEmulator()) {
      return true;
    }
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    bool hasSupport = androidInfo.version.sdkInt >= 21;
    return hasSupport;
  }

  bool isEmulator() {
    // Replace with your preferred method to detect emulators
    // This is a basic example using a fake constant value
    return const bool.fromEnvironment("IS_EMULATOR", defaultValue: false);
  }
}
