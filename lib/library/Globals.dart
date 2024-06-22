library quran.globals;

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
