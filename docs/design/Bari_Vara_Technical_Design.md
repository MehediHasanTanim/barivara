# Bari Vara — Technical Design Document

## 1. Document Purpose

This document defines the technical design for **Bari Vara — Landlord/Rent Manager**, a fully offline mobile application for small Bangladeshi landlords managing approximately 2–20 rental units.

The design is based on the Bari Vara detailed feature specification and prioritizes:

- 100% offline operation for all core workflows
- Local database as the single source of truth
- Bengali and English support
- Reliable financial calculations
- Fast monthly bill generation
- Receipt generation and sharing without a backend
- Local backup/restore and portable exports
- Strong data integrity and auditability
- Simple architecture that can be maintained by a small development team

---

# 2. Technical Goals

## 2.1 Primary Goals

1. All normal application features must work without internet access.
2. No user account or backend server is required.
3. Financial records must remain consistent across bill generation, payments, dues, reversals, deposits, and move-out settlements.
4. Data must survive app restarts, device reboots, and application upgrades.
5. Users must be able to export and restore their data independently.
6. Bengali text and Bengali receipt output must render correctly on Android and iOS.
7. Historical financial records should never silently change because a property's current configuration changes.
8. The application should remain responsive with years of data for 2–20 units.
9. Sensitive tenant data should be protected locally.
10. Architecture should support future capabilities without requiring a rewrite.

## 2.2 Non-Goals for MVP

The MVP architecture does not require:

- Backend APIs
- Cloud database
- Real-time synchronization
- Tenant portal
- Web admin panel
- Multi-device concurrent editing
- Online payment processing
- Automatic bKash/Nagad reconciliation
- Server-side authentication
- Push notifications from a remote service

---

# 3. Recommended Technology Stack

## 3.1 Mobile Framework

**Recommended: Flutter**

Reasons:

- One codebase for Android and iOS
- Strong Bengali/Unicode support
- Good local database ecosystem
- Reliable PDF/file/share integration
- Suitable for offline-first applications
- Good support for localization, theming, state management, background tasks, and platform storage APIs

Recommended baseline:

- Flutter stable channel
- Dart 3.x
- Android minimum SDK selected according to current Play Store requirements
- iOS minimum version selected according to current App Store support requirements

## 3.2 State Management

**Riverpod**

Use Riverpod for:

- Dependency injection
- Application state
- Screen state
- Derived dashboard/report state
- Asynchronous local repository access
- Settings/preferences

Recommended packages:

- `flutter_riverpod`
- `riverpod_annotation`
- `riverpod_generator`

## 3.3 Local Database

**SQLite with Drift**

Recommended packages:

- `drift`
- `drift_flutter`
- `sqlite3_flutter_libs` where required

Why Drift:

- Strongly typed queries
- Compile-time query checking
- Migrations
- Transactions
- Joins and reporting queries
- Good fit for relational financial data
- Easier long-term maintenance than raw SQLite

## 3.4 Secure Key/Secret Storage

Use platform secure storage for small security-sensitive values such as:

- App-lock metadata
- Encryption key material
- Backup encryption key wrapping information

Recommended package:

- `flutter_secure_storage`

Do **not** store the main relational dataset in secure storage.

## 3.5 Preferences

Use a lightweight preference layer for non-critical settings:

- Selected language
- Theme
- Last selected property
- Dashboard display options
- Reminder preferences

Recommended package:

- `shared_preferences`

Financial or business records must remain in SQLite, not preferences.

## 3.6 File Handling

Recommended packages:

- `path_provider`
- `file_picker`
- `share_plus`
- `archive`
- `crypto`

Optional encrypted backup implementation may use an audited cryptographic package that supports AES-GCM.

## 3.7 PDF and Receipt Generation

Recommended packages:

- `pdf`
- `printing`

Receipt output should support:

- PDF
- Shareable image if required
- Print preview
- Native share sheet

A Bengali-capable font must be embedded in generated PDFs rather than relying on device font availability.

## 3.8 Notifications

Recommended:

- `flutter_local_notifications`
- Platform scheduling APIs as appropriate

No remote push service is required.

## 3.9 Biometrics

Optional:

- `local_auth`

Use for unlocking the app if enabled by the user.

---

# 4. High-Level Architecture

Use a modular, layered architecture with clear separation between UI, application logic, domain rules, and persistence.

```text
+---------------------------------------------------+
| Presentation Layer                                |
| Screens / Widgets / Riverpod Controllers          |
+---------------------------------------------------+
                     |
                     v
+---------------------------------------------------+
| Application Layer                                 |
| Use Cases / Services / Commands / Queries         |
+---------------------------------------------------+
                     |
                     v
+---------------------------------------------------+
| Domain Layer                                      |
| Entities / Value Objects / Financial Rules        |
+---------------------------------------------------+
                     |
                     v
+---------------------------------------------------+
| Data Layer                                        |
| Repositories / Drift DAOs / File Storage          |
+---------------------------------------------------+
                     |
                     v
+---------------------------------------------------+
| Local Infrastructure                              |
| SQLite / Attachments / Secure Storage / Backups   |
+---------------------------------------------------+
```

## 4.1 Architectural Principle

The domain and application layers must not depend directly on Flutter widgets or SQLite implementation details.

