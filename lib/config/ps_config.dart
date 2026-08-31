// Copyright (c) 2025, the Panacea-Soft.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// Panacea-Soft license that can be found in the LICENSE file.

import '../core/vendor/viewobject/common/language.dart';

class PsConfig {
  PsConfig._();

  ///
  /// AppVersion
  /// For your app, you need to change according based on your app version

  static const String app_version = '1.5.6';

  ///
  /// Bearer Token
  ///
  static const String ps_bearer_token =
      'Bearer zUMi0HNjAtnREMj3weG7XEv6ogEVovsf6eUFgOp4';

  ///
  /// API URL
  /// Change your backend url
  ///
  static const String ps_core_url =
       'https://www.dressy-dz.com';
      

  static const String ps_app_url = ps_core_url + '/api/v1.0/'; 

  static const String ps_app_image_url =
      ps_core_url + '/public/storage/PSX_MPC/uploads/';

  static const String ps_app_image_thumbs_url =
      ps_core_url + '/public/storage/PSX_MPC/thumbnail/';

  static const String ps_app_image_thumbs_2x_url =
      ps_core_url + '/public/storage/PSX_MPC/thumbnail2x/';

  static const String ps_app_image_thumbs_3x_url =
      ps_core_url + '/public/storage/PSX_MPC/thumbnail3x/';

  ///
  /// Chat Setting
  ///
  ///
  /// Chat Setting
  ///
  static const String iosGoogleAppId =
      '1:828256414245:ios:0000000000000000000000';
  static const String iosGcmSenderId = '828256414245';
  static const String iosProjectId = 'dressydz';
  static const String iosDatabaseUrl =
      'https://dressydz-default-rtdb.firebaseio.com';
  static const String iosApiKey = 'AIzaSyDDfvask1njFIwwlI9pS-Xasrh8rhqitwM';

  static const String androidGoogleAppId =
      '1:828256414245:android:3418d9a42d8fde3b452dcc';
  static const String androidGcmSenderId = '828256414245';
  static const String androidProjectId = 'dressydz';
  static const String androidApiKey = 'AIzaSyDDfvask1njFIwwlI9pS-Xasrh8rhqitwM';
  static const String androidDatabaseUrl =
      'https://dressydz-default-rtdb.firebaseio.com';

  ///
  /// Animation Duration
  ///
  static const Duration animation_duration = Duration(milliseconds: 500);

  ///
  /// Fonts Family Config
  /// Before you declare you here,
  /// 1) You need to add font under assets/fonts/
  /// 2) Declare at pubspec.yaml
  /// 3) Update your font family name at below
  ///
  // static const String ps_default_font_family = 'Product Sans';

  static const String ps_app_db_name = 'ps_db.db';

  ///
  /// Default Language
  ///
  static final Language defaultLanguage =
      Language(languageCode: 'en', countryCode: 'US', name: 'English US');

  /// For default language change, please check
  /// LanguageFragment for language code and country code
  /// ..............................................................
  /// Language             | Language Code     | Country Code
  /// ..............................................................
  /// "English"            | "en"              | "US"
  /// "Arabic"             | "ar"              | "DZ"
  /// "India (Hindi)"      | "hi"              | "IN"
  /// "German"             | "de"              | "DE"
  /// "Spanish"            | "es"              | "ES"
  /// "French"             | "fr"              | "FR"
  /// "Indonesian"         | "id"              | "ID"
  /// "Italian"            | "it"              | "IT"
  /// "Japanese"           | "ja"              | "JP"
  /// "Korean"             | "ko"              | "KR"
  /// "Malay"              | "ms"              | "MY"
  /// "Portuguese"         | "pt"              | "PT"
  /// "Russian"            | "ru"              | "RU"
  /// "Thai"               | "th"              | "TH"
  /// "Turkish"            | "tr"              | "TR"
  /// "Chinese"            | "zh"              | "CN"
  /// ..............................................................
  ///
  static final List<Language> psSupportedLanguageList = <Language>[
    Language(languageCode: 'en', countryCode: 'US', name: 'English'),
    Language(languageCode: 'ar', countryCode: 'DZ', name: 'Arabic'),
    Language(languageCode: 'hi', countryCode: 'IN', name: 'Hindi'),
    Language(languageCode: 'de', countryCode: 'DE', name: 'German'),
    Language(languageCode: 'es', countryCode: 'ES', name: 'Spainish'),
    Language(languageCode: 'fr', countryCode: 'FR', name: 'French'),
    Language(languageCode: 'id', countryCode: 'ID', name: 'Indonesian'),
    Language(languageCode: 'it', countryCode: 'IT', name: 'Italian'),
    Language(languageCode: 'ja', countryCode: 'JP', name: 'Japanese'),
    Language(languageCode: 'ko', countryCode: 'KR', name: 'Korean'),
    Language(languageCode: 'ms', countryCode: 'MY', name: 'Malay'),
    Language(languageCode: 'pt', countryCode: 'PT', name: 'Portuguese'),
    Language(languageCode: 'ru', countryCode: 'RU', name: 'Russian'),
    Language(languageCode: 'th', countryCode: 'TH', name: 'Thai'),
    Language(languageCode: 'tr', countryCode: 'TR', name: 'Turkish'),
    Language(languageCode: 'zh', countryCode: 'CN', name: 'Chinese'),
  ];

