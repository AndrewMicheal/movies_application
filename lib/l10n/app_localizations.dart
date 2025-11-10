import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @find_your_next_favorite_movie_here.
  ///
  /// In en, this message translates to:
  /// **'Find Your Next Favorite Movie Here'**
  String get find_your_next_favorite_movie_here;

  /// No description provided for @get_access_to_a_huge.
  ///
  /// In en, this message translates to:
  /// **'Get access to a huge library of movies to suit all tastes. You will surely like it.'**
  String get get_access_to_a_huge;

  /// No description provided for @discover_movies.
  ///
  /// In en, this message translates to:
  /// **'Discover Movies'**
  String get discover_movies;

  /// No description provided for @explore_a_vast_collection.
  ///
  /// In en, this message translates to:
  /// **'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.'**
  String get explore_a_vast_collection;

  /// No description provided for @explore_all_genres.
  ///
  /// In en, this message translates to:
  /// **'Explore All Genres'**
  String get explore_all_genres;

  /// No description provided for @discover_movies_from_every_genre.
  ///
  /// In en, this message translates to:
  /// **'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.'**
  String get discover_movies_from_every_genre;

  /// No description provided for @create_Watchlists.
  ///
  /// In en, this message translates to:
  /// **'Create Watchlists'**
  String get create_Watchlists;

  /// No description provided for @save_movies_to_your_watchlist_to_keep.
  ///
  /// In en, this message translates to:
  /// **'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.'**
  String get save_movies_to_your_watchlist_to_keep;

  /// No description provided for @rate_review_and_learn.
  ///
  /// In en, this message translates to:
  /// **'Rate, Review, and Learn'**
  String get rate_review_and_learn;

  /// No description provided for @share_your_thoughts_on_the_movies.
  ///
  /// In en, this message translates to:
  /// **'Share your thoughts on the movies you\'ve watched. Dive deep into film details and help others discover great movies with your reviews.'**
  String get share_your_thoughts_on_the_movies;

  /// No description provided for @start_Watching_now.
  ///
  /// In en, this message translates to:
  /// **'Start Watching Now'**
  String get start_Watching_now;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @explore_now.
  ///
  /// In en, this message translates to:
  /// **'Explore Now'**
  String get explore_now;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forget_password;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t Have Account'**
  String get dont_have_account;

  /// No description provided for @create_one.
  ///
  /// In en, this message translates to:
  /// **'Create One'**
  String get create_one;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @login_with_google.
  ///
  /// In en, this message translates to:
  /// **'Login With Google'**
  String get login_with_google;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
