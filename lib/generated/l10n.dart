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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Continue`
  String get commonContinue {
    return Intl.message('Continue', name: 'commonContinue', desc: '', args: []);
  }

  /// `Skip`
  String get commonSkip {
    return Intl.message('Skip', name: 'commonSkip', desc: '', args: []);
  }

  /// `Get started`
  String get commonGetStarted {
    return Intl.message(
      'Get started',
      name: 'commonGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get commonCancel {
    return Intl.message('Cancel', name: 'commonCancel', desc: '', args: []);
  }

  /// `Apply`
  String get commonApply {
    return Intl.message('Apply', name: 'commonApply', desc: '', args: []);
  }

  /// `Delete`
  String get commonDelete {
    return Intl.message('Delete', name: 'commonDelete', desc: '', args: []);
  }

  /// `Edit details`
  String get commonEditDetails {
    return Intl.message(
      'Edit details',
      name: 'commonEditDetails',
      desc: '',
      args: [],
    );
  }

  /// `Update quantity`
  String get commonUpdateQuantity {
    return Intl.message(
      'Update quantity',
      name: 'commonUpdateQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Mark as used`
  String get commonMarkAsUsed {
    return Intl.message(
      'Mark as used',
      name: 'commonMarkAsUsed',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get commonSeeAll {
    return Intl.message('See all', name: 'commonSeeAll', desc: '', args: []);
  }

  /// `Manage`
  String get commonManage {
    return Intl.message('Manage', name: 'commonManage', desc: '', args: []);
  }

  /// `Review`
  String get commonReview {
    return Intl.message('Review', name: 'commonReview', desc: '', args: []);
  }

  /// `or`
  String get commonOr {
    return Intl.message('or', name: 'commonOr', desc: '', args: []);
  }

  /// `Add to Cabinet`
  String get commonAddToCabinet {
    return Intl.message(
      'Add to Cabinet',
      name: 'commonAddToCabinet',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get commonAll {
    return Intl.message('All', name: 'commonAll', desc: '', args: []);
  }

  /// `Household`
  String get commonHousehold {
    return Intl.message(
      'Household',
      name: 'commonHousehold',
      desc: '',
      args: [],
    );
  }

  /// `Owner`
  String get commonOwner {
    return Intl.message('Owner', name: 'commonOwner', desc: '', args: []);
  }

  /// `Quantity`
  String get commonQuantity {
    return Intl.message('Quantity', name: 'commonQuantity', desc: '', args: []);
  }

  /// `Expiry date`
  String get commonExpiryDate {
    return Intl.message(
      'Expiry date',
      name: 'commonExpiryDate',
      desc: '',
      args: [],
    );
  }

  /// `Date added`
  String get commonDateAdded {
    return Intl.message(
      'Date added',
      name: 'commonDateAdded',
      desc: '',
      args: [],
    );
  }

  /// `Storage location`
  String get commonStorageLocation {
    return Intl.message(
      'Storage location',
      name: 'commonStorageLocation',
      desc: '',
      args: [],
    );
  }

  /// `Healthy`
  String get commonHealthy {
    return Intl.message('Healthy', name: 'commonHealthy', desc: '', args: []);
  }

  /// `Expiring soon`
  String get commonExpiringSoon {
    return Intl.message(
      'Expiring soon',
      name: 'commonExpiringSoon',
      desc: '',
      args: [],
    );
  }

  /// `Expiring`
  String get commonExpiringShort {
    return Intl.message(
      'Expiring',
      name: 'commonExpiringShort',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get commonLow {
    return Intl.message('Low', name: 'commonLow', desc: '', args: []);
  }

  /// `Low stock`
  String get commonLowStock {
    return Intl.message(
      'Low stock',
      name: 'commonLowStock',
      desc: '',
      args: [],
    );
  }

  /// `Expired`
  String get commonExpired {
    return Intl.message('Expired', name: 'commonExpired', desc: '', args: []);
  }

  /// `Home`
  String get homeNavLabel {
    return Intl.message('Home', name: 'homeNavLabel', desc: '', args: []);
  }

  /// `Medicines`
  String get medicinesTitle {
    return Intl.message(
      'Medicines',
      name: 'medicinesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Alerts`
  String get alertsTitle {
    return Intl.message('Alerts', name: 'alertsTitle', desc: '', args: []);
  }

  /// `Profile`
  String get profileNavLabel {
    return Intl.message('Profile', name: 'profileNavLabel', desc: '', args: []);
  }

  /// `Welcome back`
  String get authLoginTitle {
    return Intl.message(
      'Welcome back',
      name: 'authLoginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Log in to see your household's medicine cabinet.`
  String get authLoginSubtitle {
    return Intl.message(
      'Log in to see your household\'s medicine cabinet.',
      name: 'authLoginSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get authEmailLabel {
    return Intl.message('Email', name: 'authEmailLabel', desc: '', args: []);
  }

  /// `Password`
  String get authPasswordLabel {
    return Intl.message(
      'Password',
      name: 'authPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get authForgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'authForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get authLoginButton {
    return Intl.message('Log in', name: 'authLoginButton', desc: '', args: []);
  }

  /// `Continue with Google`
  String get authContinueWithGoogle {
    return Intl.message(
      'Continue with Google',
      name: 'authContinueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get authNoAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'authNoAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get authSignUpLink {
    return Intl.message('Sign up', name: 'authSignUpLink', desc: '', args: []);
  }

  /// `Create your account`
  String get authRegisterTitle {
    return Intl.message(
      'Create your account',
      name: 'authRegisterTitle',
      desc: '',
      args: [],
    );
  }

  /// `Set up your household's medicine cabinet in a minute.`
  String get authRegisterSubtitle {
    return Intl.message(
      'Set up your household\'s medicine cabinet in a minute.',
      name: 'authRegisterSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get authFullNameLabel {
    return Intl.message(
      'Full name',
      name: 'authFullNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get authConfirmPasswordLabel {
    return Intl.message(
      'Confirm password',
      name: 'authConfirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `By continuing, you agree to the Terms and Privacy Policy.`
  String get authTermsNotice {
    return Intl.message(
      'By continuing, you agree to the Terms and Privacy Policy.',
      name: 'authTermsNotice',
      desc: '',
      args: [],
    );
  }

  /// `Create account`
  String get authRegisterButton {
    return Intl.message(
      'Create account',
      name: 'authRegisterButton',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get authHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'authHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get authLoginLink {
    return Intl.message('Log in', name: 'authLoginLink', desc: '', args: []);
  }

  /// `Know what you have`
  String get onboardingKnowTitle {
    return Intl.message(
      'Know what you have',
      name: 'onboardingKnowTitle',
      desc: '',
      args: [],
    );
  }

  /// `Keep every medicine your household owns organized in one clear, shared place.`
  String get onboardingKnowDesc {
    return Intl.message(
      'Keep every medicine your household owns organized in one clear, shared place.',
      name: 'onboardingKnowDesc',
      desc: '',
      args: [],
    );
  }

  /// `Never miss an expiry`
  String get onboardingExpiryTitle {
    return Intl.message(
      'Never miss an expiry',
      name: 'onboardingExpiryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Get a gentle nudge before a medicine expires, or before you run low on it.`
  String get onboardingExpiryDesc {
    return Intl.message(
      'Get a gentle nudge before a medicine expires, or before you run low on it.',
      name: 'onboardingExpiryDesc',
      desc: '',
      args: [],
    );
  }

  /// `Check before you buy`
  String get onboardingBuyTitle {
    return Intl.message(
      'Check before you buy',
      name: 'onboardingBuyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Scan a medicine at the store and instantly see if your household already has it.`
  String get onboardingBuyDesc {
    return Intl.message(
      'Scan a medicine at the store and instantly see if your household already has it.',
      name: 'onboardingBuyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Good evening, {name}`
  String homeGreetingEvening(Object name) {
    return Intl.message(
      'Good evening, $name',
      name: 'homeGreetingEvening',
      desc: '',
      args: [name],
    );
  }

  /// `Here's your medicine cabinet`
  String get homeSubtitle {
    return Intl.message(
      'Here\'s your medicine cabinet',
      name: 'homeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Scan Medicine`
  String get homeScanCta {
    return Intl.message(
      'Scan Medicine',
      name: 'homeScanCta',
      desc: '',
      args: [],
    );
  }

  /// `Add a new item in seconds`
  String get homeScanCtaSubtitle {
    return Intl.message(
      'Add a new item in seconds',
      name: 'homeScanCtaSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Attention needed`
  String get homeAttentionNeeded {
    return Intl.message(
      'Attention needed',
      name: 'homeAttentionNeeded',
      desc: '',
      args: [],
    );
  }

  /// `Recently added`
  String get homeRecentlyAdded {
    return Intl.message(
      'Recently added',
      name: 'homeRecentlyAdded',
      desc: '',
      args: [],
    );
  }

  /// `Your cabinet is empty`
  String get homeEmptyTitle {
    return Intl.message(
      'Your cabinet is empty',
      name: 'homeEmptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Scan the first medicine you own and it'll show up here, organized and ready to track.`
  String get homeEmptyDesc {
    return Intl.message(
      'Scan the first medicine you own and it\'ll show up here, organized and ready to track.',
      name: 'homeEmptyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Scan your first medicine`
  String get homeEmptyButton {
    return Intl.message(
      'Scan your first medicine',
      name: 'homeEmptyButton',
      desc: '',
      args: [],
    );
  }

  /// `Search medicines...`
  String get medicinesSearchHint {
    return Intl.message(
      'Search medicines...',
      name: 'medicinesSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `Sort by`
  String get medicinesSortBy {
    return Intl.message('Sort by', name: 'medicinesSortBy', desc: '', args: []);
  }

  /// `Sort: {sortOption}`
  String medicinesSortLabelCurrent(Object sortOption) {
    return Intl.message(
      'Sort: $sortOption',
      name: 'medicinesSortLabelCurrent',
      desc: '',
      args: [sortOption],
    );
  }

  /// `Name (A–Z)`
  String get medicinesSortOptionName {
    return Intl.message(
      'Name (A–Z)',
      name: 'medicinesSortOptionName',
      desc: '',
      args: [],
    );
  }

  /// `This removes it from your cabinet inventory. This can't be undone.`
  String get medicineDetailsDeleteDesc {
    return Intl.message(
      'This removes it from your cabinet inventory. This can\'t be undone.',
      name: 'medicineDetailsDeleteDesc',
      desc: '',
      args: [],
    );
  }

  /// `Align the package label within the frame`
  String get scanHint {
    return Intl.message(
      'Align the package label within the frame',
      name: 'scanHint',
      desc: '',
      args: [],
    );
  }

  /// `Capture`
  String get scanCapture {
    return Intl.message('Capture', name: 'scanCapture', desc: '', args: []);
  }

  /// `Enter details manually`
  String get scanEnterManually {
    return Intl.message(
      'Enter details manually',
      name: 'scanEnterManually',
      desc: '',
      args: [],
    );
  }

  /// `Medicine found`
  String get scanMedicineFoundTitle {
    return Intl.message(
      'Medicine found',
      name: 'scanMedicineFoundTitle',
      desc: '',
      args: [],
    );
  }

  /// `Who is this for?`
  String get scanWhoIsThisFor {
    return Intl.message(
      'Who is this for?',
      name: 'scanWhoIsThisFor',
      desc: '',
      args: [],
    );
  }

  /// `Someone else`
  String get scanSomeoneElse {
    return Intl.message(
      'Someone else',
      name: 'scanSomeoneElse',
      desc: '',
      args: [],
    );
  }

  /// `How many do you have?`
  String get scanHowManyDoYouHave {
    return Intl.message(
      'How many do you have?',
      name: 'scanHowManyDoYouHave',
      desc: '',
      args: [],
    );
  }

  /// `tablets`
  String get scanUnitTablets {
    return Intl.message('tablets', name: 'scanUnitTablets', desc: '', args: []);
  }

  /// `Added to your cabinet`
  String get scanAddedTitle {
    return Intl.message(
      'Added to your cabinet',
      name: 'scanAddedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Scan another`
  String get scanScanAnother {
    return Intl.message(
      'Scan another',
      name: 'scanScanAnother',
      desc: '',
      args: [],
    );
  }

  /// `Back to Home`
  String get scanBackToHome {
    return Intl.message(
      'Back to Home',
      name: 'scanBackToHome',
      desc: '',
      args: [],
    );
  }

  /// `Before You Buy`
  String get beforeYouBuyTitle {
    return Intl.message(
      'Before You Buy',
      name: 'beforeYouBuyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Scan or search a medicine...`
  String get beforeYouBuySearchHint {
    return Intl.message(
      'Scan or search a medicine...',
      name: 'beforeYouBuySearchHint',
      desc: '',
      args: [],
    );
  }

  /// `Already in your cabinet`
  String get beforeYouBuyAlreadyTitle {
    return Intl.message(
      'Already in your cabinet',
      name: 'beforeYouBuyAlreadyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Owned by`
  String get beforeYouBuyOwnedBy {
    return Intl.message(
      'Owned by',
      name: 'beforeYouBuyOwnedBy',
      desc: '',
      args: [],
    );
  }

  /// `Expires`
  String get beforeYouBuyExpires {
    return Intl.message(
      'Expires',
      name: 'beforeYouBuyExpires',
      desc: '',
      args: [],
    );
  }

  /// `You may already have this medicine at home.`
  String get beforeYouBuyNotice {
    return Intl.message(
      'You may already have this medicine at home.',
      name: 'beforeYouBuyNotice',
      desc: '',
      args: [],
    );
  }

  /// `Not in your cabinet`
  String get beforeYouBuyNotFoundTitle {
    return Intl.message(
      'Not in your cabinet',
      name: 'beforeYouBuyNotFoundTitle',
      desc: '',
      args: [],
    );
  }

  /// `No matching medicine found`
  String get beforeYouBuyNoMatchTitle {
    return Intl.message(
      'No matching medicine found',
      name: 'beforeYouBuyNoMatchTitle',
      desc: '',
      args: [],
    );
  }

  /// `Expiry`
  String get alertsFilterExpiry {
    return Intl.message(
      'Expiry',
      name: 'alertsFilterExpiry',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get alertsToday {
    return Intl.message('Today', name: 'alertsToday', desc: '', args: []);
  }

  /// `Yesterday`
  String get alertsYesterday {
    return Intl.message(
      'Yesterday',
      name: 'alertsYesterday',
      desc: '',
      args: [],
    );
  }

  /// `Add family member`
  String get householdAddMember {
    return Intl.message(
      'Add family member',
      name: 'householdAddMember',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get profileAccountSection {
    return Intl.message(
      'Account',
      name: 'profileAccountSection',
      desc: '',
      args: [],
    );
  }

  /// `Personal information`
  String get profilePersonalInformation {
    return Intl.message(
      'Personal information',
      name: 'profilePersonalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Reminders`
  String get profileRemindersSection {
    return Intl.message(
      'Reminders',
      name: 'profileRemindersSection',
      desc: '',
      args: [],
    );
  }

  /// `Notification settings`
  String get profileNotificationSettings {
    return Intl.message(
      'Notification settings',
      name: 'profileNotificationSettings',
      desc: '',
      args: [],
    );
  }

  /// `Expiry reminder settings`
  String get profileExpiryReminderSettings {
    return Intl.message(
      'Expiry reminder settings',
      name: 'profileExpiryReminderSettings',
      desc: '',
      args: [],
    );
  }

  /// `Low-stock threshold`
  String get profileLowStockThreshold {
    return Intl.message(
      'Low-stock threshold',
      name: 'profileLowStockThreshold',
      desc: '',
      args: [],
    );
  }

  /// `App`
  String get profileAppSection {
    return Intl.message('App', name: 'profileAppSection', desc: '', args: []);
  }

  /// `Privacy`
  String get profilePrivacy {
    return Intl.message('Privacy', name: 'profilePrivacy', desc: '', args: []);
  }

  /// `App preferences`
  String get profileAppPreferences {
    return Intl.message(
      'App preferences',
      name: 'profileAppPreferences',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get profileDarkMode {
    return Intl.message(
      'Dark mode',
      name: 'profileDarkMode',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get profileAbout {
    return Intl.message('About', name: 'profileAbout', desc: '', args: []);
  }

  /// `Set up your household`
  String get householdSetupTitle {
    return Intl.message(
      'Set up your household',
      name: 'householdSetupTitle',
      desc: '',
      args: [],
    );
  }

  /// `Join an existing household using its ID, or create a new one.`
  String get householdSetupDescription {
    return Intl.message(
      'Join an existing household using its ID, or create a new one.',
      name: 'householdSetupDescription',
      desc: '',
      args: [],
    );
  }

  /// `Household ID`
  String get householdIdLabel {
    return Intl.message(
      'Household ID',
      name: 'householdIdLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter household ID`
  String get householdIdHint {
    return Intl.message(
      'Enter household ID',
      name: 'householdIdHint',
      desc: '',
      args: [],
    );
  }

  /// `Join household`
  String get householdJoinButton {
    return Intl.message(
      'Join household',
      name: 'householdJoinButton',
      desc: '',
      args: [],
    );
  }

  /// `OR`
  String get householdOr {
    return Intl.message('OR', name: 'householdOr', desc: '', args: []);
  }

  /// `Create a new household`
  String get householdCreateButton {
    return Intl.message(
      'Create a new household',
      name: 'householdCreateButton',
      desc: '',
      args: [],
    );
  }

  /// `Create a new household`
  String get createHouseholdTitle {
    return Intl.message(
      'Create a new household',
      name: 'createHouseholdTitle',
      desc: '',
      args: [],
    );
  }

  /// `Give your household a name to help your family stay organized.`
  String get createHouseholdDescription {
    return Intl.message(
      'Give your household a name to help your family stay organized.',
      name: 'createHouseholdDescription',
      desc: '',
      args: [],
    );
  }

  /// `Household name`
  String get householdNameLabel {
    return Intl.message(
      'Household name',
      name: 'householdNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Home Cabinet`
  String get householdNameHint {
    return Intl.message(
      'e.g. Home Cabinet',
      name: 'householdNameHint',
      desc: '',
      args: [],
    );
  }

  /// `As the household owner, you can:`
  String get householdAdminTitle {
    return Intl.message(
      'As the household owner, you can:',
      name: 'householdAdminTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add or remove members`
  String get householdPermissionAdd {
    return Intl.message(
      'Add or remove members',
      name: 'householdPermissionAdd',
      desc: '',
      args: [],
    );
  }

  /// `Manage the household`
  String get householdPermissionManage {
    return Intl.message(
      'Manage the household',
      name: 'householdPermissionManage',
      desc: '',
      args: [],
    );
  }

  /// `View all members' medicines`
  String get householdPermissionView {
    return Intl.message(
      'View all members\' medicines',
      name: 'householdPermissionView',
      desc: '',
      args: [],
    );
  }

  /// `I have a household ID, join it`
  String get householdJoinExistingButton {
    return Intl.message(
      'I have a household ID, join it',
      name: 'householdJoinExistingButton',
      desc: '',
      args: [],
    );
  }

  /// `Household`
  String get householdTitle {
    return Intl.message(
      'Household',
      name: 'householdTitle',
      desc: '',
      args: [],
    );
  }

  /// `{count} medicines`
  String householdMedicineCount(Object count) {
    return Intl.message(
      '$count medicines',
      name: 'householdMedicineCount',
      desc: '',
      args: [count],
    );
  }

  /// `Member Details`
  String get householdMemberDetails {
    return Intl.message(
      'Member Details',
      name: 'householdMemberDetails',
      desc: '',
      args: [],
    );
  }

  /// `Medicines`
  String get medicines {
    return Intl.message('Medicines', name: 'medicines', desc: '', args: []);
  }

  /// `Member Information`
  String get memberInformation {
    return Intl.message(
      'Member Information',
      name: 'memberInformation',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Member Medicines`
  String get memberMedicines {
    return Intl.message(
      'Member Medicines',
      name: 'memberMedicines',
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
      Locale.fromSubtags(languageCode: 'ar'),
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