Example:

```text
RecordPaymentUseCase
    -> PaymentRepository
        -> DriftPaymentRepository
            -> SQLite
```

This makes financial rules independently testable.

---

# 5. Recommended Project Structure

```text
lib/
  app/
    app.dart
    bootstrap.dart
    router.dart
    theme/
    localization/

  core/
    database/
    errors/
    logging/
    security/
    storage/
    utils/
    money/
    date_time/
    pdf/
    backup/

  features/
    properties/
      data/
      domain/
      application/
      presentation/

    units/
    tenants/
    agreements/
    billing/
    utilities/
    payments/
    receipts/
    dues/
    deposits/
    repairs/
    reports/
    reminders/
    backup_restore/
    settings/
    audit/

  shared/
    widgets/
    models/
    extensions/
```

Each feature can follow:

```text
feature/
  data/
    dao/
    dto/
    repositories/
  domain/
    entities/
    repositories/
    value_objects/
  application/
    use_cases/
    providers/
  presentation/
    screens/
    widgets/
    controllers/
```

---

# 6. Offline-First Data Strategy

## 6.1 Source of Truth

SQLite is the authoritative source for all business data.

The UI must not depend on internet availability.

Core actions must commit directly to the local database:

- Add tenant
- Generate bill
- Record payment
- Generate receipt
- Update meter reading
- Record repair
- Adjust deposit
- Move tenant out
- Generate reports

## 6.2 No Network Dependency

The application should start and remain fully usable with:

- Airplane mode enabled
- No SIM/network
- No Wi-Fi
- Cloud services unavailable

Any optional external export/sync integration must be isolated behind explicit user actions.

## 6.3 Transaction Boundaries

Financial workflows involving multiple records must use SQLite transactions.

Examples:

- Monthly bill generation
- Payment allocation
- Payment reversal
- Deposit settlement
- Move-out settlement
- Bulk bill generation
- Backup metadata checkpoint

---

# 7. Database Design

## 7.1 General Conventions

Every primary business table should contain:

- `id` — UUID/text or generated stable identifier
- `created_at`
- `updated_at`
- `is_archived` where applicable

For financial/audit-sensitive entities, prefer immutable history records instead of overwriting prior transactions.

Store timestamps in UTC internally and convert to local time for display.

Use ISO date semantics for date-only fields.

## 7.2 Money Representation

Never store money using floating-point values.

Recommended:

- Store amounts as integer **poisha**
- `৳1.00 = 100 poisha`

Example:

```text
৳15,000.00 -> 1,500,000 poisha
```

If the product decides never to support fractional BDT, integer taka is acceptable, but integer poisha is safer for future compatibility.

## 7.3 Core Tables

### 7.3.1 `properties`

```text
id
name
nickname
address_line
area
city_district
owner_name
owner_phone
receipt_header
currency_code
status
created_at
updated_at
```

### 7.3.2 `units`

```text
id
property_id
name
floor_name
unit_type
bedroom_count
bathroom_count
default_rent_amount
default_service_charge
default_water_charge
default_gas_charge
electricity_billing_mode
occupancy_status
notes
created_at
updated_at
```

Indexes:

- `property_id`
- `occupancy_status`
- unique `(property_id, name)` where appropriate

### 7.3.3 `electricity_meters`

```text
id
unit_id
meter_number
billing_mode
default_rate_per_unit
additional_charge
is_active
created_at
updated_at
```

### 7.3.4 `tenants`

```text
id
full_name
bangla_name
phone
alternative_phone
email
nid_number
occupation
employer
permanent_address
emergency_contact_name
emergency_contact_phone
family_member_count
profile_photo_path
notes
status
created_at
updated_at
```

### 7.3.5 `tenancies`

Separate a tenant person from an occupancy period.

```text
id
tenant_id
unit_id
move_in_date
expected_move_out_date
actual_move_out_date
status
created_at
updated_at
```

This allows a tenant to move between units without losing historical records.

### 7.3.6 `rental_agreements`

```text
id
tenancy_id
start_date
end_date
monthly_rent
service_charge
water_charge
gas_charge
rent_due_day
notice_period_days
late_fee_mode
late_fee_value
notes
status
created_at
updated_at
```

Important: when rent changes, create a new agreement/version rather than rewriting historical bill data.

### 7.3.7 `deposit_accounts`

```text
id
tenancy_id
opening_deposit_amount
current_balance
created_at
updated_at
```

### 7.3.8 `deposit_transactions`

```text
id
deposit_account_id
type
amount
transaction_date
reference_type
reference_id
note
created_at
```

Types:

- RECEIVED
- ADJUSTED
- DEDUCTED
- REFUNDED
- CORRECTION

### 7.3.9 `monthly_bills`

```text
id
tenancy_id
property_id
unit_id
billing_year
billing_month
billing_period_start
billing_period_end
status
previous_due_snapshot
subtotal
adjustment_amount
late_fee_amount
total_amount
paid_amount
balance_amount
finalized_at
created_at
updated_at
```

Suggested statuses:

- DRAFT
- FINALIZED
- PARTIALLY_PAID
- PAID
- VOID

Constraint:

- One active monthly bill per tenancy + billing year + billing month

