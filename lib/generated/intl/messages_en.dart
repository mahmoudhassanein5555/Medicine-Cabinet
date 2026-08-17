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

  static String m0(name) => "Good evening, ${name}";

  static String m1(count) => "${count} medicines";

  static String m2(name) =>
      "This will remove ${name} from your household. This can\'t be undone.";

  static String m3(sortOption) => "Sort: ${sortOption}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "alertsFilterExpiry": MessageLookupByLibrary.simpleMessage("Expiry"),
    "alertsTitle": MessageLookupByLibrary.simpleMessage("Alerts"),
    "alertsToday": MessageLookupByLibrary.simpleMessage("Today"),
    "alertsYesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
    "authConfirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Confirm password",
    ),
    "authContinueWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Continue with Google",
    ),
    "authEmailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "authForgotPassword": MessageLookupByLibrary.simpleMessage(
      "Forgot password?",
    ),
    "authFullNameLabel": MessageLookupByLibrary.simpleMessage("Full name"),
    "authHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "authLoginButton": MessageLookupByLibrary.simpleMessage("Log in"),
    "authLoginLink": MessageLookupByLibrary.simpleMessage("Log in"),
    "authLoginSubtitle": MessageLookupByLibrary.simpleMessage(
      "Log in to see your household\'s medicine cabinet.",
    ),
    "authLoginTitle": MessageLookupByLibrary.simpleMessage("Welcome back"),
    "authNoAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account?",
    ),
    "authPasswordLabel": MessageLookupByLibrary.simpleMessage("Password"),
    "authRegisterButton": MessageLookupByLibrary.simpleMessage(
      "Create account",
    ),
    "authRegisterSubtitle": MessageLookupByLibrary.simpleMessage(
      "Set up your household\'s medicine cabinet in a minute.",
    ),
    "authRegisterTitle": MessageLookupByLibrary.simpleMessage(
      "Create your account",
    ),
    "authSignUpLink": MessageLookupByLibrary.simpleMessage("Sign up"),
    "authTermsNotice": MessageLookupByLibrary.simpleMessage(
      "By continuing, you agree to the Terms and Privacy Policy.",
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
    "commonCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "commonContinue": MessageLookupByLibrary.simpleMessage("Continue"),
    "commonDateAdded": MessageLookupByLibrary.simpleMessage("Date added"),
    "commonDelete": MessageLookupByLibrary.simpleMessage("Delete"),
    "commonEditDetails": MessageLookupByLibrary.simpleMessage("Edit details"),
    "commonExpired": MessageLookupByLibrary.simpleMessage("Expired"),
    "commonExpiringShort": MessageLookupByLibrary.simpleMessage("Expiring"),
    "commonExpiringSoon": MessageLookupByLibrary.simpleMessage("Expiring soon"),
    "commonExpiryDate": MessageLookupByLibrary.simpleMessage("Expiry date"),
    "commonGetStarted": MessageLookupByLibrary.simpleMessage("Get started"),
    "commonHealthy": MessageLookupByLibrary.simpleMessage("Healthy"),
    "commonHousehold": MessageLookupByLibrary.simpleMessage("Household"),
    "commonLow": MessageLookupByLibrary.simpleMessage("Low"),
    "commonLowStock": MessageLookupByLibrary.simpleMessage("Low stock"),
    "commonManage": MessageLookupByLibrary.simpleMessage("Manage"),
    "commonMarkAsUsed": MessageLookupByLibrary.simpleMessage("Mark as used"),
    "commonOr": MessageLookupByLibrary.simpleMessage("or"),
    "commonOwner": MessageLookupByLibrary.simpleMessage("Owner"),
    "commonQuantity": MessageLookupByLibrary.simpleMessage("Quantity"),
    "commonReview": MessageLookupByLibrary.simpleMessage("Review"),
    "commonSeeAll": MessageLookupByLibrary.simpleMessage("See all"),
    "commonSkip": MessageLookupByLibrary.simpleMessage("Skip"),
    "commonStorageLocation": MessageLookupByLibrary.simpleMessage(
      "Storage location",
    ),
    "commonUpdateQuantity": MessageLookupByLibrary.simpleMessage(
      "Update quantity",
    ),
    "createHouseholdDescription": MessageLookupByLibrary.simpleMessage(
      "Give your household a name to help your family stay organized.",
    ),
    "createHouseholdTitle": MessageLookupByLibrary.simpleMessage(
      "Create a new household",
    ),
    "homeAttentionNeeded": MessageLookupByLibrary.simpleMessage(
      "Attention needed",
    ),
    "homeEmptyButton": MessageLookupByLibrary.simpleMessage(
      "Scan your first medicine",
    ),
    "homeEmptyDesc": MessageLookupByLibrary.simpleMessage(
      "Scan the first medicine you own and it\'ll show up here, organized and ready to track.",
    ),
    "homeEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "Your cabinet is empty",
    ),
    "homeGreetingEvening": m0,
    "homeNavLabel": MessageLookupByLibrary.simpleMessage("Home"),
    "homeRecentlyAdded": MessageLookupByLibrary.simpleMessage("Recently added"),
    "homeScanCta": MessageLookupByLibrary.simpleMessage("Scan Medicine"),
    "homeScanCtaSubtitle": MessageLookupByLibrary.simpleMessage(
      "Add a new item in seconds",
    ),
    "homeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Here\'s your medicine cabinet",
    ),
    "householdAddMember": MessageLookupByLibrary.simpleMessage(
      "Add family member",
    ),
    "householdAdminTitle": MessageLookupByLibrary.simpleMessage(
      "As the household owner, you can:",
    ),
    "householdCreateButton": MessageLookupByLibrary.simpleMessage(
      "Create a new household",
    ),
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
    "householdMedicineCount": m1,
    "householdMemberDetails": MessageLookupByLibrary.simpleMessage(
      "Member Details",
    ),
    "householdMemberRemovedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Member removed from the household",
    ),
    "householdNameHint": MessageLookupByLibrary.simpleMessage(
      "e.g. Home Cabinet",
    ),
    "householdNameLabel": MessageLookupByLibrary.simpleMessage(
      "Household name",
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
    "householdRemoveMemberDesc": m2,
    "householdRemoveMemberTitle": MessageLookupByLibrary.simpleMessage(
      "Remove member?",
    ),
    "householdSetupDescription": MessageLookupByLibrary.simpleMessage(
      "Join an existing household using its ID, or create a new one.",
    ),
    "householdSetupTitle": MessageLookupByLibrary.simpleMessage(
      "Set up your household",
    ),
    "householdTitle": MessageLookupByLibrary.simpleMessage("Household"),
    "medicineDetailsDeleteDesc": MessageLookupByLibrary.simpleMessage(
      "This removes it from your cabinet inventory. This can\'t be undone.",
    ),
    "medicines": MessageLookupByLibrary.simpleMessage("Medicines"),
    "medicinesSearchHint": MessageLookupByLibrary.simpleMessage(
      "Search medicines...",
    ),
    "medicinesSortBy": MessageLookupByLibrary.simpleMessage("Sort by"),
    "medicinesSortLabelCurrent": m3,
    "medicinesSortOptionName": MessageLookupByLibrary.simpleMessage(
      "Name (A–Z)",
    ),
    "medicinesTitle": MessageLookupByLibrary.simpleMessage("Medicines"),
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
    "onboardingExpiryDesc": MessageLookupByLibrary.simpleMessage(
      "Get a gentle nudge before a medicine expires, or before you run low on it.",
    ),
    "onboardingExpiryTitle": MessageLookupByLibrary.simpleMessage(
      "Never miss an expiry",
    ),
    "onboardingKnowDesc": MessageLookupByLibrary.simpleMessage(
      "Keep every medicine your household owns organized in one clear, shared place.",
    ),
    "onboardingKnowTitle": MessageLookupByLibrary.simpleMessage(
      "Know what you have",
    ),
    "profileAbout": MessageLookupByLibrary.simpleMessage("About"),
    "profileAccountSection": MessageLookupByLibrary.simpleMessage("Account"),
    "profileAppPreferences": MessageLookupByLibrary.simpleMessage(
      "App preferences",
    ),
    "profileAppSection": MessageLookupByLibrary.simpleMessage("App"),
    "profileDarkMode": MessageLookupByLibrary.simpleMessage("Dark mode"),
    "profileExpiryReminderSettings": MessageLookupByLibrary.simpleMessage(
      "Expiry reminder settings",
    ),
    "profileLowStockThreshold": MessageLookupByLibrary.simpleMessage(
      "Low-stock threshold",
    ),
    "profileNavLabel": MessageLookupByLibrary.simpleMessage("Profile"),
    "profileNotificationSettings": MessageLookupByLibrary.simpleMessage(
      "Notification settings",
    ),
    "profilePersonalInformation": MessageLookupByLibrary.simpleMessage(
      "Personal information",
    ),
    "profilePrivacy": MessageLookupByLibrary.simpleMessage("Privacy"),
    "profileRemindersSection": MessageLookupByLibrary.simpleMessage(
      "Reminders",
    ),
    "scanAddedTitle": MessageLookupByLibrary.simpleMessage(
      "Added to your cabinet",
    ),
    "scanBackToHome": MessageLookupByLibrary.simpleMessage("Back to Home"),
    "scanCapture": MessageLookupByLibrary.simpleMessage("Capture"),
    "scanEnterManually": MessageLookupByLibrary.simpleMessage(
      "Enter details manually",
    ),
    "scanHint": MessageLookupByLibrary.simpleMessage(
      "Align the package label within the frame",
    ),
    "scanHowManyDoYouHave": MessageLookupByLibrary.simpleMessage(
      "How many do you have?",
    ),
    "scanMedicineFoundTitle": MessageLookupByLibrary.simpleMessage(
      "Medicine found",
    ),
    "scanScanAnother": MessageLookupByLibrary.simpleMessage("Scan another"),
    "scanSomeoneElse": MessageLookupByLibrary.simpleMessage("Someone else"),
    "scanUnitTablets": MessageLookupByLibrary.simpleMessage("tablets"),
    "scanWhoIsThisFor": MessageLookupByLibrary.simpleMessage(
      "Who is this for?",
    ),
  };
}