  ///
  /// Tmp Image Folder Name
  ///
  static const String tmpImageFolderName = 'PSXMPC';

  ///
  /// set showLog [True] to enable log
  ///
  static bool showLog = false;

  ///
  ///CategorySortingListViewContainer Witget List
  ///
  ///
  static const List<String> categoryVerticalList = <String>[
    'category_vertical_list',
  ];
  static const List<String> orderDetailView = <String>[
    'order_list',
  ];

  static const String mobile_dashboard_screen = 'ps-smb00001';
  static const String search_header = 'ps-cmb00001';
  static const String header_card = 'ps-cmb00035'; 
  static const String category_horizontal_list_component = 'ps-cmb00003';
  static const String feature_item_horizontal_list_component = 'ps-cmb00004';
  static const String blog_product_slider_component = 'ps-cmb00002';
  static const String popular_item_horizontal_list_component = 'ps-cmb00011';
  static const String discount_item_horizontal_list_component = 'ps-cmb00010';
  static const String recent_item_horizontal_list_component = 'ps-cmb00006';
  static const String top_seller_horizontal_list_component = 'ps-cmb00008';
  static const String post_type_horizontal_list_component = 'ps-cmb00036';
  static const String nearest_item_horizontal_list_component = 'ps-cmb00009';
  static const String followers_item_horizontal_list_component = 'ps-cmb00012';
  static const String item_vertical_list_nav_component = 'ps-cmb00046';
  static const String item_vertical_list_component = 'ps-cmb00047';
   static const String promote_widget = 'ps-cmb00032';

  static const String vendor_card_component = 'ps-cmb00007';
  static const String latest_vendor_list = 'ps-cmb00005';

  /// Default Dashboard widget
  static const List<String> defaultHomeWidgetList = <String>[
    search_header,
 //   blog_product_slider_component,//
    category_horizontal_list_component,
    feature_item_horizontal_list_component,
    latest_vendor_list,
    recent_item_horizontal_list_component,
    vendor_card_component,
    top_seller_horizontal_list_component,
    nearest_item_horizontal_list_component,
    discount_item_horizontal_list_component,
    popular_item_horizontal_list_component,
    followers_item_horizontal_list_component,
    item_vertical_list_nav_component,
    item_vertical_list_component
  ];

  static List<String> homeWidgetList = <String>[];

  static const List<String> blogDetailsWidgetList = <String>[
    'blog_detail',
  ];
  static const List<String> productDetailsWidgetList = <String>[
    'product_expandable_appbar',
    'product_title_with_edit_favorite',
    'product_price',
    'product_location',
    'product_description',
    'product_details_info',
   // 'product_safety_tips_tile',
    'product_terms_and_condition',
    'product_faq_tile',
   // 'product_statistic_tile',
  //  'product_contact_list',
    'product_seller_info_tile',
    'product_vendor_info_tile',
    'related_product_list',
  ];
  static const List<String> profileDetailsWidgetList = <String>[
    'profile_detail',
    'profile_vendor_application_card',
    'profile_my_vendor',
    'paid_product_list',
    'active_product_list',
    'pending_product_list_widget',
    'soldout_product_list',
    'rejected_listing_data',
    'disabled_listing_data',
  ];
  static const List<String> productListWithFilterWidgetList = <String>[
    'filter_nav_items',
    'filter_item_list_view',
    'ps_admob_banner_widget',
  ];

  static const List<String> vendorListWithFilterWidgetList = <String>[
    'filter_vendor_nav',
    'filter_vendor_list_view'
  ];

  ///
  /// Item Entry Cache Control Setting
  ///
  static const bool cacheInItemEntry = false;
}