### 7.3.10 `bill_items`

```text
id
bill_id
item_type
description
quantity
unit_rate
amount
sort_order
metadata_json
created_at
```

Types:

- RENT
- ELECTRICITY
- GAS
- WATER
- SERVICE_CHARGE
- PREVIOUS_DUE
- LATE_FEE
- REPAIR_CHARGE
- OTHER
- DISCOUNT
- ADJUSTMENT

Bill items should preserve snapshots of the actual values used during bill generation.

### 7.3.11 `meter_readings`

```text
id
meter_id
unit_id
billing_year
billing_month
previous_reading
current_reading
consumption
rate_per_unit
additional_charge
calculated_amount
reading_date
photo_path
created_at
```

Constraint:

- Current reading >= previous reading unless explicitly handled as meter replacement/reset

### 7.3.12 `payments`

```text
id
tenancy_id
payment_number
payment_date
amount
payment_method
reference
note
status
created_at
updated_at
```

Methods:

- CASH
- BKASH
- NAGAD
- BANK_TRANSFER
- CHEQUE
- OTHER

Statuses:

- POSTED
- REVERSED

### 7.3.13 `payment_allocations`

```text
id
payment_id
bill_id
amount
created_at
```

This table supports:

- Partial payments
- One payment covering multiple months
- Multiple payments against one bill

### 7.3.14 `tenant_credits`

```text
id
tenancy_id
source_payment_id
opening_amount
remaining_amount
status
created_at
updated_at
```

Optional but recommended for overpayment support.

### 7.3.15 `receipts`

```text
id
receipt_number
payment_id
tenancy_id
issue_date
language
format_version
snapshot_json
pdf_path
created_at
```

`format_version` allows template changes without invalidating old receipts.

`snapshot_json` should preserve the data shown on the issued receipt.

### 7.3.16 `repairs`

```text
id
property_id
unit_id
tenancy_id
category
title
description
reported_date
completed_date
cost_amount
responsibility
charged_to_tenant_amount
vendor_name
status
notes
created_at
updated_at
```

### 7.3.17 `attachments`

```text
id
entity_type
entity_id
file_name
relative_path
mime_type
file_size
checksum
created_at
```

Never rely on absolute device paths inside portable backup files.

### 7.3.18 `reminders`

```text
id
entity_type
entity_id
reminder_type
scheduled_at
repeat_rule
notification_id
is_enabled
created_at
updated_at
```

### 7.3.19 `audit_events`

```text
id
entity_type
entity_id
action
action_at
summary
before_json
after_json
created_at
```

For MVP, capture at least financially important changes.

### 7.3.20 `app_settings`

```text
key
value_json
updated_at
```

---

# 8. Entity Relationships

```text
Property
  1 ---- * Unit

Unit
  1 ---- * Tenancy

Tenant
  1 ---- * Tenancy

Tenancy
  1 ---- * RentalAgreement
  1 ---- 1 DepositAccount
  1 ---- * MonthlyBill
  1 ---- * Payment
  1 ---- * Repair

MonthlyBill
  1 ---- * BillItem
  * ---- * Payment via PaymentAllocation

ElectricityMeter
  1 ---- * MeterReading

Payment
  1 ---- * PaymentAllocation
  1 ---- 0..1 Receipt
```

---

# 9. Billing Engine Design

## 9.1 Responsibility

Create a dedicated `BillingEngine` in the domain/application layer.

It should calculate bills but should not directly manage widgets or SQL queries.

Inputs:

- Tenancy
- Active agreement snapshot
- Billing month
- Utility values
- Previous unpaid balance
- Optional adjustments
- Optional repair charge
- Optional late fee

Outputs:

- Bill draft
- Itemized components
- Calculated total
- Validation result

## 9.2 Base Formula

```text
Subtotal =
    Rent
  + Electricity
  + Gas
  + Water
  + Service Charge
  + Other Charges
  + Repair Charge
  + Late Fee
  - Discounts

Total = Subtotal + Previous Due + Adjustments
```

All calculations must operate on integer money values.

## 9.3 Previous Due Rule

Previous due for a new bill must be calculated from posted financial records, not from editable UI state.

Recommended:

```text
Previous Due = Sum(finalized bill totals before period)
             - Sum(posted allocations to those bills)
             - applicable credit adjustments
```

For performance, a snapshot can be stored on the new bill, but the source calculation must remain deterministic.

## 9.4 Bill Snapshot Principle

When a bill is finalized, store the exact values used:

- Rent amount
- Utility rates
- Meter readings
- Fixed charges
- Previous due
- Late fee
- Adjustments

Changing a unit's current default rent must not change an old finalized bill.

## 9.5 Finalization

Draft bills can be edited.

After finalization:

- Core line items should become immutable
- Corrections should use explicit adjustment or void/reissue workflows
- Audit event should be created

## 9.6 Bulk Monthly Bill Generation

Workflow:

1. Query active tenancies for selected property.
2. Determine eligible month.
3. Skip tenancies that already have an active bill.
4. Validate missing utility inputs.
5. Create bill drafts.
6. Show preview summary.
7. Finalize selected bills in one database transaction.

---

# 10. Electricity Calculation Design

## 10.1 Fixed Charge

```text
amount = configured_fixed_amount
```

