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

  /// `{count} items`
  String medicinesItemsCount(Object count) {
    return Intl.message(
      '$count items',
      name: 'medicinesItemsCount',
      desc: '',
      args: [count],
    );
  }

  /// `{count} remaining`
  String medicineRemaining(Object count) {
    return Intl.message(
      '$count remaining',
      name: 'medicineRemaining',
      desc: '',
      args: [count],
    );
  }

  /// `Expires {date}`
  String medicineExpires(Object date) {
    return Intl.message(
      'Expires $date',
      name: 'medicineExpires',
      desc: '',
      args: [date],
    );
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

  /// `Ended stock`
  String get commonLowStock {
    return Intl.message(
      'Ended stock',
      name: 'commonLowStock',
      desc: '',
      args: [],
    );
  }

  /// `Expired`
  String get commonExpired {
    return Intl.message('Expired', name: 'commonExpired', desc: '', args: []);
  }

  /// `Something went wrong, please try again.`
  String get commonTryAgain {
    return Intl.message(
      'Something went wrong, please try again.',
      name: 'commonTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get commonUser {
    return Intl.message('User', name: 'commonUser', desc: '', args: []);
  }

  /// `capsules`
  String get commonCapsules {
    return Intl.message('capsules', name: 'commonCapsules', desc: '', args: []);
  }

  /// `bottles`
  String get commonBottles {
    return Intl.message('bottles', name: 'commonBottles', desc: '', args: []);
  }

  /// `units`
  String get commonUnits {
    return Intl.message('units', name: 'commonUnits', desc: '', args: []);
  }

  /// `Success`
  String get commonSuccess {
    return Intl.message('Success', name: 'commonSuccess', desc: '', args: []);
  }

  /// `Something went wrong`
  String get commonError {
    return Intl.message(
      'Something went wrong',
      name: 'commonError',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get commonSomethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'commonSomethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get commonRetry {
    return Intl.message('Retry', name: 'commonRetry', desc: '', args: []);
  }

  /// `Please try again later`
  String get commonTryAgainLater {
    return Intl.message(
      'Please try again later',
      name: 'commonTryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get commonClose {
    return Intl.message('Close', name: 'commonClose', desc: '', args: []);
  }

  /// `Home`
  String get homeNavLabel {
    return Intl.message('Home', name: 'homeNavLabel', desc: '', args: []);
  }

  /// `Medicines`
  String get medicinesNavLabel {
    return Intl.message(
      'Medicines',
      name: 'medicinesNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `Alerts`
  String get alertsNavLabel {
    return Intl.message('Alerts', name: 'alertsNavLabel', desc: '', args: []);
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

  /// `Logging in...`
  String get authLoggingIn {
    return Intl.message(
      'Logging in...',
      name: 'authLoggingIn',
      desc: '',
      args: [],
    );
  }

  /// `Creating account...`
  String get authCreatingAccount {
    return Intl.message(
      'Creating account...',
      name: 'authCreatingAccount',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get authPasswordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'authPasswordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Reset Your Password`
  String get authResetPasswordTitle {
    return Intl.message(
      'Reset Your Password',
      name: 'authResetPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address and we'll send you a link to reset your password.`
  String get authResetPasswordSubtitle {
    return Intl.message(
      'Enter your email address and we\'ll send you a link to reset your password.',
      name: 'authResetPasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Sending...`
  String get authSendingResetEmail {
    return Intl.message(
      'Sending...',
      name: 'authSendingResetEmail',
      desc: '',
      args: [],
    );
  }

  /// `Send Reset Link`
  String get authSendResetEmail {
    return Intl.message(
      'Send Reset Link',
      name: 'authSendResetEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password reset email sent successfully.`
  String get authResetPasswordSuccess {
    return Intl.message(
      'Password reset email sent successfully.',
      name: 'authResetPasswordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Logged in successfully`
  String get authLoginSuccess {
    return Intl.message(
      'Logged in successfully',
      name: 'authLoginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Account created successfully`
  String get authRegisterSuccess {
    return Intl.message(
      'Account created successfully',
      name: 'authRegisterSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Logged in with Google successfully`
  String get authGoogleSuccess {
    return Intl.message(
      'Logged in with Google successfully',
      name: 'authGoogleSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address.`
  String get authInvalidEmail {
    return Intl.message(
      'Please enter a valid email address.',
      name: 'authInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `No account was found with this email.`
  String get authUserNotFound {
    return Intl.message(
      'No account was found with this email.',
      name: 'authUserNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect email or password.`
  String get authWrongPassword {
    return Intl.message(
      'Incorrect email or password.',
      name: 'authWrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect email or password.`
  String get authInvalidCredential {
    return Intl.message(
      'Incorrect email or password.',
      name: 'authInvalidCredential',
      desc: '',
      args: [],
    );
  }

  /// `This email is already in use.`
  String get authEmailAlreadyInUse {
    return Intl.message(
      'This email is already in use.',
      name: 'authEmailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Your password is too weak.`
  String get authWeakPassword {
    return Intl.message(
      'Your password is too weak.',
      name: 'authWeakPassword',
      desc: '',
      args: [],
    );
  }

  /// `Too many attempts. Please try again later.`
  String get authTooManyRequests {
    return Intl.message(
      'Too many attempts. Please try again later.',
      name: 'authTooManyRequests',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection.`
  String get authNetworkError {
    return Intl.message(
      'Please check your internet connection.',
      name: 'authNetworkError',
      desc: '',
      args: [],
    );
  }

  /// `You don't have permission to perform this action.`
  String get authPermissionDenied {
    return Intl.message(
      'You don\'t have permission to perform this action.',
      name: 'authPermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `The requested resource was not found.`
  String get authResourceNotFound {
    return Intl.message(
      'The requested resource was not found.',
      name: 'authResourceNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Our server is having trouble. Please try again later.`
  String get authServerError {
    return Intl.message(
      'Our server is having trouble. Please try again later.',
      name: 'authServerError',
      desc: '',
      args: [],
    );
  }

  /// `Your session has expired. Please login again.`
  String get authSessionExpired {
    return Intl.message(
      'Your session has expired. Please login again.',
      name: 'authSessionExpired',
      desc: '',
      args: [],
    );
  }

  /// `This account has been disabled.`
  String get authUserDisabled {
    return Intl.message(
      'This account has been disabled.',
      name: 'authUserDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Operation not allowed. Please contact support.`
  String get authOperationNotAllowed {
    return Intl.message(
      'Operation not allowed. Please contact support.',
      name: 'authOperationNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `An account already exists with the same email address using a different login method.`
  String get authAccountExistsWithDifferentCredential {
    return Intl.message(
      'An account already exists with the same email address using a different login method.',
      name: 'authAccountExistsWithDifferentCredential',
      desc: '',
      args: [],
    );
  }

  /// `Google sign-in was cancelled.`
  String get authGoogleSignInCancelled {
    return Intl.message(
      'Google sign-in was cancelled.',
      name: 'authGoogleSignInCancelled',
      desc: '',
      args: [],
    );
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

  /// `Know what you have`
  String get onboardingTitle1 {
    return Intl.message(
      'Know what you have',
      name: 'onboardingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Keep every medicine your household owns organized in one clear, shared place.`
  String get onboardingDesc1 {
    return Intl.message(
      'Keep every medicine your household owns organized in one clear, shared place.',
      name: 'onboardingDesc1',
      desc: '',
      args: [],
    );
  }

  /// `Never miss an expiry`
  String get onboardingTitle2 {
    return Intl.message(
      'Never miss an expiry',
      name: 'onboardingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Get a gentle nudge before a medicine expires, or before you run low on it.`
  String get onboardingDesc2 {
    return Intl.message(
      'Get a gentle nudge before a medicine expires, or before you run low on it.',
      name: 'onboardingDesc2',
      desc: '',
      args: [],
    );
  }

  /// `Check before you buy`
  String get onboardingTitle3 {
    return Intl.message(
      'Check before you buy',
      name: 'onboardingTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Scan a medicine at the store and instantly see if your household already has it.`
  String get onboardingDesc3 {
    return Intl.message(
      'Scan a medicine at the store and instantly see if your household already has it.',
      name: 'onboardingDesc3',
      desc: '',
      args: [],
    );
  }

  /// `Get started`
  String get onboardingGetStarted {
    return Intl.message(
      'Get started',
      name: 'onboardingGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get onboardingContinue {
    return Intl.message(
      'Continue',
      name: 'onboardingContinue',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get onboardingSkip {
    return Intl.message('Skip', name: 'onboardingSkip', desc: '', args: []);
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

  /// `Expires tomorrow`
  String get homeExpiresTomorrow {
    return Intl.message(
      'Expires tomorrow',
      name: 'homeExpiresTomorrow',
      desc: '',
      args: [],
    );
  }

  /// `Expires in {count} days`
  String homeExpiresInDays(Object count) {
    return Intl.message(
      'Expires in $count days',
      name: 'homeExpiresInDays',
      desc: '',
      args: [count],
    );
  }

  /// `Expires in 1 month`
  String get homeExpiresInMonth {
    return Intl.message(
      'Expires in 1 month',
      name: 'homeExpiresInMonth',
      desc: '',
      args: [],
    );
  }

  /// `Expires in {count} months`
  String homeExpiresInMonths(Object count) {
    return Intl.message(
      'Expires in $count months',
      name: 'homeExpiresInMonths',
      desc: '',
      args: [count],
    );
  }

  /// `Added today`
  String get homeAddedToday {
    return Intl.message(
      'Added today',
      name: 'homeAddedToday',
      desc: '',
      args: [],
    );
  }

  /// `Added yesterday`
  String get homeAddedYesterday {
    return Intl.message(
      'Added yesterday',
      name: 'homeAddedYesterday',
      desc: '',
      args: [],
    );
  }

  /// `Added {count} days ago`
  String homeAddedDaysAgo(Object count) {
    return Intl.message(
      'Added $count days ago',
      name: 'homeAddedDaysAgo',
      desc: '',
      args: [count],
    );
  }

  /// `{count} tablets remaining`
  String homeTabletsRemaining(Object count) {
    return Intl.message(
      '$count tablets remaining',
      name: 'homeTabletsRemaining',
      desc: '',
      args: [count],
    );
  }

  /// `{count} capsules remaining`
  String homeCapsulesRemaining(Object count) {
    return Intl.message(
      '$count capsules remaining',
      name: 'homeCapsulesRemaining',
      desc: '',
      args: [count],
    );
  }

  /// `{count} bottles remaining`
  String homeBottlesRemaining(Object count) {
    return Intl.message(
      '$count bottles remaining',
      name: 'homeBottlesRemaining',
      desc: '',
      args: [count],
    );
  }

  /// `{count} units remaining`
  String homeUnitsRemaining(Object count) {
    return Intl.message(
      '$count units remaining',
      name: 'homeUnitsRemaining',
      desc: '',
      args: [count],
    );
  }

  /// `{count} remaining`
  String homeRemaining(Object count) {
    return Intl.message(
      '$count remaining',
      name: 'homeRemaining',
      desc: '',
      args: [count],
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

  /// `Expiry date`
  String get medicinesSortOptionExpiry {
    return Intl.message(
      'Expiry date',
      name: 'medicinesSortOptionExpiry',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get medicinesSortOptionQuantity {
    return Intl.message(
      'Quantity',
      name: 'medicinesSortOptionQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Recently added`
  String get medicinesSortOptionRecentlyAdded {
    return Intl.message(
      'Recently added',
      name: 'medicinesSortOptionRecentlyAdded',
      desc: '',
      args: [],
    );
  }

  /// `No medicines found`
  String get medicinesNoMedicines {
    return Intl.message(
      'No medicines found',
      name: 'medicinesNoMedicines',
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

  /// `Personal Information`
  String get profilePersonalInformationTitle {
    return Intl.message(
      'Personal Information',
      name: 'profilePersonalInformationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get profileFullName {
    return Intl.message(
      'Full Name',
      name: 'profileFullName',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get profileEmailAddress {
    return Intl.message(
      'Email Address',
      name: 'profileEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Change Photo`
  String get profileChangePhoto {
    return Intl.message(
      'Change Photo',
      name: 'profileChangePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get profileSaveChanges {
    return Intl.message(
      'Save Changes',
      name: 'profileSaveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profileUpdateSuccess {
    return Intl.message(
      'Profile updated successfully',
      name: 'profileUpdateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Name is required`
  String get profileNameRequired {
    return Intl.message(
      'Name is required',
      name: 'profileNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Failed to upload profile picture.`
  String get profileImageUploadFailed {
    return Intl.message(
      'Failed to upload profile picture.',
      name: 'profileImageUploadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Saving changes...`
  String get profileSavingChanges {
    return Intl.message(
      'Saving changes...',
      name: 'profileSavingChanges',
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

  /// `Language`
  String get profileLanguage {
    return Intl.message(
      'Language',
      name: 'profileLanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get profileEnglish {
    return Intl.message('English', name: 'profileEnglish', desc: '', args: []);
  }

  /// `Arabic`
  String get profileArabic {
    return Intl.message('Arabic', name: 'profileArabic', desc: '', args: []);
  }

  /// `App version`
  String get profileAppVersion {
    return Intl.message(
      'App version',
      name: 'profileAppVersion',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get profileInformationSection {
    return Intl.message(
      'Information',
      name: 'profileInformationSection',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Cabinet helps you manage your medicines, expiry dates, and stock levels easily.`
  String get profileAboutDescription {
    return Intl.message(
      'Medicine Cabinet helps you manage your medicines, expiry dates, and stock levels easily.',
      name: 'profileAboutDescription',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get profileLogout {
    return Intl.message('Logout', name: 'profileLogout', desc: '', args: []);
  }

  /// `Are you sure you want to logout?`
  String get profileLogoutConfirmation {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'profileLogoutConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `You are not authenticated. Please log in again.`
  String get profileUserNotAuthenticated {
    return Intl.message(
      'You are not authenticated. Please log in again.',
      name: 'profileUserNotAuthenticated',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load your profile. Please try again.`
  String get profileLoadFailed {
    return Intl.message(
      'Unable to load your profile. Please try again.',
      name: 'profileLoadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Unable to update your profile. Please try again.`
  String get profileUpdateFailed {
    return Intl.message(
      'Unable to update your profile. Please try again.',
      name: 'profileUpdateFailed',
      desc: '',
      args: [],
    );
  }

  /// `Profile not found.`
  String get profileNotFound {
    return Intl.message(
      'Profile not found.',
      name: 'profileNotFound',
      desc: '',
      args: [],
    );
  }

  /// `You don't have permission to perform this operation.`
  String get profilePermissionDenied {
    return Intl.message(
      'You don\'t have permission to perform this operation.',
      name: 'profilePermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection and try again.`
  String get profileNetworkError {
    return Intl.message(
      'Please check your internet connection and try again.',
      name: 'profileNetworkError',
      desc: '',
      args: [],
    );
  }

  /// `The operation could not be completed. Please try again.`
  String get profileOperationFailed {
    return Intl.message(
      'The operation could not be completed. Please try again.',
      name: 'profileOperationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again later.`
  String get profileServerError {
    return Intl.message(
      'Something went wrong. Please try again later.',
      name: 'profileServerError',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Cabinet`
  String get splashWordmark {
    return Intl.message(
      'Medicine Cabinet',
      name: 'splashWordmark',
      desc: '',
      args: [],
    );
  }

  /// `Your household medicines, organized in one place.`
  String get splashTagline {
    return Intl.message(
      'Your household medicines, organized in one place.',
      name: 'splashTagline',
      desc: '',
      args: [],
    );
  }

  /// `Setting up your cabinet...`
  String get splashLoadingText {
    return Intl.message(
      'Setting up your cabinet...',
      name: 'splashLoadingText',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWrong',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, please try again later.`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong, please try again later.',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load user profile`
  String get failedToLoadProfile {
    return Intl.message(
      'Failed to load user profile',
      name: 'failedToLoadProfile',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load medicines`
  String get failedToLoadMedicines {
    return Intl.message(
      'Failed to load medicines',
      name: 'failedToLoadMedicines',
      desc: '',
      args: [],
    );
  }

  /// `You don't have permission to perform this action.`
  String get errorPermissionDenied {
    return Intl.message(
      'You don\'t have permission to perform this action.',
      name: 'errorPermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection or server is unavailable.`
  String get errorNoInternet {
    return Intl.message(
      'No internet connection or server is unavailable.',
      name: 'errorNoInternet',
      desc: '',
      args: [],
    );
  }

  /// `The requested resource was not found.`
  String get errorNotFound {
    return Intl.message(
      'The requested resource was not found.',
      name: 'errorNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Connection timed out. The server is not responding.`
  String get errorTimeout {
    return Intl.message(
      'Connection timed out. The server is not responding.',
      name: 'errorTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Your session has expired. Please login again.`
  String get errorSessionExpired {
    return Intl.message(
      'Your session has expired. Please login again.',
      name: 'errorSessionExpired',
      desc: '',
      args: [],
    );
  }

  /// `Our server is having trouble. Please try again in a few minutes.`
  String get errorInternalServer {
    return Intl.message(
      'Our server is having trouble. Please try again in a few minutes.',
      name: 'errorInternalServer',
      desc: '',
      args: [],
    );
  }

  /// `Invalid information provided. Please check your inputs.`
  String get errorInvalidInput {
    return Intl.message(
      'Invalid information provided. Please check your inputs.',
      name: 'errorInvalidInput',
      desc: '',
      args: [],
    );
  }

  /// `We encountered a technical issue while processing data.`
  String get errorTechnicalIssue {
    return Intl.message(
      'We encountered a technical issue while processing data.',
      name: 'errorTechnicalIssue',
      desc: '',
      args: [],
    );
  }

  /// `A database error occurred.`
  String get errorDatabase {
    return Intl.message(
      'A database error occurred.',
      name: 'errorDatabase',
      desc: '',
      args: [],
    );
  }

  /// `Email cannot be empty`
  String get validationEmailRequired {
    return Intl.message(
      'Email cannot be empty',
      name: 'validationEmailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email address`
  String get validationInvalidEmail {
    return Intl.message(
      'Enter a valid email address',
      name: 'validationInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password cannot be empty`
  String get validationPasswordRequired {
    return Intl.message(
      'Password cannot be empty',
      name: 'validationPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid password`
  String get validationInvalidPassword {
    return Intl.message(
      'Enter a valid password',
      name: 'validationInvalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get validationPasswordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'validationPasswordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Name cannot be empty`
  String get validationNameRequired {
    return Intl.message(
      'Name cannot be empty',
      name: 'validationNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Phone number cannot be empty`
  String get validationPhoneRequired {
    return Intl.message(
      'Phone number cannot be empty',
      name: 'validationPhoneRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid phone number`
  String get validationInvalidPhone {
    return Intl.message(
      'Enter a valid phone number',
      name: 'validationInvalidPhone',
      desc: '',
      args: [],
    );
  }

  /// `Code cannot be empty`
  String get validationCodeRequired {
    return Intl.message(
      'Code cannot be empty',
      name: 'validationCodeRequired',
      desc: '',
      args: [],
    );
  }

  /// `Code should be at least 6 digits`
  String get validationCodeLength {
    return Intl.message(
      'Code should be at least 6 digits',
      name: 'validationCodeLength',
      desc: '',
      args: [],
    );
  }

  /// `Start typing to search for medicines`
  String get searchStartTyping {
    return Intl.message(
      'Start typing to search for medicines',
      name: 'searchStartTyping',
      desc: '',
      args: [],
    );
  }

  /// `No medicines found`
  String get searchNoResults {
    return Intl.message(
      'No medicines found',
      name: 'searchNoResults',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back`
  String get welcomeBack {
    return Intl.message(
      'Welcome back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Scan Medicine`
  String get scanMedicineTitle {
    return Intl.message(
      'Scan Medicine',
      name: 'scanMedicineTitle',
      desc: '',
      args: [],
    );
  }

  /// `Align medicine box or strip in frame`
  String get scanHintAlignBox {
    return Intl.message(
      'Align medicine box or strip in frame',
      name: 'scanHintAlignBox',
      desc: '',
      args: [],
    );
  }

  /// `Analyzing Medicine`
  String get scanAnalyzingTitle {
    return Intl.message(
      'Analyzing Medicine',
      name: 'scanAnalyzingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please wait while we read and process\nthe package details...`
  String get scanAnalyzingSubtitle {
    return Intl.message(
      'Please wait while we read and process\nthe package details...',
      name: 'scanAnalyzingSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Missing Information`
  String get scanMissingInfoTitle {
    return Intl.message(
      'Missing Information',
      name: 'scanMissingInfoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please review and fill in the required details.`
  String get scanMissingInfoDesc {
    return Intl.message(
      'Please review and fill in the required details.',
      name: 'scanMissingInfoDesc',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Medicine`
  String get scanConfirmMedicineTitle {
    return Intl.message(
      'Confirm Medicine',
      name: 'scanConfirmMedicineTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please review and confirm details before saving to your cabinet.`
  String get scanReviewConfirmNotice {
    return Intl.message(
      'Please review and confirm details before saving to your cabinet.',
      name: 'scanReviewConfirmNotice',
      desc: '',
      args: [],
    );
  }

  /// `Medicine added successfully!`
  String get scanMedicineAddedSuccess {
    return Intl.message(
      'Medicine added successfully!',
      name: 'scanMedicineAddedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to add medicine`
  String get scanFailedToAddMedicine {
    return Intl.message(
      'Failed to add medicine',
      name: 'scanFailedToAddMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Package Photo`
  String get scanPackagePhotoTitle {
    return Intl.message(
      'Package Photo',
      name: 'scanPackagePhotoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Retake`
  String get scanRetakePhoto {
    return Intl.message('Retake', name: 'scanRetakePhoto', desc: '', args: []);
  }

  /// `No medicine photo preview`
  String get scanNoPhotoPreview {
    return Intl.message(
      'No medicine photo preview',
      name: 'scanNoPhotoPreview',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Details`
  String get scanMedicineDetailsTitle {
    return Intl.message(
      'Medicine Details',
      name: 'scanMedicineDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Name`
  String get scanMedicineNameLabel {
    return Intl.message(
      'Medicine Name',
      name: 'scanMedicineNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Panadol Extra, Amoxicillin`
  String get scanMedicineNameHint {
    return Intl.message(
      'e.g. Panadol Extra, Amoxicillin',
      name: 'scanMedicineNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the medicine name`
  String get scanMedicineNameValidation {
    return Intl.message(
      'Please enter the medicine name',
      name: 'scanMedicineNameValidation',
      desc: '',
      args: [],
    );
  }

  /// `Category / Active Ingredient`
  String get scanCategoryLabel {
    return Intl.message(
      'Category / Active Ingredient',
      name: 'scanCategoryLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Pain Relief, Antibiotic, Paracetamol`
  String get scanCategoryHint {
    return Intl.message(
      'e.g. Pain Relief, Antibiotic, Paracetamol',
      name: 'scanCategoryHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter category or active ingredient`
  String get scanCategoryValidation {
    return Intl.message(
      'Please enter category or active ingredient',
      name: 'scanCategoryValidation',
      desc: '',
      args: [],
    );
  }

  /// `Form / Type`
  String get scanFormTypeLabel {
    return Intl.message(
      'Form / Type',
      name: 'scanFormTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Tablets, Syrup`
  String get scanFormTypeHint {
    return Intl.message(
      'e.g. Tablets, Syrup',
      name: 'scanFormTypeHint',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get scanFieldRequired {
    return Intl.message(
      'Required',
      name: 'scanFieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `YYYY-MM-DD`
  String get scanExpiryDateHint {
    return Intl.message(
      'YYYY-MM-DD',
      name: 'scanExpiryDateHint',
      desc: '',
      args: [],
    );
  }

  /// `Please select the expiry date`
  String get scanExpiryDateValidation {
    return Intl.message(
      'Please select the expiry date',
      name: 'scanExpiryDateValidation',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Bedroom Drawer, Fridge, Medicine Box`
  String get scanStorageLocationHint {
    return Intl.message(
      'e.g. Bedroom Drawer, Fridge, Medicine Box',
      name: 'scanStorageLocationHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter storage location`
  String get scanStorageLocationValidation {
    return Intl.message(
      'Please enter storage location',
      name: 'scanStorageLocationValidation',
      desc: '',
      args: [],
    );
  }

  /// `Notes & Dosage Instructions`
  String get scanNotesLabel {
    return Intl.message(
      'Notes & Dosage Instructions',
      name: 'scanNotesLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Take 1 tablet after meals twice daily`
  String get scanNotesHint {
    return Intl.message(
      'e.g. Take 1 tablet after meals twice daily',
      name: 'scanNotesHint',
      desc: '',
      args: [],
    );
  }

  /// `Select profile`
  String get scanSelectProfile {
    return Intl.message(
      'Select profile',
      name: 'scanSelectProfile',
      desc: '',
      args: [],
    );
  }

  /// `No household members found`
  String get scanNoMembersFound {
    return Intl.message(
      'No household members found',
      name: 'scanNoMembersFound',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load members`
  String get scanFailedToLoadMembers {
    return Intl.message(
      'Failed to load members',
      name: 'scanFailedToLoadMembers',
      desc: '',
      args: [],
    );
  }

  /// `Units`
  String get scanUnitsDefault {
    return Intl.message('Units', name: 'scanUnitsDefault', desc: '', args: []);
  }

  /// `Add Medicine`
  String get scanAddMedicineButton {
    return Intl.message(
      'Add Medicine',
      name: 'scanAddMedicineButton',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Cabinet`
  String get medicineCabinet {
    return Intl.message(
      'Medicine Cabinet',
      name: 'medicineCabinet',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get medicineCategoryAll {
    return Intl.message('All', name: 'medicineCategoryAll', desc: '', args: []);
  }

  /// `Recently Added`
  String get medicineCategoryRecentlyAdded {
    return Intl.message(
      'Recently Added',
      name: 'medicineCategoryRecentlyAdded',
      desc: '',
      args: [],
    );
  }

  /// `Ended`
  String get medicineCategoryEnded {
    return Intl.message(
      'Ended',
      name: 'medicineCategoryEnded',
      desc: '',
      args: [],
    );
  }

  /// `Expired`
  String get medicineCategoryExpired {
    return Intl.message(
      'Expired',
      name: 'medicineCategoryExpired',
      desc: '',
      args: [],
    );
  }

  /// `Quantity: {quantity}`
  String medicineQuantity(Object quantity) {
    return Intl.message(
      'Quantity: $quantity',
      name: 'medicineQuantity',
      desc: '',
      args: [quantity],
    );
  }

  /// `No medicines found`
  String get medicineNoMedicines {
    return Intl.message(
      'No medicines found',
      name: 'medicineNoMedicines',
      desc: '',
      args: [],
    );
  }

  /// `No recently added medicines`
  String get medicineNoRecentlyAdded {
    return Intl.message(
      'No recently added medicines',
      name: 'medicineNoRecentlyAdded',
      desc: '',
      args: [],
    );
  }

  /// `No ended medicines`
  String get medicineNoEnded {
    return Intl.message(
      'No ended medicines',
      name: 'medicineNoEnded',
      desc: '',
      args: [],
    );
  }

  /// `No expired medicines`
  String get medicineNoExpired {
    return Intl.message(
      'No expired medicines',
      name: 'medicineNoExpired',
      desc: '',
      args: [],
    );
  }

  /// `Valid`
  String get medicineCategoryValid {
    return Intl.message(
      'Valid',
      name: 'medicineCategoryValid',
      desc: '',
      args: [],
    );
  }

  /// `Valid`
  String get medicineStatusValid {
    return Intl.message(
      'Valid',
      name: 'medicineStatusValid',
      desc: '',
      args: [],
    );
  }

  /// `Expired`
  String get medicineStatusExpired {
    return Intl.message(
      'Expired',
      name: 'medicineStatusExpired',
      desc: '',
      args: [],
    );
  }

  /// `Ended`
  String get medicineStatusEnded {
    return Intl.message(
      'Ended',
      name: 'medicineStatusEnded',
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
