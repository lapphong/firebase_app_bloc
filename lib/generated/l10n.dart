// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get emailAddress {
    return Intl.message(
      'Email address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address`
  String get enterYourEmailAddress {
    return Intl.message(
      'Enter your email address',
      name: 'enterYourEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Password`
  String get enterYourPassword {
    return Intl.message(
      'Enter your Password',
      name: 'enterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signInBtn {
    return Intl.message(
      'Sign in',
      name: 'signInBtn',
      desc: '',
      args: [],
    );
  }

  /// `Or continue with social account`
  String get orContinueWithSocialAccount {
    return Intl.message(
      'Or continue with social account',
      name: 'orContinueWithSocialAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign In with Google`
  String get signInWithGoogle {
    return Intl.message(
      'Sign In with Google',
      name: 'signInWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Sign In with Facebook`
  String get signInWithFacebook {
    return Intl.message(
      'Sign In with Facebook',
      name: 'signInWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? Create Here`
  String get donotHaveAnAccount {
    return Intl.message(
      'Don\'t have an account? Create Here',
      name: 'donotHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Hi {name}`
  String hi(Object name) {
    return Intl.message(
      'Hi $name',
      name: 'hi',
      desc: '',
      args: [name],
    );
  }

  /// `Welcome back to Udemy, Explore Course`
  String get welcomeBackToUdemy {
    return Intl.message(
      'Welcome back to Udemy, Explore Course',
      name: 'welcomeBackToUdemy',
      desc: '',
      args: [],
    );
  }

  /// `Search your focus...`
  String get searchYourFocus {
    return Intl.message(
      'Search your focus...',
      name: 'searchYourFocus',
      desc: '',
      args: [],
    );
  }

  /// `Get 20% Discount`
  String get get20Discount {
    return Intl.message(
      'Get 20% Discount',
      name: 'get20Discount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up or log in to your premium\naccount to get unlimited access.`
  String get signUpOrLoginToYourPremiumAccountToGetUnlimitedAccess {
    return Intl.message(
      'Sign up or log in to your premium\naccount to get unlimited access.',
      name: 'signUpOrLoginToYourPremiumAccountToGetUnlimitedAccess',
      desc: '',
      args: [],
    );
  }

  /// `Best Mentors`
  String get bestMentors {
    return Intl.message(
      'Best Mentors',
      name: 'bestMentors',
      desc: '',
      args: [],
    );
  }

  /// `Class Preview`
  String get classPreview {
    return Intl.message(
      'Class Preview',
      name: 'classPreview',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get seeAll {
    return Intl.message(
      'See all',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Preview`
  String get preview {
    return Intl.message(
      'Preview',
      name: 'preview',
      desc: '',
      args: [],
    );
  }

  /// `Activity`
  String get activity {
    return Intl.message(
      'Activity',
      name: 'activity',
      desc: '',
      args: [],
    );
  }

  /// `Your Today s Progress Almost Done!`
  String get yourTodaysProgressAlmostDone {
    return Intl.message(
      'Your Today s Progress Almost Done!',
      name: 'yourTodaysProgressAlmostDone',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Uncompleted`
  String get uncompleted {
    return Intl.message(
      'Uncompleted',
      name: 'uncompleted',
      desc: '',
      args: [],
    );
  }

  /// `Incomplete`
  String get incomplete {
    return Intl.message(
      'Incomplete',
      name: 'incomplete',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get complete {
    return Intl.message(
      'Complete',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `Great work!`
  String get greatWork {
    return Intl.message(
      'Great work!',
      name: 'greatWork',
      desc: '',
      args: [],
    );
  }

  /// `You finished all of your courses `
  String get youFinishedAllOfYourCourses {
    return Intl.message(
      'You finished all of your courses ',
      name: 'youFinishedAllOfYourCourses',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Business`
  String get business {
    return Intl.message(
      'Business',
      name: 'business',
      desc: '',
      args: [],
    );
  }

  /// `{} Mentors`
  String get mentors {
    return Intl.message(
      '{} Mentors',
      name: 'mentors',
      desc: '',
      args: [],
    );
  }

  /// `Design`
  String get design {
    return Intl.message(
      'Design',
      name: 'design',
      desc: '',
      args: [],
    );
  }

  /// `Entertainment`
  String get entertainment {
    return Intl.message(
      'Entertainment',
      name: 'entertainment',
      desc: '',
      args: [],
    );
  }

  /// `Food`
  String get food {
    return Intl.message(
      'Food',
      name: 'food',
      desc: '',
      args: [],
    );
  }

  /// `IT & Software`
  String get itsoftware {
    return Intl.message(
      'IT & Software',
      name: 'itsoftware',
      desc: '',
      args: [],
    );
  }

  /// `Music`
  String get music {
    return Intl.message(
      'Music',
      name: 'music',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `ACCOUNT SETTING`
  String get accountSetting {
    return Intl.message(
      'ACCOUNT SETTING',
      name: 'accountSetting',
      desc: '',
      args: [],
    );
  }

  /// `Change Phone Number`
  String get changePhoneNumber {
    return Intl.message(
      'Change Phone Number',
      name: 'changePhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `APPLICATION`
  String get application {
    return Intl.message(
      'APPLICATION',
      name: 'application',
      desc: '',
      args: [],
    );
  }

  /// `Download Video`
  String get downloadVideo {
    return Intl.message(
      'Download Video',
      name: 'downloadVideo',
      desc: '',
      args: [],
    );
  }

  /// `My Favorite`
  String get myFavorite {
    return Intl.message(
      'My Favorite',
      name: 'myFavorite',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `EDIT AVATAR`
  String get editAvatar {
    return Intl.message(
      'EDIT AVATAR',
      name: 'editAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Change Avatar`
  String get changeAvatar {
    return Intl.message(
      'Change Avatar',
      name: 'changeAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Edit avatar are visible only on Udemy.`
  String get editAvatarAreVisibleOnlyOnUdemy {
    return Intl.message(
      'Edit avatar are visible only on Udemy.',
      name: 'editAvatarAreVisibleOnlyOnUdemy',
      desc: '',
      args: [],
    );
  }

  /// `EDIT INFORMATION`
  String get editInformation {
    return Intl.message(
      'EDIT INFORMATION',
      name: 'editInformation',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Create Here`
  String get createHere {
    return Intl.message(
      'Create Here',
      name: 'createHere',
      desc: '',
      args: [],
    );
  }

  /// `Email is valid`
  String get emailIsValid {
    return Intl.message(
      'Email is valid',
      name: 'emailIsValid',
      desc: '',
      args: [],
    );
  }

  /// `Password is valid`
  String get passwordIsValid {
    return Intl.message(
      'Password is valid',
      name: 'passwordIsValid',
      desc: '',
      args: [],
    );
  }

  /// `{name} field`
  String snackBarFailed(Object name) {
    return Intl.message(
      '$name field',
      name: 'snackBarFailed',
      desc: '',
      args: [name],
    );
  }

  /// `{name} Successfully`
  String snackBarSuccessfully(Object name) {
    return Intl.message(
      '$name Successfully',
      name: 'snackBarSuccessfully',
      desc: '',
      args: [name],
    );
  }

  /// `Confirm Password is valid`
  String get confirmPasswordIsValid {
    return Intl.message(
      'Confirm Password is valid',
      name: 'confirmPasswordIsValid',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyAccount',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Name`
  String get enterYourName {
    return Intl.message(
      'Enter your Name',
      name: 'enterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Confirm`
  String get enterYourConfirm {
    return Intl.message(
      'Enter your Confirm',
      name: 'enterYourConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Name is valid`
  String get nameIsValid {
    return Intl.message(
      'Name is valid',
      name: 'nameIsValid',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja', countryCode: 'JP'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