## 10.2 Manual Amount

User enters amount directly for the month.

## 10.3 Meter-Based

```text
consumption = current_reading - previous_reading
amount = consumption * rate_per_unit + additional_charge
```

Store all operands in the meter reading record.

## 10.4 Included in Rent

Bill item is either omitted or stored with `amount = 0` and explanatory metadata.

## 10.5 Meter Replacement

Provide an explicit meter-reset/replacement action.

Do not allow a normal reading lower than the prior reading without this workflow.

---

# 11. Payment Engine Design

## 11.1 Payment Recording

`RecordPaymentUseCase` should:

1. Validate amount > 0.
2. Create payment record.
3. Allocate amount to selected bills.
4. Update cached bill paid/balance amounts.
5. Create tenant credit for remaining overpayment if enabled.
6. Generate audit event.
7. Optionally create receipt.
8. Commit all changes in one transaction.

## 11.2 Allocation Strategy

Support:

- Manual allocation
- Automatic oldest-due-first allocation

Recommended default:

```text
Oldest unpaid finalized bill -> next oldest -> current bill -> credit
```

The user should be able to review allocation before saving.

## 11.3 Partial Payment

Example:

```text
Bill total: ৳19,510
Payment:    ৳10,000
Balance:     ৳9,510
```

The bill status becomes `PARTIALLY_PAID`.

## 11.4 Overpayment

Example:

```text
Outstanding: ৳19,510
Payment:     ৳20,000
Credit:         ৳490
```

Do not silently modify a later bill. Record credit explicitly.

## 11.5 Payment Reversal

Never delete a posted payment from history.

Reversal should:

- Mark original payment `REVERSED`
- Reverse related allocations
- Reverse generated credit
- Update bill balances
- Preserve receipt history
- Create audit event

If necessary, generate a reversal/cancellation receipt record.

---

# 12. Deposit Accounting Design

Security deposits should remain separate from rent payments.

Recommended ledger model:

```text
Deposit balance =
  deposits received
+ positive adjustments
- deductions
- refunds
```

Deposit transactions must not automatically count as rental income.

Move-out settlement can reference deposit deductions such as:

- Outstanding rent
- Utility balance
- Damage repair
- Cleaning charge
- Other agreed adjustment

Settlement must preserve an itemized statement.

---

# 13. Receipt Generation Design

## 13.1 Receipt Data

A receipt should be generated from a frozen snapshot containing:

- Receipt number
- Date
- Property
- Unit
- Tenant name
- Billing month(s)
- Amount received
- Payment method
- Bill allocation breakdown
- Remaining due
- Optional landlord details
- Optional note

## 13.2 Receipt Number Format

Example:

```text
BV-2026-000001
```

Or property-specific:

```text
RV-2026-000001
```

Maintain a local sequence table or settings counter and allocate numbers transactionally.

## 13.3 Bengali Receipt Example

```text
রসিদ নং: BV-2026-000125
তারিখ: ০৫ অক্টোবর ২০২৬

ভাড়াটিয়া: মোঃ রহমান
ইউনিট: ২এ

অক্টোবর ২০২৬
বাসা ভাড়া: ৳১৫,০০০
বিদ্যুৎ: ৳১,৪৩০
গ্যাস: ৳১,০৮০
পূর্বের বকেয়া: ৳২,০০০
মোট: ৳১৯,৫১০

পরিশোধ: ৳১৯,৫১০
বাকি: ৳০
```

## 13.4 PDF Rendering

Receipt PDF generation should:

- Embed a Bengali-capable font
- Use fixed layout templates
- Support Bengali and English numeral formatting
- Avoid device-font dependency
- Render identically offline

## 13.5 Share Flow

```text
Payment Saved
    -> Generate Receipt Snapshot
    -> Render PDF
    -> Save to app documents/cache
    -> Native Share Sheet
```

Sharing can work through apps installed on the device; Bari Vara itself remains offline.

---

# 14. Reporting Architecture

Reports should query normalized transactional records instead of maintaining excessive duplicated report tables.

Recommended report services:

- `MonthlyCollectionReportService`
- `OutstandingDueReportService`
- `TenantLedgerReportService`
- `PropertyIncomeReportService`
- `DepositReportService`
- `VacancyReportService`
- `RepairExpenseReportService`

For performance, add indexes rather than introducing premature caching.

## 14.1 Tenant Ledger

Ledger should combine chronologically:

- Bills
- Payments
- Adjustments
- Credits
- Deposit movements where shown separately

## 14.2 Dashboard Queries

Dashboard metrics:

- Expected rent this month
- Amount billed
- Amount collected
- Current outstanding
- Fully paid tenant count
- Partial payment count
- Unpaid tenant count
- Vacant units

Use database aggregation queries, not loops over all records in UI code.

---

# 15. Search and Filtering

Searchable fields may include:

- Tenant name
- Bengali tenant name
- Phone
- Unit number
- Property name
- Receipt number
- Payment number

Recommended indexes:

- Tenant phone
- Tenant status
- Unit property/status
- Bill tenancy/year/month/status
- Payment tenancy/date
- Receipt number
- Repair unit/date/status

For the target scale, normal indexed SQLite queries are sufficient.

---

