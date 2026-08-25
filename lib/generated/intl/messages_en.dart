// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count) => "Added ${count} days ago";

  static String m1(count) => "${count} bottles remaining";

  static String m2(count) => "${count} capsules remaining";

  static String m3(count) => "Expires in ${count} days";

  static String m4(count) => "Expires in ${count} months";

  static String m5(name) => "Good evening, ${name}";

  static String m6(count) => "${count} remaining";

  static String m7(count) => "${count} tablets remaining";

  static String m8(count) => "${count} units remaining";

  static String m9(count) => "${count} medicines";

  static String m10(name) =>
      "This will remove ${name} from your household. This can\'t be undone.";

  static String m11(count) => "${count} medicines";

  static String m12(date) => "Expires ${date}";

  static String m13(date) => "Expiry: ${date}";

  static String m14(quantity) => "Quantity: ${quantity}";

  static String m15(count) => "${count} remaining";

  static String m16(count) => "${count} items";

  static String m17(sortOption) => "Sort: ${sortOption}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "alertsFilterExpiry": MessageLookupByLibrary.simpleMessage("Expiry"),
    "alertsNavLabel": MessageLookupByLibrary.simpleMessage("Alerts"),
    "alertsTitle": MessageLookupByLibrary.simpleMessage("Alerts"),
    "alertsToday": MessageLookupByLibrary.simpleMessage("Today"),
    "alertsYesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
    "authAccountExistsWithDifferentCredential":
        MessageLookupByLibrary.simpleMessage(
          "An account already exists with the same email address using a different login method.",
        ),
    "authConfirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Confirm password",
    ),
    "authContinueWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Continue with Google",
    ),
    "authCreatingAccount": MessageLookupByLibrary.simpleMessage(
      "Creating account...",
    ),
    "authEmailAlreadyInUse": MessageLookupByLibrary.simpleMessage(
      "This email is already in use.",
    ),
    "authEmailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "authForgotPassword": MessageLookupByLibrary.simpleMessage(
      "Forgot password?",
    ),
    "authFullNameLabel": MessageLookupByLibrary.simpleMessage("Full name"),
    "authGoogleSignInCancelled": MessageLookupByLibrary.simpleMessage(
      "Google sign-in was cancelled.",
    ),
    "authGoogleSuccess": MessageLookupByLibrary.simpleMessage(
      "Logged in with Google successfully",
    ),
    "authHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "authInvalidCredential": MessageLookupByLibrary.simpleMessage(
      "Incorrect email or password.",
    ),
    "authInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid email address.",
    ),
    "authLoggingIn": MessageLookupByLibrary.simpleMessage("Logging in..."),
    "authLoginButton": MessageLookupByLibrary.simpleMessage("Log in"),
    "authLoginLink": MessageLookupByLibrary.simpleMessage("Log in"),
    "authLoginSubtitle": MessageLookupByLibrary.simpleMessage(
      "Log in to see your household\'s medicine cabinet.",
    ),
    "authLoginSuccess": MessageLookupByLibrary.simpleMessage(
      "Logged in successfully",
    ),
    "authLoginTitle": MessageLookupByLibrary.simpleMessage("Welcome back"),
    "authNetworkError": MessageLookupByLibrary.simpleMessage(
      "Please check your internet connection.",
    ),
    "authNoAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account?",
    ),
    "authOperationNotAllowed": MessageLookupByLibrary.simpleMessage(
      "Operation not allowed. Please contact support.",
    ),
    "authPasswordLabel": MessageLookupByLibrary.simpleMessage("Password"),
    "authPasswordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "authPermissionDenied": MessageLookupByLibrary.simpleMessage(
      "You don\'t have permission to perform this action.",
    ),
    "authRegisterButton": MessageLookupByLibrary.simpleMessage(
      "Create account",
    ),
    "authRegisterSubtitle": MessageLookupByLibrary.simpleMessage(
      "Set up your household\'s medicine cabinet in a minute.",
    ),
    "authRegisterSuccess": MessageLookupByLibrary.simpleMessage(
      "Account created successfully",
    ),
    "authRegisterTitle": MessageLookupByLibrary.simpleMessage(
      "Create your account",
    ),
    "authResetPasswordSubtitle": MessageLookupByLibrary.simpleMessage(
      "Enter your email address and we\'ll send you a link to reset your password.",
    ),
    "authResetPasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Password reset email sent successfully.",
    ),
    "authResetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Reset Your Password",
    ),
    "authResourceNotFound": MessageLookupByLibrary.simpleMessage(
      "The requested resource was not found.",
    ),
    "authSendResetEmail": MessageLookupByLibrary.simpleMessage(
      "Send Reset Link",
    ),
    "authSendingResetEmail": MessageLookupByLibrary.simpleMessage("Sending..."),
    "authServerError": MessageLookupByLibrary.simpleMessage(
      "Our server is having trouble. Please try again later.",
    ),
    "authSessionExpired": MessageLookupByLibrary.simpleMessage(
      "Your session has expired. Please login again.",
    ),
    "authSignUpLink": MessageLookupByLibrary.simpleMessage("Sign up"),
    "authTermsNotice": MessageLookupByLibrary.simpleMessage(
      "By continuing, you agree to the Terms and Privacy Policy.",
    ),
    "authTooManyRequests": MessageLookupByLibrary.simpleMessage(
      "Too many attempts. Please try again later.",
    ),
    "authUserDisabled": MessageLookupByLibrary.simpleMessage(
      "This account has been disabled.",
    ),
    "authUserNotFound": MessageLookupByLibrary.simpleMessage(
      "No account was found with this email.",
    ),
    "authWeakPassword": MessageLookupByLibrary.simpleMessage(
      "Your password is too weak.",
    ),
    "authWrongPassword": MessageLookupByLibrary.simpleMessage(
      "Incorrect email or password.",
    ),
    "beforeYouBuyAlreadyTitle": MessageLookupByLibrary.simpleMessage(
      "Already in your cabinet",
    ),
    "beforeYouBuyExpires": MessageLookupByLibrary.simpleMessage("Expires"),
    "beforeYouBuyNoMatchTitle": MessageLookupByLibrary.simpleMessage(
      "No matching medicine found",
    ),
    "beforeYouBuyNotFoundTitle": MessageLookupByLibrary.simpleMessage(
      "Not in your cabinet",
    ),
    "beforeYouBuyNotice": MessageLookupByLibrary.simpleMessage(
      "You may already have this medicine at home.",
    ),
    "beforeYouBuyOwnedBy": MessageLookupByLibrary.simpleMessage("Owned by"),
    "beforeYouBuySearchHint": MessageLookupByLibrary.simpleMessage(
      "Scan or search a medicine...",
    ),
    "beforeYouBuyTitle": MessageLookupByLibrary.simpleMessage("Before You Buy"),
    "commonAddToCabinet": MessageLookupByLibrary.simpleMessage(
      "Add to Cabinet",
    ),
    "commonAll": MessageLookupByLibrary.simpleMessage("All"),
    "commonApply": MessageLookupByLibrary.simpleMessage("Apply"),
    "commonBottles": MessageLookupByLibrary.simpleMessage("bottles"),
    "commonCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "commonCapsules": MessageLookupByLibrary.simpleMessage("capsules"),
    "commonClose": MessageLookupByLibrary.simpleMessage("Close"),
    "commonContinue": MessageLookupByLibrary.simpleMessage("Continue"),
    "commonDateAdded": MessageLookupByLibrary.simpleMessage("Date added"),
    "commonDelete": MessageLookupByLibrary.simpleMessage("Delete"),
    "commonEditDetails": MessageLookupByLibrary.simpleMessage("Edit details"),
    "commonError": MessageLookupByLibrary.simpleMessage("Something went wrong"),
    "commonExpired": MessageLookupByLibrary.simpleMessage("Expired"),
    "commonExpiringShort": MessageLookupByLibrary.simpleMessage("Expiring"),
    "commonExpiringSoon": MessageLookupByLibrary.simpleMessage("Expiring soon"),
    "commonExpiryDate": MessageLookupByLibrary.simpleMessage("Expiry date"),
    "commonGetStarted": MessageLookupByLibrary.simpleMessage("Get started"),
    "commonHealthy": MessageLookupByLibrary.simpleMessage("Healthy"),
    "commonHousehold": MessageLookupByLibrary.simpleMessage("Household"),
    "commonLow": MessageLookupByLibrary.simpleMessage("Low"),
    "commonLowStock": MessageLookupByLibrary.simpleMessage("Ended stock"),
    "commonManage": MessageLookupByLibrary.simpleMessage("Manage"),
    "commonMarkAsUsed": MessageLookupByLibrary.simpleMessage("Mark as used"),
    "commonNoEmail": MessageLookupByLibrary.simpleMessage("No email"),
    "commonOr": MessageLookupByLibrary.simpleMessage("or"),
    "commonOwner": MessageLookupByLibrary.simpleMessage("Owner"),
    "commonQuantity": MessageLookupByLibrary.simpleMessage("Quantity"),
    "commonRetry": MessageLookupByLibrary.simpleMessage("Retry"),
    "commonReview": MessageLookupByLibrary.simpleMessage("Review"),
    "commonSeeAll": MessageLookupByLibrary.simpleMessage("See all"),
    "commonSkip": MessageLookupByLibrary.simpleMessage("Skip"),
    "commonSomethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Something went wrong",
    ),
    "commonStorageLocation": MessageLookupByLibrary.simpleMessage(
      "Storage location",
    ),
    "commonSuccess": MessageLookupByLibrary.simpleMessage("Success"),
    "commonTryAgain": MessageLookupByLibrary.simpleMessage("Try again"),
    "commonTryAgainLater": MessageLookupByLibrary.simpleMessage(
      "Please try again later",
    ),
    "commonUnableToLoadMedicineDetails": MessageLookupByLibrary.simpleMessage(
      "Unable to load medicine details.",
    ),
    "commonUnits": MessageLookupByLibrary.simpleMessage("units"),
    "commonUnnamed": MessageLookupByLibrary.simpleMessage("Unnamed"),
    "commonUpdateQuantity": MessageLookupByLibrary.simpleMessage(
      "Update quantity",
    ),
    "commonUser": MessageLookupByLibrary.simpleMessage("User"),
    "createHouseholdDescription": MessageLookupByLibrary.simpleMessage(
      "Give your household a name to help your family stay organized.",
    ),
    "createHouseholdTitle": MessageLookupByLibrary.simpleMessage(
      "Create a new household",
    ),
    "errorDatabase": MessageLookupByLibrary.simpleMessage(
      "A database error occurred.",
    ),
    "errorInternalServer": MessageLookupByLibrary.simpleMessage(
      "Our server is having trouble. Please try again in a few minutes.",
    ),
    "errorInvalidInput": MessageLookupByLibrary.simpleMessage(
      "Invalid information provided. Please check your inputs.",
    ),
    "errorNoInternet": MessageLookupByLibrary.simpleMessage(
      "No internet connection or server is unavailable.",
    ),
    "errorNotFound": MessageLookupByLibrary.simpleMessage(
      "The requested resource was not found.",
    ),
    "errorPermissionDenied": MessageLookupByLibrary.simpleMessage(
      "You don\'t have permission to perform this action.",
    ),
    "errorSessionExpired": MessageLookupByLibrary.simpleMessage(
      "Your session has expired. Please login again.",
    ),
    "errorTechnicalIssue": MessageLookupByLibrary.simpleMessage(
      "We encountered a technical issue while processing data.",
    ),
    "errorTimeout": MessageLookupByLibrary.simpleMessage(
      "Connection timed out. The server is not responding.",
    ),
    "failedToLoadMedicines": MessageLookupByLibrary.simpleMessage(
      "Failed to load medicines",
    ),
    "failedToLoadProfile": MessageLookupByLibrary.simpleMessage(
      "Failed to load user profile",
    ),
    "homeAddedDaysAgo": m0,
    "homeAddedToday": MessageLookupByLibrary.simpleMessage("Added today"),
    "homeAddedYesterday": MessageLookupByLibrary.simpleMessage(
      "Added yesterday",
    ),
    "homeAttentionNeeded": MessageLookupByLibrary.simpleMessage(
      "Attention needed",
    ),
    "homeBottlesRemaining": m1,
    "homeCapsulesRemaining": m2,
    "homeEmptyButton": MessageLookupByLibrary.simpleMessage(
      "Scan your first medicine",
    ),
    "homeEmptyDesc": MessageLookupByLibrary.simpleMessage(
      "Scan the first medicine you own and it\'ll show up here, organized and ready to track.",
    ),
    "homeEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "Your cabinet is empty",
    ),
    "homeExpiresInDays": m3,
    "homeExpiresInMonth": MessageLookupByLibrary.simpleMessage(
      "Expires in 1 month",
    ),
    "homeExpiresInMonths": m4,
    "homeExpiresTomorrow": MessageLookupByLibrary.simpleMessage(
      "Expires tomorrow",
    ),
    "homeGreetingEvening": m5,
    "homeNavLabel": MessageLookupByLibrary.simpleMessage("Home"),
    "homeRecentlyAdded": MessageLookupByLibrary.simpleMessage("Recently added"),
    "homeRemaining": m6,
    "homeScanCta": MessageLookupByLibrary.simpleMessage("Scan Medicine"),
    "homeScanCtaSubtitle": MessageLookupByLibrary.simpleMessage(
      "Add a new item in seconds",
    ),
    "homeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Here\'s your medicine cabinet",
    ),
    "homeTabletsRemaining": m7,
    "homeUnitsRemaining": m8,
    "householdAddMember": MessageLookupByLibrary.simpleMessage(
      "Add family member",
    ),
    "householdAdminTitle": MessageLookupByLibrary.simpleMessage(
      "As the household owner, you can:",
    ),
    "householdCreateButton": MessageLookupByLibrary.simpleMessage(
      "Create a new household",
    ),
    "householdCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Household created successfully",
    ),
    "householdCreating": MessageLookupByLibrary.simpleMessage("Creating..."),
    "householdIdHint": MessageLookupByLibrary.simpleMessage(
      "Enter household ID",
    ),
    "householdIdLabel": MessageLookupByLibrary.simpleMessage("Household ID"),
    "householdJoinButton": MessageLookupByLibrary.simpleMessage(
      "Join household",
    ),
    "householdJoinExistingButton": MessageLookupByLibrary.simpleMessage(
      "I have a household ID, join it",
    ),
    "householdJoinSuccess": MessageLookupByLibrary.simpleMessage(
      "Joined household successfully",
    ),
    "householdJoining": MessageLookupByLibrary.simpleMessage("Joining..."),
    "householdMedicineCount": m9,
    "householdMemberDetails": MessageLookupByLibrary.simpleMessage(
      "Member Details",
    ),
    "householdMemberRemovedDescription": MessageLookupByLibrary.simpleMessage(
      "Member removed from the household",
    ),
    "householdMemberRemovedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Member removed from the household",
    ),
    "householdMemberRemovedTitle": MessageLookupByLibrary.simpleMessage(
      "Removed",
    ),
    "householdNameHint": MessageLookupByLibrary.simpleMessage(
      "e.g. Home Cabinet",
    ),
    "householdNameLabel": MessageLookupByLibrary.simpleMessage(
      "Household name",
    ),
    "householdNoMembersFound": MessageLookupByLibrary.simpleMessage(
      "No household members found",
    ),
    "householdOr": MessageLookupByLibrary.simpleMessage("OR"),
    "householdPermissionAdd": MessageLookupByLibrary.simpleMessage(
      "Add or remove members",
    ),
    "householdPermissionManage": MessageLookupByLibrary.simpleMessage(
      "Manage the household",
    ),
    "householdPermissionView": MessageLookupByLibrary.simpleMessage(
      "View all members\' medicines",
    ),
    "householdRemoveButton": MessageLookupByLibrary.simpleMessage("Remove"),
    "householdRemoveMemberDesc": m10,
    "householdRemoveMemberTitle": MessageLookupByLibrary.simpleMessage(
      "Remove member?",
    ),
    "householdRemoveMemberTooltip": MessageLookupByLibrary.simpleMessage(
      "Remove member",
    ),
    "householdSetupDescription": MessageLookupByLibrary.simpleMessage(
      "Join an existing household using its ID, or create a new one.",
    ),
    "householdSetupTitle": MessageLookupByLibrary.simpleMessage(
      "Set up your household",
    ),
    "householdTitle": MessageLookupByLibrary.simpleMessage("Household"),
    "logoutFailedDescription": MessageLookupByLibrary.simpleMessage(
      "Something went wrong while logging out. Please try again.",
    ),
    "logoutFailedTitle": MessageLookupByLibrary.simpleMessage("Logout Failed"),
    "logoutSuccessDescription": MessageLookupByLibrary.simpleMessage(
      "You have been logged out successfully.",
    ),
    "logoutSuccessTitle": MessageLookupByLibrary.simpleMessage("Logged Out"),
    "medicineCabinet": MessageLookupByLibrary.simpleMessage("Medicine Cabinet"),
    "medicineCategoryAll": MessageLookupByLibrary.simpleMessage("All"),
    "medicineCategoryAllergy": MessageLookupByLibrary.simpleMessage("Allergy"),
    "medicineCategoryAntibiotics": MessageLookupByLibrary.simpleMessage(
      "Antibiotics",
    ),
    "medicineCategoryColdFlu": MessageLookupByLibrary.simpleMessage(
      "Cold & flu",
    ),
    "medicineCategoryDigestive": MessageLookupByLibrary.simpleMessage(
      "Digestive",
    ),
    "medicineCategoryEnded": MessageLookupByLibrary.simpleMessage("Ended"),
    "medicineCategoryExpired": MessageLookupByLibrary.simpleMessage("Expired"),
    "medicineCategoryPainRelief": MessageLookupByLibrary.simpleMessage(
      "Pain relief",
    ),
    "medicineCategoryRecentlyAdded": MessageLookupByLibrary.simpleMessage(
      "Recently Added",
    ),
    "medicineCategorySkinCare": MessageLookupByLibrary.simpleMessage(
      "Skin care",
    ),
    "medicineCategoryValid": MessageLookupByLibrary.simpleMessage("Valid"),
    "medicineCategoryVitamins": MessageLookupByLibrary.simpleMessage(
      "Vitamins",
    ),
    "medicineCount": m11,
    "medicineDetailsCategory": MessageLookupByLibrary.simpleMessage("Category"),
    "medicineDetailsDeleteDesc": MessageLookupByLibrary.simpleMessage(
      "This removes it from your cabinet inventory. This can\'t be undone.",
    ),
    "medicineDetailsName": MessageLookupByLibrary.simpleMessage("Name"),
    "medicineDetailsNotFound": MessageLookupByLibrary.simpleMessage(
      "Medicine not found",
    ),
    "medicineDetailsType": MessageLookupByLibrary.simpleMessage("Type"),
    "medicineExpires": m12,
    "medicineExpiry": m13,
    "medicineNoEnded": MessageLookupByLibrary.simpleMessage(
      "No ended medicines",
    ),
    "medicineNoExpired": MessageLookupByLibrary.simpleMessage(
      "No expired medicines",
    ),
    "medicineNoMedicines": MessageLookupByLibrary.simpleMessage(
      "No medicines found",
    ),
    "medicineNoRecentlyAdded": MessageLookupByLibrary.simpleMessage(
      "No recently added medicines",
    ),
    "medicineQuantity": m14,
    "medicineRemaining": m15,
    "medicineStatusEnded": MessageLookupByLibrary.simpleMessage("Ended"),
    "medicineStatusExpired": MessageLookupByLibrary.simpleMessage("Expired"),
    "medicineStatusValid": MessageLookupByLibrary.simpleMessage("Valid"),
    "medicineTypeCapsules": MessageLookupByLibrary.simpleMessage("Capsules"),
    "medicineTypeCream": MessageLookupByLibrary.simpleMessage("Cream"),
    "medicineTypeDrops": MessageLookupByLibrary.simpleMessage("Drops"),
    "medicineTypeInhaler": MessageLookupByLibrary.simpleMessage("Inhaler"),
    "medicineTypeOintment": MessageLookupByLibrary.simpleMessage("Ointment"),
    "medicineTypePills": MessageLookupByLibrary.simpleMessage("Pills"),
    "medicineTypeSyrup": MessageLookupByLibrary.simpleMessage("Syrup"),
    "medicines": MessageLookupByLibrary.simpleMessage("Medicines"),
    "medicinesItemsCount": m16,
    "medicinesNavLabel": MessageLookupByLibrary.simpleMessage("Medicines"),
    "medicinesNoMedicines": MessageLookupByLibrary.simpleMessage(
      "No medicines found",
    ),
    "medicinesSearchHint": MessageLookupByLibrary.simpleMessage(
      "Search medicines...",
    ),
    "medicinesSortBy": MessageLookupByLibrary.simpleMessage("Sort by"),
    "medicinesSortLabelCurrent": m17,
    "medicinesSortOptionExpiry": MessageLookupByLibrary.simpleMessage(
      "Expiry date",
    ),
    "medicinesSortOptionName": MessageLookupByLibrary.simpleMessage(
      "Name (A–Z)",
    ),
    "medicinesSortOptionQuantity": MessageLookupByLibrary.simpleMessage(
      "Quantity",
    ),
    "medicinesSortOptionRecentlyAdded": MessageLookupByLibrary.simpleMessage(
      "Recently added",
    ),
    "medicinesTitle": MessageLookupByLibrary.simpleMessage("Medicines"),
    "memberEmail": MessageLookupByLibrary.simpleMessage("Email"),
    "memberInformation": MessageLookupByLibrary.simpleMessage(
      "Member Information",
    ),
    "memberMedicines": MessageLookupByLibrary.simpleMessage("Member Medicines"),
    "name": MessageLookupByLibrary.simpleMessage("Name"),
    "onboardingBuyDesc": MessageLookupByLibrary.simpleMessage(
      "Scan a medicine at the store and instantly see if your household already has it.",
    ),
    "onboardingBuyTitle": MessageLookupByLibrary.simpleMessage(
      "Check before you buy",
    ),
    "onboardingContinue": MessageLookupByLibrary.simpleMessage("Continue"),
    "onboardingDesc1": MessageLookupByLibrary.simpleMessage(
      "Keep every medicine your household owns organized in one clear, shared place.",
    ),
    "onboardingDesc2": MessageLookupByLibrary.simpleMessage(
      "Get a gentle nudge before a medicine expires, or before you run low on it.",
    ),
    "onboardingDesc3": MessageLookupByLibrary.simpleMessage(
      "Scan a medicine at the store and instantly see if your household already has it.",
    ),
    "onboardingExpiryDesc": MessageLookupByLibrary.simpleMessage(
      "Get a gentle nudge before a medicine expires, or before you run low on it.",
    ),
    "onboardingExpiryTitle": MessageLookupByLibrary.simpleMessage(
      "Never miss an expiry",
    ),
    "onboardingGetStarted": MessageLookupByLibrary.simpleMessage("Get started"),
    "onboardingKnowDesc": MessageLookupByLibrary.simpleMessage(
      "Keep every medicine your household owns organized in one clear, shared place.",
    ),
    "onboardingKnowTitle": MessageLookupByLibrary.simpleMessage(
      "Know what you have",
    ),
    "onboardingSkip": MessageLookupByLibrary.simpleMessage("Skip"),
    "onboardingTitle1": MessageLookupByLibrary.simpleMessage(
      "Know what you have",
    ),
    "onboardingTitle2": MessageLookupByLibrary.simpleMessage(
      "Never miss an expiry",
    ),
    "onboardingTitle3": MessageLookupByLibrary.simpleMessage(
      "Check before you buy",
    ),
    "profileAbout": MessageLookupByLibrary.simpleMessage("About"),
    "profileAboutDescription": MessageLookupByLibrary.simpleMessage(
      "Medicine Cabinet helps you manage your medicines, expiry dates, and stock levels easily.",
    ),
    "profileAccountSection": MessageLookupByLibrary.simpleMessage("Account"),
    "profileAppSection": MessageLookupByLibrary.simpleMessage("App"),
    "profileAppVersion": MessageLookupByLibrary.simpleMessage("App version"),
    "profileArabic": MessageLookupByLibrary.simpleMessage("Arabic"),
    "profileChangePhoto": MessageLookupByLibrary.simpleMessage("Change Photo"),
    "profileDarkMode": MessageLookupByLibrary.simpleMessage("Dark mode"),
    "profileEmailAddress": MessageLookupByLibrary.simpleMessage(
      "Email Address",
    ),
    "profileEnglish": MessageLookupByLibrary.simpleMessage("English"),
    "profileExpiryReminderSettings": MessageLookupByLibrary.simpleMessage(
      "Expiry reminder settings",
    ),
    "profileFullName": MessageLookupByLibrary.simpleMessage("Full Name"),
    "profileImageUploadFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to upload profile picture.",
    ),
    "profileInformationSection": MessageLookupByLibrary.simpleMessage(
      "Information",
    ),
    "profileLanguage": MessageLookupByLibrary.simpleMessage("Language"),
    "profileLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Unable to load your profile. Please try again.",
    ),
    "profileLogout": MessageLookupByLibrary.simpleMessage("Logout"),
    "profileLogoutConfirmation": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to logout?",
    ),
    "profileNameRequired": MessageLookupByLibrary.simpleMessage(
      "Name is required",
    ),
    "profileNavLabel": MessageLookupByLibrary.simpleMessage("Profile"),
    "profileNetworkError": MessageLookupByLibrary.simpleMessage(
      "Please check your internet connection and try again.",
    ),
    "profileNotFound": MessageLookupByLibrary.simpleMessage(
      "Profile not found.",
    ),
    "profileNotificationSettings": MessageLookupByLibrary.simpleMessage(
      "Notification settings",
    ),
    "profileOperationFailed": MessageLookupByLibrary.simpleMessage(
      "The operation could not be completed. Please try again.",
    ),
    "profilePermissionDenied": MessageLookupByLibrary.simpleMessage(
      "You don\'t have permission to perform this operation.",
    ),
    "profilePersonalInformation": MessageLookupByLibrary.simpleMessage(
      "Personal information",
    ),
    "profilePersonalInformationTitle": MessageLookupByLibrary.simpleMessage(
      "Personal Information",
    ),
    "profilePrivacy": MessageLookupByLibrary.simpleMessage("Privacy"),
    "profileSaveChanges": MessageLookupByLibrary.simpleMessage("Save Changes"),
    "profileSavingChanges": MessageLookupByLibrary.simpleMessage(
      "Saving changes...",
    ),
    "profileServerError": MessageLookupByLibrary.simpleMessage(
      "Something went wrong. Please try again later.",
    ),
    "profileUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "Unable to update your profile. Please try again.",
    ),
    "profileUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "Profile updated successfully",
    ),
    "profileUserNotAuthenticated": MessageLookupByLibrary.simpleMessage(
      "You are not authenticated. Please log in again.",
    ),
    "scanAddMedicineButton": MessageLookupByLibrary.simpleMessage(
      "Add Medicine",
    ),
    "scanAddedTitle": MessageLookupByLibrary.simpleMessage(
      "Added to your cabinet",
    ),
    "scanAnalyzingSubtitle": MessageLookupByLibrary.simpleMessage(
      "Please wait while we read and process\nthe package details...",
    ),
    "scanAnalyzingTitle": MessageLookupByLibrary.simpleMessage(
      "Analyzing Medicine",
    ),
    "scanBackToHome": MessageLookupByLibrary.simpleMessage("Back to Home"),
    "scanCapture": MessageLookupByLibrary.simpleMessage("Capture"),
    "scanCategoryHint": MessageLookupByLibrary.simpleMessage(
      "e.g. Pain Relief, Antibiotic, Paracetamol",
    ),
    "scanCategoryLabel": MessageLookupByLibrary.simpleMessage(
      "Category / Active Ingredient",
    ),
    "scanCategoryValidation": MessageLookupByLibrary.simpleMessage(
      "Please enter category or active ingredient",
    ),
    "scanConfirmMedicineTitle": MessageLookupByLibrary.simpleMessage(
      "Confirm Medicine",
    ),
    "scanEnterManually": MessageLookupByLibrary.simpleMessage(
      "Enter details manually",
    ),
    "scanExpiryDateHint": MessageLookupByLibrary.simpleMessage("YYYY-MM-DD"),
    "scanExpiryDateValidation": MessageLookupByLibrary.simpleMessage(
      "Please select the expiry date",
    ),
    "scanFailedToAddMedicine": MessageLookupByLibrary.simpleMessage(
      "Failed to add medicine",
    ),
    "scanFailedToLoadMembers": MessageLookupByLibrary.simpleMessage(
      "Failed to load members",
    ),
    "scanFieldRequired": MessageLookupByLibrary.simpleMessage("Required"),
    "scanFormTypeHint": MessageLookupByLibrary.simpleMessage(
      "e.g. Tablets, Syrup",
    ),
    "scanFormTypeLabel": MessageLookupByLibrary.simpleMessage("Form / Type"),
    "scanHint": MessageLookupByLibrary.simpleMessage(
      "Align the package label within the frame",
    ),
    "scanHintAlignBox": MessageLookupByLibrary.simpleMessage(
      "Align medicine box or strip in frame",
    ),
    "scanHowManyDoYouHave": MessageLookupByLibrary.simpleMessage(
      "How many do you have?",
    ),
    "scanMedicineAddedSuccess": MessageLookupByLibrary.simpleMessage(
      "Medicine added successfully!",
    ),
    "scanMedicineDetailsTitle": MessageLookupByLibrary.simpleMessage(
      "Medicine Details",
    ),
    "scanMedicineFoundTitle": MessageLookupByLibrary.simpleMessage(
      "Medicine found",
    ),
    "scanMedicineNameHint": MessageLookupByLibrary.simpleMessage(
      "e.g. Panadol Extra, Amoxicillin",
    ),
    "scanMedicineNameLabel": MessageLookupByLibrary.simpleMessage(
      "Medicine Name",
    ),
    "scanMedicineNameValidation": MessageLookupByLibrary.simpleMessage(
      "Please enter the medicine name",
    ),
    "scanMedicineTitle": MessageLookupByLibrary.simpleMessage("Scan Medicine"),
    "scanMissingInfoDesc": MessageLookupByLibrary.simpleMessage(
      "Please review and fill in the required details.",
    ),
    "scanMissingInfoTitle": MessageLookupByLibrary.simpleMessage(
      "Missing Information",
    ),
    "scanNoMembersFound": MessageLookupByLibrary.simpleMessage(
      "No household members found",
    ),
    "scanNoPhotoPreview": MessageLookupByLibrary.simpleMessage(
      "No medicine photo preview",
    ),
    "scanNotesHint": MessageLookupByLibrary.simpleMessage(
      "e.g. Take 1 tablet after meals twice daily",
    ),
    "scanNotesLabel": MessageLookupByLibrary.simpleMessage(
      "Notes & Dosage Instructions",
    ),
    "scanPackagePhotoTitle": MessageLookupByLibrary.simpleMessage(
      "Package Photo",
    ),
    "scanRetakePhoto": MessageLookupByLibrary.simpleMessage("Retake"),
    "scanReviewConfirmNotice": MessageLookupByLibrary.simpleMessage(
      "Please review and confirm details before saving to your cabinet.",
    ),
    "scanScanAnother": MessageLookupByLibrary.simpleMessage("Scan another"),
    "scanSelectProfile": MessageLookupByLibrary.simpleMessage("Select profile"),
    "scanSomeoneElse": MessageLookupByLibrary.simpleMessage("Someone else"),
    "scanStorageLocationHint": MessageLookupByLibrary.simpleMessage(
      "e.g. Bedroom Drawer, Fridge, Medicine Box",
    ),
    "scanStorageLocationValidation": MessageLookupByLibrary.simpleMessage(
      "Please enter storage location",
    ),
    "scanUnitTablets": MessageLookupByLibrary.simpleMessage("tablets"),
    "scanUnitsDefault": MessageLookupByLibrary.simpleMessage("Units"),
    "scanWhoIsThisFor": MessageLookupByLibrary.simpleMessage(
      "Who is this for?",
    ),
    "searchNoResults": MessageLookupByLibrary.simpleMessage(
      "No medicines found",
    ),
    "searchStartTyping": MessageLookupByLibrary.simpleMessage(
      "Start typing to search for medicines",
    ),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Something went wrong, please try again later.",
    ),
    "somethingWrong": MessageLookupByLibrary.simpleMessage(
      "Something went wrong",
    ),
    "splashLoadingText": MessageLookupByLibrary.simpleMessage(
      "Setting up your cabinet...",
    ),
    "splashTagline": MessageLookupByLibrary.simpleMessage(
      "Your household medicines, organized in one place.",
    ),
    "splashWordmark": MessageLookupByLibrary.simpleMessage("Medicine Cabinet"),
    "validationCodeLength": MessageLookupByLibrary.simpleMessage(
      "Code should be at least 6 digits",
    ),
    "validationCodeRequired": MessageLookupByLibrary.simpleMessage(
      "Code cannot be empty",
    ),
    "validationEmailRequired": MessageLookupByLibrary.simpleMessage(
      "Email cannot be empty",
    ),
    "validationInvalidEmail": MessageLookupByLibrary.simpleMessage(
      "Enter a valid email address",
    ),
    "validationInvalidPassword": MessageLookupByLibrary.simpleMessage(
      "Enter a valid password",
    ),
    "validationInvalidPhone": MessageLookupByLibrary.simpleMessage(
      "Enter a valid phone number",
    ),
    "validationNameRequired": MessageLookupByLibrary.simpleMessage(
      "Name cannot be empty",
    ),
    "validationPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Password cannot be empty",
    ),
    "validationPasswordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "validationPhoneRequired": MessageLookupByLibrary.simpleMessage(
      "Phone number cannot be empty",
    ),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome back"),
  };
}
