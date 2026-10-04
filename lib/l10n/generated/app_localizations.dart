import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
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
/// import 'generated/app_localizations.dart';
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
    Locale('bn'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Bari Vara'**
  String get appTitle;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Rent management'**
  String get appSubtitle;

  /// No description provided for @offlineRecords.
  ///
  /// In en, this message translates to:
  /// **'Your offline rent records stay on this device.'**
  String get offlineRecords;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @tenants.
  ///
  /// In en, this message translates to:
  /// **'Tenants'**
  String get tenants;

  /// No description provided for @bills.
  ///
  /// In en, this message translates to:
  /// **'Bills'**
  String get bills;

  /// No description provided for @payments.
  ///
  /// In en, this message translates to:
  /// **'Payments & Dues'**
  String get payments;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @receiptDefaults.
  ///
  /// In en, this message translates to:
  /// **'Receipt defaults'**
  String get receiptDefaults;

  /// No description provided for @reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminders;

  /// No description provided for @dataAndBackup.
  ///
  /// In en, this message translates to:
  /// **'Data & backup'**
  String get dataAndBackup;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your language / ভাষা নির্বাচন করুন'**
  String get chooseLanguage;

  /// No description provided for @bangla.
  ///
  /// In en, this message translates to:
  /// **'বাংলা'**
  String get bangla;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @useBengaliDigits.
  ///
  /// In en, this message translates to:
  /// **'Use Bengali digits'**
  String get useBengaliDigits;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @digitStyle.
  ///
  /// In en, this message translates to:
  /// **'Digit style'**
  String get digitStyle;

  /// No description provided for @bengaliDigits.
  ///
  /// In en, this message translates to:
  /// **'Bengali digits'**
  String get bengaliDigits;

  /// No description provided for @englishDigits.
  ///
  /// In en, this message translates to:
  /// **'English digits'**
  String get englishDigits;

  /// No description provided for @languagePreview.
  ///
  /// In en, this message translates to:
  /// **'October 2026 — Total ৳19,510'**
  String get languagePreview;

  /// No description provided for @defaultReceiptLanguage.
  ///
  /// In en, this message translates to:
  /// **'Default receipt language'**
  String get defaultReceiptLanguage;

  /// No description provided for @defaultPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Default payment method'**
  String get defaultPaymentMethod;

  /// No description provided for @defaultProperty.
  ///
  /// In en, this message translates to:
  /// **'Default property'**
  String get defaultProperty;

  /// No description provided for @rentDueReminder.
  ///
  /// In en, this message translates to:
  /// **'Rent due reminder'**
  String get rentDueReminder;

  /// No description provided for @backupReminder.
  ///
  /// In en, this message translates to:
  /// **'Backup reminder'**
  String get backupReminder;

  /// No description provided for @localReminderNote.
  ///
  /// In en, this message translates to:
  /// **'Reminders are scheduled on this phone and do not require a server.'**
  String get localReminderNote;

  /// No description provided for @backupRestorePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Backup and restore tools will be available here.'**
  String get backupRestorePlaceholder;

  /// No description provided for @securityPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'App lock and privacy controls will be available here.'**
  String get securityPlaceholder;

  /// No description provided for @settingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Settings updated'**
  String get settingsSaved;

  /// No description provided for @couldNotSave.
  ///
  /// In en, this message translates to:
  /// **'Could not save the setting. Please try again.'**
  String get couldNotSave;

  /// No description provided for @noProperties.
  ///
  /// In en, this message translates to:
  /// **'No default property selected'**
  String get noProperties;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @bkash.
  ///
  /// In en, this message translates to:
  /// **'bKash'**
  String get bkash;

  /// No description provided for @nagad.
  ///
  /// In en, this message translates to:
  /// **'Nagad'**
  String get nagad;

  /// No description provided for @bankTransfer.
  ///
  /// In en, this message translates to:
  /// **'Bank transfer'**
  String get bankTransfer;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @propertiesAndUnits.
  ///
  /// In en, this message translates to:
  /// **'Properties & Units'**
  String get propertiesAndUnits;

  /// No description provided for @properties.
  ///
  /// In en, this message translates to:
  /// **'Properties'**
  String get properties;

  /// No description provided for @units.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get units;

  /// No description provided for @addProperty.
  ///
  /// In en, this message translates to:
  /// **'Add property'**
  String get addProperty;

  /// No description provided for @editProperty.
  ///
  /// In en, this message translates to:
  /// **'Edit property'**
  String get editProperty;

  /// No description provided for @archiveProperty.
  ///
  /// In en, this message translates to:
  /// **'Archive property'**
  String get archiveProperty;

  /// No description provided for @addUnit.
  ///
  /// In en, this message translates to:
  /// **'Add unit'**
  String get addUnit;

  /// No description provided for @editUnit.
  ///
  /// In en, this message translates to:
  /// **'Edit unit'**
  String get editUnit;

  /// No description provided for @archiveUnit.
  ///
  /// In en, this message translates to:
  /// **'Archive unit'**
  String get archiveUnit;

  /// No description provided for @propertyName.
  ///
  /// In en, this message translates to:
  /// **'Property name'**
  String get propertyName;

  /// No description provided for @propertyType.
  ///
  /// In en, this message translates to:
  /// **'Property type'**
  String get propertyType;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get area;

  /// No description provided for @cityDistrict.
  ///
  /// In en, this message translates to:
  /// **'City / district'**
  String get cityDistrict;

  /// No description provided for @notesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get notesOptional;

  /// No description provided for @unitName.
  ///
  /// In en, this message translates to:
  /// **'Unit name / number'**
  String get unitName;

  /// No description provided for @floor.
  ///
  /// In en, this message translates to:
  /// **'Floor'**
  String get floor;

  /// No description provided for @unitType.
  ///
  /// In en, this message translates to:
  /// **'Unit type'**
  String get unitType;

  /// No description provided for @bedroomsOptional.
  ///
  /// In en, this message translates to:
  /// **'Bedrooms (optional)'**
  String get bedroomsOptional;

  /// No description provided for @monthlyRent.
  ///
  /// In en, this message translates to:
  /// **'Default monthly rent'**
  String get monthlyRent;

  /// No description provided for @serviceCharge.
  ///
  /// In en, this message translates to:
  /// **'Default service charge'**
  String get serviceCharge;

  /// No description provided for @gasCharge.
  ///
  /// In en, this message translates to:
  /// **'Default gas charge'**
  String get gasCharge;

  /// No description provided for @waterCharge.
  ///
  /// In en, this message translates to:
  /// **'Default water charge'**
  String get waterCharge;

  /// No description provided for @saveProperty.
  ///
  /// In en, this message translates to:
  /// **'Save property'**
  String get saveProperty;

  /// No description provided for @saveUnit.
  ///
  /// In en, this message translates to:
  /// **'Save unit'**
  String get saveUnit;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @occupied.
  ///
  /// In en, this message translates to:
  /// **'Occupied'**
  String get occupied;

  /// No description provided for @vacant.
  ///
  /// In en, this message translates to:
  /// **'Vacant'**
  String get vacant;

  /// No description provided for @archived.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get archived;

  /// No description provided for @reserved.
  ///
  /// In en, this message translates to:
  /// **'Reserved'**
  String get reserved;

  /// No description provided for @currentDue.
  ///
  /// In en, this message translates to:
  /// **'Current due'**
  String get currentDue;

  /// No description provided for @unitCount.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get unitCount;

  /// No description provided for @monthlySummary.
  ///
  /// In en, this message translates to:
  /// **'Monthly summary'**
  String get monthlySummary;

  /// No description provided for @repairs.
  ///
  /// In en, this message translates to:
  /// **'Repairs'**
  String get repairs;

  /// No description provided for @propertySettings.
  ///
  /// In en, this message translates to:
  /// **'Property settings'**
  String get propertySettings;

  /// No description provided for @tenantsAndOccupancy.
  ///
  /// In en, this message translates to:
  /// **'Tenants / occupancy'**
  String get tenantsAndOccupancy;

  /// No description provided for @utilityDefaults.
  ///
  /// In en, this message translates to:
  /// **'Utility & service defaults'**
  String get utilityDefaults;

  /// No description provided for @discardChangesTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard changes?'**
  String get discardChangesTitle;

  /// No description provided for @discardChangesMessage.
  ///
  /// In en, this message translates to:
  /// **'Your unsaved changes will be lost.'**
  String get discardChangesMessage;

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @keepEditing.
  ///
  /// In en, this message translates to:
  /// **'Keep editing'**
  String get keepEditing;

  /// No description provided for @archivePropertyMessage.
  ///
  /// In en, this message translates to:
  /// **'Archived properties are removed from normal lists. Archive all active units first.'**
  String get archivePropertyMessage;

  /// No description provided for @archiveUnitMessage.
  ///
  /// In en, this message translates to:
  /// **'Archived units are removed from normal lists. An occupied unit cannot be archived.'**
  String get archiveUnitMessage;

  /// No description provided for @confirmArchive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get confirmArchive;

  /// No description provided for @noPropertiesYet.
  ///
  /// In en, this message translates to:
  /// **'No property has been added yet.'**
  String get noPropertiesYet;

  /// No description provided for @noUnitsYet.
  ///
  /// In en, this message translates to:
  /// **'No units match this filter.'**
  String get noUnitsYet;

  /// No description provided for @propertySaved.
  ///
  /// In en, this message translates to:
  /// **'Property saved'**
  String get propertySaved;

  /// No description provided for @unitSaved.
  ///
  /// In en, this message translates to:
  /// **'Unit saved'**
  String get unitSaved;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredField;

  /// No description provided for @invalidAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid whole-taka amount'**
  String get invalidAmount;

  /// No description provided for @residential.
  ///
  /// In en, this message translates to:
  /// **'Residential'**
  String get residential;

  /// No description provided for @commercial.
  ///
  /// In en, this message translates to:
  /// **'Commercial'**
  String get commercial;

  /// No description provided for @mixedUse.
  ///
  /// In en, this message translates to:
  /// **'Mixed use'**
  String get mixedUse;

  /// No description provided for @otherType.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get otherType;

  /// No description provided for @apartment.
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get apartment;

  /// No description provided for @room.
  ///
  /// In en, this message translates to:
  /// **'Room'**
  String get room;

  /// No description provided for @shop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shop;

  /// No description provided for @office.
  ///
  /// In en, this message translates to:
  /// **'Office'**
  String get office;

  /// No description provided for @addTenant.
  ///
  /// In en, this message translates to:
  /// **'Add tenant'**
  String get addTenant;

  /// No description provided for @editTenant.
  ///
  /// In en, this message translates to:
  /// **'Edit tenant'**
  String get editTenant;

  /// No description provided for @archiveTenant.
  ///
  /// In en, this message translates to:
  /// **'Archive tenant'**
  String get archiveTenant;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get mobileNumber;

  /// No description provided for @alternateMobile.
  ///
  /// In en, this message translates to:
  /// **'Alternate mobile (optional)'**
  String get alternateMobile;

  /// No description provided for @nationalId.
  ///
  /// In en, this message translates to:
  /// **'National ID / reference (optional)'**
  String get nationalId;

  /// No description provided for @permanentAddress.
  ///
  /// In en, this message translates to:
  /// **'Permanent address (optional)'**
  String get permanentAddress;

  /// No description provided for @emergencyContact.
  ///
  /// In en, this message translates to:
  /// **'Emergency contact (optional)'**
  String get emergencyContact;

  /// No description provided for @emergencyPhone.
  ///
  /// In en, this message translates to:
  /// **'Emergency phone (optional)'**
  String get emergencyPhone;

  /// No description provided for @tenantNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get tenantNotes;

  /// No description provided for @selectProperty.
  ///
  /// In en, this message translates to:
  /// **'Select property'**
  String get selectProperty;

  /// No description provided for @selectUnit.
  ///
  /// In en, this message translates to:
  /// **'Select vacant unit'**
  String get selectUnit;

  /// No description provided for @moveInDate.
  ///
  /// In en, this message translates to:
  /// **'Move-in date'**
  String get moveInDate;

  /// No description provided for @billingDay.
  ///
  /// In en, this message translates to:
  /// **'Rent due day'**
  String get billingDay;

  /// No description provided for @securityDeposit.
  ///
  /// In en, this message translates to:
  /// **'Security deposit'**
  String get securityDeposit;

  /// No description provided for @advanceRent.
  ///
  /// In en, this message translates to:
  /// **'Advance rent'**
  String get advanceRent;

  /// No description provided for @agreementNotes.
  ///
  /// In en, this message translates to:
  /// **'Agreement notes (optional)'**
  String get agreementNotes;

  /// No description provided for @confirmTenancy.
  ///
  /// In en, this message translates to:
  /// **'Confirm tenancy'**
  String get confirmTenancy;

  /// No description provided for @tenantSaved.
  ///
  /// In en, this message translates to:
  /// **'Tenant saved'**
  String get tenantSaved;

  /// No description provided for @noTenantsYet.
  ///
  /// In en, this message translates to:
  /// **'No tenants have been added yet.'**
  String get noTenantsYet;

  /// No description provided for @searchTenants.
  ///
  /// In en, this message translates to:
  /// **'Search tenant, phone, unit or property'**
  String get searchTenants;

  /// No description provided for @activeTenant.
  ///
  /// In en, this message translates to:
  /// **'Active tenant'**
  String get activeTenant;

  /// No description provided for @formerTenant.
  ///
  /// In en, this message translates to:
  /// **'Former tenant'**
  String get formerTenant;

  /// No description provided for @currentUnit.
  ///
  /// In en, this message translates to:
  /// **'Current unit'**
  String get currentUnit;

  /// No description provided for @contactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact information'**
  String get contactInfo;

  /// No description provided for @rentalTerms.
  ///
  /// In en, this message translates to:
  /// **'Rental terms'**
  String get rentalTerms;

  /// No description provided for @tenancyHistory.
  ///
  /// In en, this message translates to:
  /// **'Tenancy history'**
  String get tenancyHistory;

  /// No description provided for @moveOut.
  ///
  /// In en, this message translates to:
  /// **'Move out'**
  String get moveOut;

  /// No description provided for @effectiveMoveOutDate.
  ///
  /// In en, this message translates to:
  /// **'Effective move-out date'**
  String get effectiveMoveOutDate;

  /// No description provided for @moveOutMessage.
  ///
  /// In en, this message translates to:
  /// **'Future recurring charges will stop. Billing and deposit settlement remain available for review.'**
  String get moveOutMessage;

  /// No description provided for @confirmMoveOut.
  ///
  /// In en, this message translates to:
  /// **'Confirm move-out'**
  String get confirmMoveOut;

  /// No description provided for @currentBalance.
  ///
  /// In en, this message translates to:
  /// **'Current balance'**
  String get currentBalance;

  /// No description provided for @depositBalance.
  ///
  /// In en, this message translates to:
  /// **'Deposit balance'**
  String get depositBalance;

  /// No description provided for @noActiveTenancy.
  ///
  /// In en, this message translates to:
  /// **'No active tenancy'**
  String get noActiveTenancy;

  /// No description provided for @requiredSelection.
  ///
  /// In en, this message translates to:
  /// **'Please select an option'**
  String get requiredSelection;

  /// No description provided for @stepBasicInfo.
  ///
  /// In en, this message translates to:
  /// **'Basic information'**
  String get stepBasicInfo;

  /// No description provided for @stepTenancy.
  ///
  /// In en, this message translates to:
  /// **'Unit & tenancy'**
  String get stepTenancy;

  /// No description provided for @stepDeposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit & advance'**
  String get stepDeposit;

  /// No description provided for @chargeConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Charge configuration'**
  String get chargeConfiguration;

  /// No description provided for @electricity.
  ///
  /// In en, this message translates to:
  /// **'Electricity'**
  String get electricity;

  /// No description provided for @gas.
  ///
  /// In en, this message translates to:
  /// **'Gas'**
  String get gas;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get water;

  /// No description provided for @otherCharges.
  ///
  /// In en, this message translates to:
  /// **'Other recurring charges'**
  String get otherCharges;

  /// No description provided for @calculationMethod.
  ///
  /// In en, this message translates to:
  /// **'Calculation method'**
  String get calculationMethod;

  /// No description provided for @fixedMonthly.
  ///
  /// In en, this message translates to:
  /// **'Fixed monthly amount'**
  String get fixedMonthly;

  /// No description provided for @meterBased.
  ///
  /// In en, this message translates to:
  /// **'Meter reading × rate'**
  String get meterBased;

  /// No description provided for @manualMonthly.
  ///
  /// In en, this message translates to:
  /// **'Manual monthly amount'**
  String get manualMonthly;

  /// No description provided for @saveCharge.
  ///
  /// In en, this message translates to:
  /// **'Save charge'**
  String get saveCharge;

  /// No description provided for @generateBills.
  ///
  /// In en, this message translates to:
  /// **'Generate bills'**
  String get generateBills;

  /// No description provided for @billDetails.
  ///
  /// In en, this message translates to:
  /// **'Bill details'**
  String get billDetails;

  /// No description provided for @draft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get draft;

  /// No description provided for @finalized.
  ///
  /// In en, this message translates to:
  /// **'Finalized'**
  String get finalized;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @partial.
  ///
  /// In en, this message translates to:
  /// **'Partial'**
  String get partial;

  /// No description provided for @due.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get due;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @openingDue.
  ///
  /// In en, this message translates to:
  /// **'Opening due'**
  String get openingDue;

  /// No description provided for @currentCharges.
  ///
  /// In en, this message translates to:
  /// **'Current charges'**
  String get currentCharges;

  /// No description provided for @outstanding.
  ///
  /// In en, this message translates to:
  /// **'Outstanding'**
  String get outstanding;

  /// No description provided for @finalizeBill.
  ///
  /// In en, this message translates to:
  /// **'Finalize bill'**
  String get finalizeBill;

  /// No description provided for @billGenerated.
  ///
  /// In en, this message translates to:
  /// **'Draft bill generated'**
  String get billGenerated;

  /// No description provided for @noBills.
  ///
  /// In en, this message translates to:
  /// **'No bills for this month yet.'**
  String get noBills;

  /// No description provided for @selectMonth.
  ///
  /// In en, this message translates to:
  /// **'Select month'**
  String get selectMonth;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @reviewDraft.
  ///
  /// In en, this message translates to:
  /// **'Review draft'**
  String get reviewDraft;

  /// No description provided for @missingInputs.
  ///
  /// In en, this message translates to:
  /// **'Missing inputs'**
  String get missingInputs;

  /// No description provided for @billsExpected.
  ///
  /// In en, this message translates to:
  /// **'Bills expected'**
  String get billsExpected;

  /// No description provided for @meterReading.
  ///
  /// In en, this message translates to:
  /// **'Electricity reading'**
  String get meterReading;

  /// No description provided for @previousReading.
  ///
  /// In en, this message translates to:
  /// **'Previous reading'**
  String get previousReading;

  /// No description provided for @currentReading.
  ///
  /// In en, this message translates to:
  /// **'Current reading'**
  String get currentReading;

  /// No description provided for @consumption.
  ///
  /// In en, this message translates to:
  /// **'Units consumed'**
  String get consumption;

  /// No description provided for @rate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rate;

  /// No description provided for @calculatedAmount.
  ///
  /// In en, this message translates to:
  /// **'Calculated amount'**
  String get calculatedAmount;

  /// No description provided for @saveReading.
  ///
  /// In en, this message translates to:
  /// **'Save reading'**
  String get saveReading;

  /// No description provided for @recordPayment.
  ///
  /// In en, this message translates to:
  /// **'Record payment'**
  String get recordPayment;

  /// No description provided for @paymentHistory.
  ///
  /// In en, this message translates to:
  /// **'Payment history'**
  String get paymentHistory;

  /// No description provided for @paymentAmount.
  ///
  /// In en, this message translates to:
  /// **'Payment amount'**
  String get paymentAmount;

  /// No description provided for @paymentPosted.
  ///
  /// In en, this message translates to:
  /// **'Payment posted'**
  String get paymentPosted;

  /// No description provided for @reversePayment.
  ///
  /// In en, this message translates to:
  /// **'Reverse payment'**
  String get reversePayment;

  /// No description provided for @reversalReason.
  ///
  /// In en, this message translates to:
  /// **'Reversal reason'**
  String get reversalReason;

  /// No description provided for @reference.
  ///
  /// In en, this message translates to:
  /// **'Reference (optional)'**
  String get reference;

  /// No description provided for @paymentNote.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get paymentNote;

  /// No description provided for @outstandingTotal.
  ///
  /// In en, this message translates to:
  /// **'Total outstanding'**
  String get outstandingTotal;
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
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
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