# 16. Attachment Storage

## 16.1 Storage Model

Store binary files in the app's document directory rather than SQLite BLOB columns.

SQLite stores metadata and relative path.

Example:

```text
app_data/
  attachments/
    tenants/
    agreements/
    meters/
    repairs/
  receipts/
  exports/
  backups/
```

## 16.2 File Naming

Use generated IDs rather than user names.

Example:

```text
attachments/tenants/01J.../nid_front.jpg
```

## 16.3 Integrity

Optionally store SHA-256 checksum for backup verification.

---

# 17. Backup Design

Backup is critical because there is no backend copy of user data.

## 17.1 Backup Package Format

Recommended custom package:

```text
BariVara_Backup_2026-10-05.bvb
```

Internally it can be a ZIP-compatible archive containing:

```text
manifest.json
database.sqlite
attachments/
receipts/
metadata/
  app_version.json
```

## 17.2 Manifest

Example:

```json
{
  "format": "barivara-backup",
  "backupVersion": 1,
  "appVersion": "1.0.0",
  "createdAt": "2026-10-05T10:30:00Z",
  "databaseSchemaVersion": 5,
  "encrypted": true,
  "checksumAlgorithm": "SHA-256"
}
```

## 17.3 Consistent Database Snapshot

Do not simply copy a database file while writes are active.

Use one of:

- SQLite backup API
- Controlled transaction/checkpoint before copying
- Close/reopen database around snapshot if necessary

## 17.4 Encrypted Backup

Recommended advanced/default-secure option:

1. Create backup archive.
2. Generate random salt/nonce.
3. Derive encryption key from backup password using a strong KDF.
4. Encrypt archive using AES-GCM or equivalent authenticated encryption.
5. Store encryption metadata in package header.

Never implement custom cryptography algorithms.

## 17.5 Restore Validation

Before overwriting current data:

1. Validate file signature/format.
2. Validate backup version.
3. Validate checksum/authentication tag.
4. Read schema version.
5. Confirm compatibility.
6. Create emergency backup of current database.
7. Restore into temporary directory.
8. Run integrity checks/migrations.
9. Atomically switch to restored data.

If any step fails, preserve the existing dataset.

---

# 18. Export Design

## 18.1 CSV

Export examples:

- Tenant list
- Monthly billing report
- Payment history
- Due report
- Repair expenses

Use UTF-8 with BOM where useful for compatibility with spreadsheet software handling Bengali text.

## 18.2 PDF

Reports and statements may be exported as PDF.

All PDF generation is local.

## 18.3 External Destinations

The app can use the native file picker/share sheet to export to:

- Google Drive
- OneDrive
- Dropbox
- Device storage
- Email/messaging apps

The app does not need direct cloud SDK integration for MVP.

---

# 19. Optional Cloud File Backup Architecture

If direct provider integration is added later, keep it outside the core business layer.

```text
BackupService
    -> BackupDestination interface
        -> LocalFileDestination
        -> GoogleDriveDestination
        -> OneDriveDestination
        -> DropboxDestination
```

The local database remains the source of truth.

Do not introduce distributed synchronization semantics unless multi-device sync becomes a defined product requirement.

---

# 20. Localization Design

## 20.1 Supported Languages

- Bengali (`bn`)
- English (`en`)

Use Flutter localization tooling with ARB resources.

Example:

```text
lib/l10n/
  app_en.arb
  app_bn.arb
```

## 20.2 Never Hardcode UI Strings

All user-facing text should use localization keys.

## 20.3 Numeral Formatting

Support user preference:

- Bengali UI + Bengali digits
- Bengali UI + Latin digits
- English UI + Latin digits

Internally all numbers remain numeric values.

Never store formatted Bengali number strings as source data.

## 20.4 Currency Formatting

Create one centralized `MoneyFormatter`.

Examples:

```text
৳19,510
৳১৯,৫১০
```

---

# 21. Date and Billing Period Design

Use Gregorian calendar dates internally.

Display localized month names where appropriate.

Example:

```text
2026-10 -> October 2026
2026-10 -> অক্টোবর ২০২৬
```

Represent billing period using numeric year/month fields rather than parsing display strings.

---

# 22. Security Design

## 22.1 Threat Model

Primary risks:

- Lost/stolen device
- Unauthorized family/caretaker access
- Sensitive tenant documents exposed through storage
- Backup file leakage
- Accidental data loss

## 22.2 App Lock

Support:

- PIN
- Biometrics where available
- Auto-lock timeout

Never store plaintext PIN.

Store a slow password hash/verifier or platform-protected credential metadata.

## 22.3 Database Encryption

Two implementation levels are possible:

### MVP

- Platform application sandbox
- Secure app lock
- Sensitive documents in private app storage
- Encrypted backup

### Enhanced Security

Use SQLCipher-compatible database encryption if product/security requirements justify the added complexity.

The database encryption key should be random and protected using Android Keystore/iOS Keychain.

## 22.4 Screenshot Protection

Optional privacy setting:

- Android secure-window flag
- iOS privacy overlay/app-switcher protection as appropriate

Avoid blocking screenshots by default if users need to capture receipts.

---

# 23. Audit and Financial History

Auditability is especially important for:

