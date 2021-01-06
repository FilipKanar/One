import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one/l10n/messages_all.dart';

class AppLocalization {

  static Future<AppLocalization> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalization();
    });
  }

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  // list of locales
  String get errorSignInCredentials {
    return Intl.message(
      'Could not sign in with those credentials',
      name: 'errorSignInCredentials',
      desc: 'Error message Sign In Credentials',
    );
  }
  String get errorSignUpCredentials {
    return Intl.message(
      'Could not sign up with those credentials',
      name: 'errorSignUpCredentials',
      desc: 'Error message Sign Up Credentials',
    );
  }
  String get appOverview {
    return Intl.message(
      'Overview',
      name: 'appOverview',
      desc: 'Button text for signing to overview app',
    );
  }
  String get emailPlaceholder {
    return Intl.message(
      'Email',
      name: 'emailPlaceholder',
      desc: 'Email Placeholder',
    );
  }
  String get usernamePlaceholder {
    return Intl.message(
      'Username',
      name: 'usernamePlaceholder',
      desc: 'Username Placeholder',
    );
  }
  String get passwordPlaceholder {
    return Intl.message(
      'Password',
      name: 'passwordPlaceholder',
      desc: 'Password Placeholder',
    );
  }
  String get confirmPasswordPlaceholder {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordPlaceholder',
      desc: 'Confirm Password Placeholder',
    );
  }
  String get logInPlaceholder {
    return Intl.message(
      'Log In',
      name: 'logInPlaceholder',
      desc: 'Log In Placeholder',
    );
  }
  String get registerPlaceholder {
    return Intl.message(
      'Register',
      name: 'registerPlaceholder',
      desc: 'Register Placeholder',
    );
  }
  String get acceptPlaceholder {
    return Intl.message(
      'Accept',
      name: 'acceptPlaceholder',
      desc: 'Accept Placeholder',
    );
  }
  String get privacyPolicyPlaceholder {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicyPlaceholder',
      desc: 'Privacy Policy Placeholder',
    );
  }
  String get loginSuccessfulToast {
    return Intl.message(
      'Login Successful',
      name: 'loginSuccessfulToast',
      desc: 'Toast message for successful login',
    );
  }
  String get registrationSuccessfulToast {
    return Intl.message(
      'Registration Successful',
      name: 'registrationSuccessfulToast',
      desc: 'Toast message for successful registration',
    );
  }
  String get googlePrivacyPolicyMessage {
    return Intl.message(
      'Privacy Policy required for google authentication',
      name: 'googlePrivacyPolicyMessage',
      desc: 'Error message for google authentication without privacy policy check',
    );
  }
  String get testUserLogInErrorMessage {
    return Intl.message(
      'Could not sign in to test account',
      name: 'testUserLogInErrorMessage',
      desc: 'Error message for overview sign in',
    );
  }
  String get appTitle {
    return Intl.message(
      'App title',
      name: 'appTitle',
      desc: 'App title',
    );
  }
  String get userPositionPlaceholder {
    return Intl.message(
      'Your position',
      name: 'userPositionPlaceholder',
      desc: 'User position',
    );
  }
  String get userScorePlaceholder {
    return Intl.message(
      'Your Score',
      name: 'userScorePlaceholder',
      desc: 'User score',
    );
  }
  String get profilePlaceholder {
    return Intl.message(
      'Profile',
      name: 'profilePlaceholder',
      desc: 'Profile screen title',
    );
  }
  String get changePlaceholder {
    return Intl.message(
      'Change',
      name: 'changePlaceholder',
      desc: 'Change placeholder',
    );
  }
  String get trashCollectedPlaceholder {
    return Intl.message(
      'Trash Collected',
      name: 'trashCollectedPlaceholder',
      desc: 'Trash Collected placeholder',
    );
  }
  String get pointsCreatedPlaceholder {
    return Intl.message(
      'Points Created',
      name: 'pointsCreatedPlaceholder',
      desc: 'Points Created placeholder',
    );
  }
  String get noPictureProvidedErrorTitle {
    return Intl.message(
      'No picture provided',
      name: 'noPictureProvidedErrorTitle',
      desc: 'No picture provided during point creation title',
    );
  }
  String get noPictureProvidedErrorMessage {
    return Intl.message(
      'No picture provided during point creation error message',
      name: 'noPictureProvidedErrorMessage',
      desc: 'No picture provided during point creation error message',
    );
  }
  String get publicPlaceholder {
    return Intl.message(
      'Public placeholder',
      name: 'publicPlaceholder',
      desc: 'Public placeholder',
    );
  }
  String get newCleaningPointTitle {
    return Intl.message(
      'New cleaning point',
      name: 'newCleaningPointTitle',
      desc: 'New cleaning point screen title',
    );
  }
  String get descriptionLengthValidator {
    return Intl.message(
      'Provide description longer than 5 signs',
      name: 'descriptionLengthValidator',
      desc: 'Validator message for description length < 5',
    );
  }
  String get pointNameHintText {
    return Intl.message(
      'Name this point',
      name: 'pointNameHintText',
      desc: 'Point Name Hint Text',
    );
  }
  String get saveAndContinueTip {
    return Intl.message(
      'Save and continue',
      name: 'saveAndContinueTip',
      desc: 'Save and continue tip text',
    );
  }
  String get commentsScreenTitle {
    return Intl.message(
      'Comments',
      name: 'commentsScreenTitle',
      desc: 'Comments Screen Title text',
    );
  }
  String get newCommentHintText {
    return Intl.message(
      'New comment',
      name: 'newCommentHintText',
      desc: 'New comment hint text',
    );
  }
  String get newCommentLengthValidatorText {
    return Intl.message(
      'Comment must be at least 10 characters long',
      name: 'newCommentLengthValidatorText',
      desc: 'New comment length <10 validator text',
    );
  }
  String get newCommentAddErrorMessage {
    return Intl.message(
      'Failed adding comment',
      name: 'newCommentAddErrorMessage',
      desc: 'Error message for comment add failure',
    );
  }
  String get noCommentsToDisplayMessage {
    return Intl.message(
      'No comments to display',
      name: 'noCommentsToDisplayMessage',
      desc: 'No comments to display message',
    );
  }
  String get noPointsToDisplayMessage {
    return Intl.message(
      'No Points to display',
      name: 'noPointsToDisplayMessage',
      desc: 'No Points to display message',
    );
  }
  String get firstCleaningAchievementTextTitle {
    return Intl.message(
      'First Cleaning achievement title',
      name: 'firstCleaningAchievementTextTitle',
      desc: 'Achievement field title: First Cleaning',
    );
  }
  String get addPointPlaceholder {
    return Intl.message(
      'Add New Point',
      name: 'addPointPlaceholder',
      desc: 'Add New Point placeholder',
    );
  }
  String get firstCleaningAchievementTextMessage {
    return Intl.message(
      'First Cleaning achievement message',
      name: 'firstCleaningAchievementTextMessage',
      desc: 'Achievement field message: First Cleaning',
    );
  }
  String get fiveCleaningAchievementTextTitle {
    return Intl.message(
      'Five Cleanings achievement title',
      name: 'fiveCleaningAchievementTextTitle',
      desc: 'Achievement field title: Five Cleanings',
    );
  }
  String get fiveCleaningAchievementTextMessage {
    return Intl.message(
      'Five Cleanings achievement message',
      name: 'fiveCleaningAchievementTextMessage',
      desc: 'Achievement field message: Five Cleanings',
    );
  }
  String get tenCleaningAchievementTextTitle {
    return Intl.message(
      'Ten Cleanings achievement title',
      name: 'tenCleaningAchievementTextTitle',
      desc: 'Achievement field title: Ten Cleanings',
    );
  }
  String get tenCleaningAchievementTextMessage {
    return Intl.message(
      'Ten Cleanings achievement message',
      name: 'fiveCleaningAchievementTextMessage',
      desc: 'Achievement field message: Ten Cleanings',
    );
  }
  String get twentyFiveCleaningAchievementTextTitle {
    return Intl.message(
      'Twenty Five Cleanings achievement title',
      name: 'twentyFiveCleaningAchievementTextTitle',
      desc: 'Achievement field title: Twenty Five Cleanings',
    );
  }
  String get twentyFiveCleaningAchievementTextMessage {
    return Intl.message(
      'Twenty Five Cleanings achievement message',
      name: 'twentyFiveCleaningAchievementTextMessage',
      desc: 'Achievement field message: Twenty Five Cleanings',
    );
  }
  String get fiftyCleaningAchievementTextTitle {
    return Intl.message(
      'Fifty Cleanings achievement title',
      name: 'fiftyCleaningAchievementTextTitle',
      desc: 'Achievement field title: Fifty Cleanings',
    );
  }
  String get fiftyFiveCleaningAchievementTextMessage {
    return Intl.message(
      'Fifty Cleanings achievement message',
      name: 'fiftyFiveCleaningAchievementTextMessage',
      desc: 'Achievement field message: Fifty Cleanings',
    );
  }
  String get hundredCleaningAchievementTextTitle {
    return Intl.message(
      'Hundred Cleanings achievement title',
      name: 'hundredCleaningAchievementTextTitle',
      desc: 'Achievement field title: Hundred Cleanings',
    );
  }
  String get hundredFiveCleaningAchievementTextMessage {
    return Intl.message(
      'Hundred Cleanings achievement message',
      name: 'hundredFiveCleaningAchievementTextMessage',
      desc: 'Achievement field message: Hundred Cleanings',
    );
  }
  String get firstPointAchievementTextTitle {
    return Intl.message(
      'First point achievement title',
      name: 'firstPointAchievementTextTitle',
      desc: 'Achievement field title: Create One cleaning point',
    );
  }
  String get firstPointAchievementTextMessage {
    return Intl.message(
      'First point achievement message',
      name: 'firstPointAchievementTextMessage',
      desc: 'Achievement field message: Create One point',
    );
  }
  String get fivePointAchievementTextTitle {
    return Intl.message(
      'Five points achievement title',
      name: 'fivePointAchievementTextTitle',
      desc: 'Achievement field title: Create Five cleaning point',
    );
  }
  String get fivePointAchievementTextMessage {
    return Intl.message(
      'Five points achievement message',
      name: 'fivePointAchievementTextMessage',
      desc: 'Achievement field message: Create Five points',
    );
  }
  String get tenPointAchievementTextTitle {
    return Intl.message(
      'Ten points achievement title',
      name: 'tenPointAchievementTextTitle',
      desc: 'Achievement field title: Create Ten cleaning point',
    );
  }
  String get tenPointAchievementTextMessage {
    return Intl.message(
      'Ten points achievement message',
      name: 'tenPointAchievementTextMessage',
      desc: 'Achievement field message: Create Ten points',
    );
  }
  String get twentyFivePointAchievementTextTitle {
    return Intl.message(
      'Ten points achievement title',
      name: 'twentyFivePointAchievementTextTitle',
      desc: 'Achievement field title: Create Twenty five cleaning point',
    );
  }
  String get twentyFivePointAchievementTextMessage {
    return Intl.message(
      'Ten points achievement message',
      name: 'twentyFivePointAchievementTextMessage',
      desc: 'Achievement field message: Create Twenty five points',
    );
  }
  String get fiftyPointAchievementTextTitle {
    return Intl.message(
      'Fifty points achievement title',
      name: 'fiftyPointAchievementTextTitle',
      desc: 'Achievement field title: Create Fifty cleaning point',
    );
  }
  String get fiftyPointAchievementTextMessage {
    return Intl.message(
      'Ten points achievement message',
      name: 'fiftyPointAchievementTextMessage',
      desc: 'Achievement field message: Create Fifty points',
    );
  }
  String get addPointButtonText {
    return Intl.message(
      'Add new point',
      name: 'addPointButtonText',
      desc: 'Button message for creating new point at current location',
    );
  }
  String get noCommentToDisplayPlaceholder {
    return Intl.message(
      'Add new point',
      name: 'noCommentToDisplayPlaceholder',
      desc: 'Button message for creating new point at current location',
    );
  }
  String get changeUsernamePlaceholder {
    return Intl.message(
      'Change Username',
      name: 'changeUsernamePlaceholder',
      desc: 'Change username placeholder',
    );
  }
  String get scorePlaceholder {
    return Intl.message(
      'Score',
      name: 'scorePlaceholder',
      desc: 'Score placeholder',
    );
  }
  String get provideValidEmailValidationText {
    return Intl.message(
      'Please provide a valid email',
      name: 'provideValidEmailValidationText',
      desc: 'Email validation error message',
    );
  }
  String get passwordLengthValidationText {
    return Intl.message(
      'The password must be at least 6 characters long and contain at least 1 numeric and capital letter',
      name: 'passwordLengthValidationText',
      desc: 'Password validation error message',
    );
  }
  String get passwordConformationValidationText {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordConformationValidationText',
      desc: 'Password confirmation, Passwords do not match message',
    );
  }
  String get usernameLengthValidationText {
    return Intl.message(
      'The username must be at least 6 characters long',
      name: 'usernameLengthValidationText',
      desc: 'The username must be at least 6 characters long',
    );
  }
  String get chooseUsernameDialogMessage {
    return Intl.message(
      'Your username will be visible to other users',
      name: 'chooseUsernameDialogMessage',
      desc: 'Your username will be visible to other users',
    );
  }
  String get locationPermissionWarningTitle {
    return Intl.message(
      'Permission',
      name: 'locationPermissionWarningTitle',
      desc: 'Permission warning title',
    );
  }
  String get locationPermissionWarningMessage {
    return Intl.message(
      'Location permission required',
      name: 'locationPermissionWarningMessage',
      desc: 'Permission warning message',
    );
  }
  String get storagePermissionWarningTitle {
    return Intl.message(
      'Storage',
      name: 'storagePermissionWarningTitle',
      desc: 'Storage permission warning title',
    );
  }
  String get storagePermissionWarningMessage {
    return Intl.message(
      'Storage permission required',
      name: 'storagePermissionWarningMessage',
      desc: 'Storage permission required warning message',
    );
  }
  String get testUserWarningTitle {
    return Intl.message(
      'Test User',
      name: 'testUserWarningTitle',
      desc: 'Test User',
    );
  }
  String get testUserWarningMessage {
    return Intl.message(
      'You are signed in as a test user. Create an account to clean the world.',
      name: 'testUserWarningMessage',
      desc: 'Test User warning message',
    );
  }
  String get continuePlaceholder {
    return Intl.message(
      'Continue',
      name: 'continuePlaceholder',
      desc: 'Continue placeholder',
    );
  }
  String get cancelPlaceholder {
    return Intl.message(
      'Cancel',
      name: 'cancelPlaceholder',
      desc: 'Cancel placeholder',
    );
  }
  String get allowPermissionPlaceholder {
    return Intl.message(
      'Allow Permission',
      name: 'allowPermissionPlaceholder',
      desc: 'Allow Permission Placeholder',
    );
  }
  String get pointNamePlaceholder {
    return Intl.message(
      'Point name',
      name: 'pointNamePlaceholder',
      desc: 'Point name Placeholder',
    );
  }
  String get commentDeleteDialogTitle {
    return Intl.message(
      'Delete comment',
      name: 'commentDeleteDialogTitle',
      desc: 'Delete comment dialog title',
    );
  }
  String get commentDeleteDialogMessage {
    return Intl.message(
      'Are you sure that you want to permanently delete selected comment?',
      name: 'commentDeleteDialogMessage',
      desc: 'Delete comment dialog message',
    );
  }
  String get pointDeleteDialogTitle {
    return Intl.message(
      'Delete point?',
      name: 'pointDeleteDialogTitle',
      desc: 'Delete point dialog message',
    );
  }
  String get pointDeleteDialogMessage {
    return Intl.message(
      'Are you sure that you want to permanently delete selected point?',
      name: 'pointDeleteDialogMessage',
      desc: 'Delete comment dialog title',
    );
  }
  String get yesPlaceholder {
    return Intl.message(
      'Yes',
      name: 'yesPlaceholder',
      desc: 'Yes',
    );
  }
  String get cleaningDeleteDialogTitle {
    return Intl.message(
      'Delete Cleaning',
      name: 'cleaningDeleteDialogTitle',
      desc: 'Delete cleaning dialog title',
    );
  }
  String get cleaningDeleteDialogMessage {
    return Intl.message(
      'Are you sure that you want to permanently delete selected cleaning?',
      name: 'cleaningDeleteDialogMessage',
      desc: 'Delete cleaning dialog message',
    );
  }
  String get lastTrashAtPointPlaceholder {
    return Intl.message(
      'Its last trash at this point',
      name: 'lastTrashAtPointPlaceholder',
      desc: 'checkbox message, last cleaning at point',
    );
  }
  String get addCleaningDialogTitle {
    return Intl.message(
      'Add cleaning',
      name: 'addCleaningDialogTitle',
      desc: 'Add cleaning dialog title',
    );
  }
  String get addCleaningDialogMessage {
    return Intl.message(
      'Add cleaning',
      name: 'addCleaningDialogMessage',
      desc: 'Add cleaning dialog message',
    );
  }
  String get lastCleaningHintMessage {
    return Intl.message(
      'last Cleaning Hint message',
      name: 'lastCleaningHintMessage',
      desc: 'last Cleaning Hint message',
    );
  }
  String get lastCleaningPublicButtonText {
    return Intl.message(
      'Public both',
      name: 'lastCleaningPublicButtonText',
      desc: 'last Cleaning Hint message',
    );
  }
  String get lastCleaningPublicHintMessage {
    return Intl.message(
      'last Cleaning public Hint message',
      name: 'lastCleaningPublicHintMessage',
      desc: 'last Cleaning public Hint message',
    );
  }
  String get oneAndOnlyCleaningPublicHintMessage {
    return Intl.message(
      'oneAndOnlyCleaning Hint message',
      name: 'oneAndOnlyCleaningPublicHintMessage',
      desc: 'oneAndOnlyCleaning Hint message',
    );
  }
  String get backPlaceholder {
    return Intl.message(
      'Back',
      name: 'backPlaceholder',
      desc: 'Back placeholder',
    );
  }
}