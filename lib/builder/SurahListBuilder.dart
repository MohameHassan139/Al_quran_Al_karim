import 'package:flutter/material.dart';
import '../entity/Surah.dart';
import 'SurahViewBuilder.dart';

class SurahListBuilder extends StatefulWidget {
  final List<Surah> surah;

  SurahListBuilder({Key? key, required this.surah}) : super(key: key);

  @override
  _SurahListBuilderState createState() => _SurahListBuilderState();
}

class _SurahListBuilderState extends State<SurahListBuilder> {
  TextEditingController editingController = TextEditingController();

   List<Surah>  surah=[];

  void initSurahListView() {
    if (surah.isNotEmpty) {
      surah.clear();
    }
    surah.addAll(widget.surah);
  }

  void filterSearchResults(String query) {
    /// Fill surah list if empty
    initSurahListView();

    /// SearchList contains every surah
    late List<Surah> searchList = [];
    searchList.addAll(surah);

    /// Contains matching surah(s)
    List<Surah> listData = [];
    if (query.isNotEmpty) {
      /// Loop all surah(s)
      searchList.forEach((item) {
        /// Filter by (titleAr:exact,title:partial,pageIndex)
        if (item.titleAr!.contains(query) ||
            item.title!.toLowerCase().contains(query.toLowerCase()) ||
            item.pageIndex.toString().contains(query)) {
          listData.add(item);
        }
      });

      /// Fill surah List with searched surah(s)
      setState(() {
        surah.clear();
        surah.addAll(listData);
      });
      return;

      /// Show all surah list
    } else {
      setState(() {
        surah.clear();
        surah.addAll(widget.surah);
      });
    }
  }

  @override
  void initState() {
    /// Init listView with all surah(s)
    initSurahListView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          /// Search field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              cursorColor: Colors.green,
              onChanged: (value) {
                filterSearchResults(value);
                print(value);
              },
              controller: editingController,
              decoration: InputDecoration(
                  labelText: "البحث عن سورة",
                  // hintText: "البحث",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)))),
            ),
          ),

          /// ListView represent all/searched surah(s)
          Expanded(
            child: ListView.builder(
              itemCount: surah.length,
              itemExtent: 80,
              itemBuilder: (BuildContext context, int index) => ListTile(
                  title: Text(surah[index].titleAr!),
                  subtitle: Text(surah[index].title!),
                  leading: Image(
                      image:
                          AssetImage("assets/images/${surah[index].place}.png"),
                      width: 30,
                      height: 30),
                  trailing: Text("${surah[index].pageIndex}"),
                  onTap: () {
                    /// Push to Quran view ([int pages] represent surah page(reversed index))
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SurahViewBuilder(pages: surah[index].pages!)));
                  }),
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:pdfx/pdfx.dart';
// import 'package:quran/library/Globals.dart' as globals;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../widget/Bookmark.dart';
// import '../Index.dart';

// class SurahViewBuilder extends StatefulWidget {
//   SurahViewBuilder({Key? key, required this.pages}) : super(key: key);
//   final int pages;

//   @override
//   _SurahViewBuilderState createState() => _SurahViewBuilderState();
// }

// class _SurahViewBuilderState extends State<SurahViewBuilder> {
//   late PdfDocument _document;
//   static const List<double> _doubleTapScales = <double>[1.0, 1.1];
//   int currentPage = 0;
//   late PdfControllerPinch pageController;
//   bool isBookmarked = false;
//   Widget _bookmarkWidget = Container();
//   int _selectedIndex = 0;
//   late SharedPreferences prefs;

//   Future<PdfDocument> _getDocument() async {
//     if (_document != null) {
//       return _document;
//     }

//     if (await hasSupport()) {
//       _document = await PdfDocument.openAsset('assets/pdf/quran.pdf');
//       return _document;
//     } else {
//       throw Exception(
//         'المعذرة لا يمكن طباعة المحتوى'
//         'يرجي التحقق من أن جهازك يدعم نظام أندرويد بنسخته 5 على الأقل',
//       );
//     }
//   }

//   _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });

//     if (index == 0) {
//       setState(() {
//         if (globals.bookmarkedPage == null) {
//           globals.bookmarkedPage = globals.DEFAULT_BOOKMARKED_PAGE;
//         }
//       });
//       Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(
//               builder: (context) =>
//                   SurahViewBuilder(pages: globals.bookmarkedPage - 1)),
//           (Route<dynamic> route) => false);
//     } else if (index == 1) {
//       setState(() {
//         globals.bookmarkedPage = globals.currentPage;
//         print("toSave: ${globals.bookmarkedPage}");
//       });
//       if (globals.bookmarkedPage != null) {
//         setBookmark(globals.bookmarkedPage);
//       }
//     } else if (index == 2) {
//       Navigator.push(context, MaterialPageRoute(builder: (context) => Index()));
//     }
//   }

//   PdfControllerPinch _pageControllerBuilder() {
//     return PdfControllerPinch(
//       document: PdfDocument.openAsset('assets/pdf/quran.pdf'),
//     );
//   }

//   void setBookmark(int _page) async {
//     prefs = await SharedPreferences.getInstance();
//     if (_page != null && !_page.isNaN) {
//       await prefs.setInt(globals.BOOKMARKED_PAGE, _page);
//     }
//   }

//   void setLastViewedPage(int _currentPage) async {
//     prefs = await SharedPreferences.getInstance();
//     if (_currentPage != null && !_currentPage.isNaN) {
//       prefs.setInt(globals.LAST_VIEWED_PAGE, _currentPage);
//       globals.lastViewedPage = prefs.getInt(globals.LAST_VIEWED_PAGE)!;
//     }
//   }

//   closePage(page) async {
//     await page.close();
//   }

//   @override
//   void initState() {
//     setState(() {
//       globals.currentPage = widget.pages;
//       pageController = _pageControllerBuilder();
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     pageController = _pageControllerBuilder();
//     return Scaffold(
//       body: FutureBuilder<PdfDocument>(
//         future: _getDocument(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return SafeArea(
//               child: PdfViewPinch(
//                 controller: pageController,
//                 onPageChanged: (page) {
//                   currentPage = page;
//                   globals.currentPage = currentPage;
//                   setLastViewedPage(currentPage);
//                   setState(() {
//                     isBookmarked = currentPage == globals.bookmarkedPage;
//                     _bookmarkWidget = isBookmarked ? Bookmark() : Container();
//                   });
//                 },
//                 scrollDirection: Axis.horizontal,
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text(
//                 'المعذرة لا يمكن طباعة المحتوى'
//                 'يرجي التحقق من أن جهازك يدعم نظام أندرويد بنسخته 5 على الأقل',
//               ),
//             );
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.book),
//             label: ('الإنتقال إلى العلامة'),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.bookmark),
//             label: ('حفظ العلامة'),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.format_list_numbered_rtl),
//             label: ('الفهرس'),
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.grey[600],
//         selectedFontSize: 12,
//         onTap: (index) => _onItemTapped(index),
//       ),
//     );
//   }

//   Future<bool> hasSupport() async {
//     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     bool hasSupport = androidInfo.version.sdkInt >= 21;
//     return hasSupport;
//   }
// }