- Bill finalization
- Bill void
- Payment creation
- Payment reversal
- Deposit deduction/refund
- Rent change
- Meter correction
- Move-out settlement

Use append-only audit records for these operations.

For normal profile edits, a lighter change history is sufficient.

---

# 24. Database Migration Strategy

Every released schema change must have a migration.

Example:

```text
Schema v1 -> Initial MVP
Schema v2 -> Add tenant credit
Schema v3 -> Add attachment checksums
Schema v4 -> Add audit details
```

Requirements:

- Migration tests using old database fixtures
- Never destructively reset production databases
- Backup recommendation before major migration
- Database schema version included in backup manifest

---

# 25. Error Handling

Create typed application failures such as:

```text
ValidationFailure
DatabaseFailure
FileAccessFailure
BackupFailure
RestoreFailure
PdfGenerationFailure
NotificationPermissionFailure
SecurityFailure
```

Presentation layer maps these to localized user messages.

Do not expose raw SQLite exceptions to the user.

---

# 26. Logging

Use structured local debug logging during development.

Production logging rules:

- Never log NID numbers
- Never log PINs or encryption keys
- Avoid full tenant addresses in logs
- Avoid dumping entire database rows
- Avoid logging receipt/document file content

A local diagnostic export can be added later with explicit user consent.

---

# 27. Notifications and Reminders

Use only local scheduled notifications for MVP.

Examples:

- Rent due reminder
- Tenant payment follow-up
- Agreement expiry reminder
- Scheduled repair reminder
- Backup reminder

Reminder logic:

```text
Database reminder record
    -> Scheduler Service
        -> OS local notification
```

On app startup or relevant data changes, reconcile scheduled notifications with database records.

---

# 28. Background Processing

Keep background work limited.

Suitable background/local tasks:

- Notification scheduling
- Cleanup of temporary receipt files
- Optional scheduled local backup reminder

Do not depend on background execution for critical accounting state because mobile operating systems may suspend the app.

---

# 29. Performance Design

Expected scale is modest:

```text
20 units
x 12 bills/year
x 10 years
= 2,400 monthly bills
```

Even with payments, repairs, and attachments, SQLite easily supports this scale.

Recommended optimizations:

- Proper indexes
- Paginate long transaction history
- Avoid loading attachment bytes until required
- Use database aggregation for reports
- Debounce search inputs
- Generate large PDFs off the main UI isolate when necessary

Do not introduce unnecessary caching layers for MVP.

---

# 30. Concurrency and Data Consistency

Although the app is single-user/single-device for MVP, asynchronous UI actions can still race.

Protect critical workflows with:

- Database transactions
- Unique constraints
- Idempotency checks for bill generation
- Disabled duplicate-submit buttons while saving

Example:

A user tapping **Generate Bill** twice must not create two October bills for the same tenancy.

---

# 31. Key Domain Services

Recommended services/use cases:

```text
CreatePropertyUseCase
CreateUnitUseCase
CreateTenantUseCase
StartTenancyUseCase
UpdateRentalAgreementUseCase
GenerateMonthlyBillUseCase
GenerateBulkMonthlyBillsUseCase
FinalizeBillUseCase
CalculateElectricityUseCase
RecordPaymentUseCase
ReversePaymentUseCase
ApplyTenantCreditUseCase
ReceiveDepositUseCase
SettleDepositUseCase
GenerateReceiptUseCase
GenerateTenantLedgerUseCase
RecordRepairUseCase
MoveOutTenantUseCase
CreateBackupUseCase
RestoreBackupUseCase
ExportReportUseCase
ScheduleReminderUseCase
```

---

# 32. Main Application Workflows

## 32.1 Add Tenant and Start Tenancy

```text
Create/Select Unit
    -> Create Tenant
    -> Create Tenancy
    -> Create Rental Agreement
    -> Record Security Deposit
    -> Mark Unit Occupied
    -> Commit Transaction
```

## 32.2 Generate Monthly Bill

```text
Select Month
    -> Load Active Tenancy
    -> Load Agreement
    -> Enter/Calculate Utility Data
    -> Calculate Previous Due
    -> Build Draft Bill
    -> Preview
    -> Finalize
    -> Audit
```

## 32.3 Record Payment

```text
Select Tenant/Bill
    -> Enter Amount + Method
    -> Determine Allocation
    -> Preview
    -> Save Payment
    -> Update Bill Balances
    -> Handle Credit
    -> Generate Receipt
```

## 32.4 Move Out

```text
Start Move-Out
    -> Calculate Outstanding Bills
    -> Add Final Utilities
    -> Add Repair/Damage Deductions
    -> Calculate Deposit Balance
    -> Record Settlement
    -> Refund/Deduct Deposit
    -> Close Tenancy
    -> Mark Unit Vacant
    -> Generate Statement
```

---

# 33. UI Architecture

Recommended pattern:

```text
Screen
  -> Controller / Notifier
      -> Use Case
          -> Repository
              -> DAO
```

UI widgets should not directly call Drift DAOs.

Screen state should explicitly represent:

```text
Loading
Data
Empty
Saving
Success
ValidationError
Failure
```

---

# 34. Navigation Architecture

Recommended bottom navigation:

1. Home
2. Tenants
3. Bills
4. Payments/Dues
5. More

