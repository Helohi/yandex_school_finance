import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @unhandled_error.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get unhandled_error;

  /// No description provided for @unauthorized.
  ///
  /// In en, this message translates to:
  /// **'You are not authorized'**
  String get unauthorized;

  /// No description provided for @incorrect_id.
  ///
  /// In en, this message translates to:
  /// **'Invalid ID'**
  String get incorrect_id;

  /// No description provided for @id_not_found.
  ///
  /// In en, this message translates to:
  /// **'This ID was not found'**
  String get id_not_found;

  /// No description provided for @account_or_category_not_found.
  ///
  /// In en, this message translates to:
  /// **'Account or category not found'**
  String get account_or_category_not_found;

  /// No description provided for @account_was_not_loaded.
  ///
  /// In en, this message translates to:
  /// **'Account was not loaded'**
  String get account_was_not_loaded;

  /// No description provided for @account_was_not_chosen.
  ///
  /// In en, this message translates to:
  /// **'Account was not chosen'**
  String get account_was_not_chosen;

  /// No description provided for @no_such_categories.
  ///
  /// In en, this message translates to:
  /// **'No such categories'**
  String get no_such_categories;

  /// No description provided for @my_account.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get my_account;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @analysis.
  ///
  /// In en, this message translates to:
  /// **'Analysis'**
  String get analysis;

  /// No description provided for @period_start.
  ///
  /// In en, this message translates to:
  /// **'Period: start'**
  String get period_start;

  /// No description provided for @period_end.
  ///
  /// In en, this message translates to:
  /// **'Period: end'**
  String get period_end;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @my_categories.
  ///
  /// In en, this message translates to:
  /// **'My Categories'**
  String get my_categories;

  /// No description provided for @find_category.
  ///
  /// In en, this message translates to:
  /// **'Find Category'**
  String get find_category;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @remove_account.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get remove_account;

  /// No description provided for @incorrect_balance_entered.
  ///
  /// In en, this message translates to:
  /// **'Incorrect balance entered'**
  String get incorrect_balance_entered;

  /// No description provided for @account_is_not_loaded.
  ///
  /// In en, this message translates to:
  /// **'Account is not loaded, please try again later'**
  String get account_is_not_loaded;

  /// No description provided for @my_incomes.
  ///
  /// In en, this message translates to:
  /// **'My Incomes'**
  String get my_incomes;

  /// No description provided for @my_outcomes.
  ///
  /// In en, this message translates to:
  /// **'My Expenses'**
  String get my_outcomes;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @not_chosen.
  ///
  /// In en, this message translates to:
  /// **'Not chosen'**
  String get not_chosen;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @remove_transaction.
  ///
  /// In en, this message translates to:
  /// **'Delete Transaction'**
  String get remove_transaction;

  /// No description provided for @fill_all_fields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields!'**
  String get fill_all_fields;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @my_history.
  ///
  /// In en, this message translates to:
  /// **'My History'**
  String get my_history;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @end.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get end;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @incomes.
  ///
  /// In en, this message translates to:
  /// **'Incomes'**
  String get incomes;

  /// No description provided for @outcomes.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get outcomes;

  /// No description provided for @accounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get accounts;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @must_enter_4_numbers.
  ///
  /// In en, this message translates to:
  /// **'You must enter 4 digits'**
  String get must_enter_4_numbers;

  /// No description provided for @for_access_verify_identity.
  ///
  /// In en, this message translates to:
  /// **'To access the app, please verify your identity'**
  String get for_access_verify_identity;

  /// No description provided for @incorrect_pin.
  ///
  /// In en, this message translates to:
  /// **'Incorrect PIN'**
  String get incorrect_pin;

  /// No description provided for @system_theme.
  ///
  /// In en, this message translates to:
  /// **'System Theme'**
  String get system_theme;

  /// No description provided for @main_color.
  ///
  /// In en, this message translates to:
  /// **'Main Color'**
  String get main_color;

  /// No description provided for @haptics.
  ///
  /// In en, this message translates to:
  /// **'Haptics'**
  String get haptics;

  /// No description provided for @pin_code.
  ///
  /// In en, this message translates to:
  /// **'PIN code'**
  String get pin_code;

  /// No description provided for @biometric.
  ///
  /// In en, this message translates to:
  /// **'Face ID / Fingerprint'**
  String get biometric;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @about_app.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get about_app;

  /// No description provided for @for_biometric_authorization_you_need_pin.
  ///
  /// In en, this message translates to:
  /// **'A PIN is required for biometric authorization'**
  String get for_biometric_authorization_you_need_pin;

  /// No description provided for @authorize_to_submit.
  ///
  /// In en, this message translates to:
  /// **'Please authorize to confirm'**
  String get authorize_to_submit;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @hard.
  ///
  /// In en, this message translates to:
  /// **'Heavy'**
  String get hard;

  /// No description provided for @choose.
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get choose;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;
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
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