`More` can expose:

- Properties & Units
- Repairs
- Reports
- Receipts
- Backup & Restore
- Settings

Use a declarative router such as `go_router` if deep navigation becomes significant.

---

# 35. Validation Rules

Centralize validation in domain/application logic, not only form widgets.

Examples:

### Tenant

- Name required
- Valid phone format when provided
- Move-in date required for active tenancy

### Unit

- Unit name required
- Monthly rent >= 0

### Meter

- Current reading >= previous reading unless reset flow used
- Rate >= 0

### Payment

- Amount > 0
- Cannot allocate more than payment amount
- Cannot allocate to void bill

### Bill

- One active bill per tenancy/month
- Finalized bill total cannot change directly

### Deposit

- Refund/deduction cannot exceed available balance unless an explicit override rule exists

---

# 36. Data Integrity Rules

Important database/application constraints:

1. A unit cannot have more than one active tenancy at the same time.
2. A tenancy must reference one tenant and one unit.
3. Finalized bills cannot be physically deleted.
4. Posted payments cannot be physically deleted.
5. Reversed payments remain visible in history.
6. Payment allocation sum cannot exceed payment amount.
7. Final bill balance cannot become negative unless represented as tenant credit.
8. Deposit balance is separate from rental balance.
9. Historical bill items are snapshots and do not change when defaults change.
10. Attachment paths must resolve inside approved app storage directories.

---

# 37. Testing Strategy

## 37.1 Unit Tests

Highest-priority tests:

- Bill calculation
- Previous due calculation
- Electricity calculation
- Payment allocation
- Partial payment
- Overpayment/credit
- Payment reversal
- Deposit balance
- Move-out settlement
- Bengali/English money formatting

## 37.2 Repository Tests

Test:

- CRUD
- Transactions
- Unique constraints
- Cascading/archive behavior
- Query filters
- Report aggregation

Use temporary/in-memory SQLite where appropriate.

## 37.3 Migration Tests

Keep database fixtures for previous released schema versions.

Verify that migration:

- Completes successfully
- Preserves financial totals
- Preserves relationships
- Preserves attachments metadata

## 37.4 Widget Tests

Focus on:

- Bill entry
- Payment flow
- Due state
- Error states
- Language switching

## 37.5 Integration Tests

Critical end-to-end scenarios:

1. Create property -> unit -> tenant -> bill -> payment -> receipt.
2. Partial payment -> next payment -> fully paid.
3. Previous due carried into later billing.
4. Meter reading calculation.
5. Backup -> erase test data -> restore -> compare financial totals.
6. Tenant move-out with deposit settlement.
7. App restart with all records intact.
8. Operation in airplane mode.

---

# 38. Test Fixtures and Financial Invariants

Define deterministic test fixtures.

Example:

```text
October 2026
Rent              ৳15,000
Electricity        ৳1,430
Gas                ৳1,080
Previous Due       ৳2,000
Total              ৳19,510
```

Automated tests must verify:

```text
15,000 + 1,430 + 1,080 + 2,000 = 19,510
```

Financial invariant examples:

```text
Bill balance = Bill total - valid allocations
Payment allocated + credit created = Payment amount
Deposit balance = deposits + adjustments - deductions - refunds
```

---

# 39. Backup/Restore Test Requirements

At minimum test:

- Fresh backup creation
- Restore same version
- Restore older schema backup
- Wrong password
- Corrupted archive
- Missing attachment
- Duplicate restore attempt
- Interrupted restore
- Insufficient storage
- Bengali filenames/content

Existing local data must not be destroyed when restore validation fails.

---

# 40. Build and Release Configuration

Recommended environments:

- Development
- Production

Since there is no backend, environment complexity is small.

Configuration should still separate:

- Debug logging
- Database inspection tools
- Crash/analytics features if ever enabled
- Developer menus

Do not ship test/demo data in production unless explicitly selected during onboarding.

---

# 41. Privacy and Analytics

For a fully offline privacy-first product, MVP can operate with **no analytics SDK**.

If analytics/crash reporting is added later:

- Make network behavior transparent
- Avoid tenant PII
- Consider explicit consent
- Keep core functionality independent of analytics availability

---

# 42. Suggested MVP Technical Modules

## Phase 1 Modules

- App shell
- Localization
- Theme
- Database foundation
- Property
- Unit
- Tenant
- Tenancy
- Rental agreement

## Phase 2 Modules

- Monthly billing
- Bill items
- Electricity readings
- Gas/water/service charge
- Previous due

## Phase 3 Modules

- Payments
- Allocations
- Partial payment
- Credit handling
- Receipts

## Phase 4 Modules

- Deposit
- Repairs
- Move-out
- Tenant ledger

## Phase 5 Modules

- Dashboard
- Reports
- Search/filter
- Local notifications

## Phase 6 Modules

- Backup/restore
- CSV/PDF export
- Security/app lock
- Audit hardening
- Migration tests
- Release hardening

---

# 43. Recommended MVP Package Set

Illustrative package categories:

```text
State Management
- flutter_riverpod
- riverpod_annotation

Database
- drift
- drift_flutter

Navigation
- go_router

Localization
- flutter_localizations
- intl

Files
- path_provider
- file_picker
- share_plus

PDF
- pdf
- printing

Security
- flutter_secure_storage
- local_auth

Notifications
- flutter_local_notifications

Utilities
- uuid
- crypto
- archive
```

Package versions should be selected during implementation based on the current stable Flutter ecosystem and platform compatibility.

---

# 44. Recommended Domain Models

Core domain entities:

```text
Property
Unit
Tenant
Tenancy
RentalAgreement
SecurityDepositAccount
DepositTransaction
MonthlyBill
BillItem
ElectricityMeter
MeterReading
Payment
PaymentAllocation
TenantCredit
Receipt
Repair
Attachment
Reminder
AuditEvent
```

Important value objects:

```text
Money
BillingPeriod
PhoneNumber
ReceiptNumber
PaymentNumber
MeterValue
DateRange
```

`Money` should encapsulate arithmetic to prevent accidental floating-point use.

---

# 45. Example Repository Interfaces

```dart
abstract interface class BillRepository {
  Future<MonthlyBill?> findForPeriod(
    String tenancyId,
    BillingPeriod period,
  );

  Future<void> save(MonthlyBill bill);

  Future<List<MonthlyBill>> findOutstandingByTenancy(
    String tenancyId,
  );
}
```

```dart
abstract interface class PaymentRepository {
  Future<void> postPayment(Payment payment);
  Future<void> reversePayment(String paymentId);
  Future<List<Payment>> findByTenancy(String tenancyId);
}
```

Infrastructure implementations can use Drift without exposing Drift types to the domain layer.

---

# 46. Example Billing Service Contract

```dart
abstract interface class BillingService {
  Future<BillDraft> generateDraft({
    required String tenancyId,
    required BillingPeriod period,
    required UtilityInput utilities,
    List<BillAdjustment> adjustments = const [],
  });

  Future<MonthlyBill> finalize(BillDraft draft);
}
```

`BillDraft` should contain both calculated items and validation warnings.

---

# 47. Receipt Snapshot Versioning

Receipt templates will evolve.

Store:

```text
format_version = 1
snapshot_json = {...}
```

Old receipts can then be reproduced from their original snapshot instead of querying changed tenant/property data.

This prevents a landlord address change from rewriting historical receipt content.

---

# 48. Deletion and Archiving Policy

Prefer archive/close operations for referenced data.

Examples:

- Property with history -> archive, not delete
- Unit with bills -> archive, not delete
- Tenant with financial history -> former/inactive, not delete
- Finalized bill -> void, not delete
- Payment -> reverse, not delete

Hard delete can be allowed only for unused draft/setup records with no dependent history.

---

# 49. Data Retention

Because all data is user-owned and local:

- Do not automatically purge financial history.
- Temporary generated files may be cleaned.
- Archived tenant/property data remains restorable/searchable.
- User-controlled full data deletion should require strong confirmation.

---

# 50. Future Extensibility

The design should leave room for:

- Direct Google Drive/OneDrive/Dropbox backup
- Multiple owner profiles
- Caretaker role/PIN
- Advanced expense tracking
- Rent escalation schedules
- Automatic late fees
- Multiple meters per unit
- Tenant communication templates
- OCR-assisted meter reading
- Cloud synchronization
- Tenant companion app
- Web dashboard

These should be added as separate modules rather than modifying the core accounting model unpredictably.

---

# 51. Architecture Decision Summary

| Area | Decision |
|---|---|
| Mobile | Flutter |
| State management | Riverpod |
| Database | SQLite + Drift |
| Source of truth | Local SQLite |
| Backend | None for MVP |
| Money | Integer poisha |
| IDs | Stable UUID/text IDs |
| Documents | Private app file storage |
| Receipt | Local PDF generation |
| Notifications | Local notifications |
| Backup | Portable local archive |
| Restore | Validated transactional restore |
| Security | App PIN/biometric + secure storage |
| Localization | Bengali + English ARB |
| Financial history | Immutable/finalized transaction model |
| Testing priority | Billing, payments, dues, deposits, backup |

---

# 52. Key Engineering Rules

1. **Never require the internet for core product functionality.**
2. **Never use floating point for money.**
3. **Never silently rewrite finalized financial history.**
4. **Never delete posted payments; reverse them.**
5. **Never mix security deposit balance with rental income.**
6. **Always use transactions for multi-record financial operations.**
7. **Always preserve bill and receipt snapshots.**
8. **Always verify backup integrity before restore.**
9. **Always keep user data portable.**
10. **Always test the application in airplane mode.**

---

# 53. Final Technical Direction

Bari Vara should be implemented as a **local-first Flutter application backed by SQLite/Drift**, with a clean financial domain model and no server dependency.

The most important architectural investment is not infrastructure complexity; it is **financial correctness and durable local data**. Bills, dues, payments, deposits, meter readings, receipts, and move-out settlements must be modeled as explicit historical transactions rather than editable totals.

For the intended 2–20 unit landlord segment, this architecture provides:

- Very fast local performance
- Low operating cost
- Strong offline reliability
- Straightforward Android/iOS delivery
- Good privacy
- Simple deployment
- Maintainable business logic
- A clear path to optional cloud backup or synchronization later without forcing the MVP to depend on a backend
