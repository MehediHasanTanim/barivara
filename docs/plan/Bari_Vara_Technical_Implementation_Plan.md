# Bari Vara — Detailed Technical Implementation Plan

## 1. Purpose

This document provides a task-by-task technical implementation plan for **Bari Vara — Landlord/Rent Manager**, a fully offline mobile application for small Bangladeshi landlords managing approximately 2–20 rental units.

The plan is aligned with the previously defined technical design and assumes:

- Flutter + Dart
- Riverpod for state management and dependency injection
- SQLite + Drift as the local source of truth
- Fully offline core operation
- Bengali and English localization
- Local receipt/PDF generation
- Local backup/restore
- Optional biometric/PIN app lock
- Android and iOS support

The implementation is divided into phases so that each phase produces testable, reviewable outputs.

---

# 2. Delivery Strategy

## 2.1 Recommended Delivery Model

Use incremental vertical slices instead of building all infrastructure first and all UI later.

Each major feature should ideally contain:

1. Domain model
2. Database schema/migration
3. Repository
4. Use case/application service
5. Riverpod state/controller
6. UI
7. Validation
8. Unit tests
9. Integration tests
10. Acceptance test

## 2.2 MVP Completion Definition

The MVP is complete when a landlord can:

1. Create a property and rental units.
2. Add tenants and assign them to units.
3. Configure rent and monthly charges.
4. Generate a monthly bill.
5. Include electricity, gas, water, service charge, previous dues, and other charges.
6. Record full or partial payments.
7. Carry outstanding dues forward correctly.
8. Track security deposit/advance.
9. Generate and share a Bengali or English receipt.
10. Track basic repair expenses.
11. View monthly income/due summaries.
12. Back up and restore all app data locally.
13. Use all core functions without internet connectivity.

---

# 3. Phase Overview

| Phase | Name | Primary Outcome |
|---|---|---|
| 0 | Project Foundation | Buildable Flutter application with engineering standards |
| 1 | Core Architecture & Database | Stable application architecture and local database |
| 2 | Localization & App Settings | Bengali/English UI, theme, app preferences |
| 3 | Property & Unit Management | Property and rental unit CRUD |
| 4 | Tenant & Tenancy Management | Tenant profiles, occupancy, move-in data |
| 5 | Charge Configuration | Rent and recurring charge rules |
| 6 | Monthly Billing Engine | Deterministic monthly bill generation |
| 7 | Payment & Due Management | Payments, partial payments, balances, reversals |
| 8 | Deposit & Advance Management | Security deposit and advance ledger |
| 9 | Receipt & Sharing | Bengali/English PDF receipt generation and sharing |
| 10 | Repair & Expense Tracking | Repair records and property expense tracking |
| 11 | Dashboard & Reports | Operational and financial summaries |
| 12 | Notifications & Reminders | Local reminders only |
| 13 | Backup, Restore & Export | User-owned portable data protection |
| 14 | Security & Privacy | App lock, secure storage, data protections |
| 15 | Quality, Performance & Release | Production hardening and store-ready builds |
| 16 | Advanced/Post-MVP | Optional advanced functionality |

---

# 4. Phase 0 — Project Foundation

## Goal

Create a maintainable Flutter project with consistent tooling, environments, code quality, and CI-ready structure.

## Tasks

### 0.1 Create Flutter Project

- Create project with Android and iOS targets.
- Configure organization/package identifiers.
- Define application display name: **Bari Vara**.
- Configure development and production build flavors if required.
- Set supported device orientations.
- Configure minimum Android/iOS deployment targets.

### 0.2 Establish Folder Structure

Create baseline directories:

```text
lib/
  app/
  core/
  features/
  shared/

test/
integration_test/
assets/
  fonts/
  icons/
  images/
```

Within each feature, prefer:

```text
feature_name/
  data/
  domain/
  application/
  presentation/
```

### 0.3 Add Core Dependencies

Add and pin dependencies for:

- flutter_riverpod
- riverpod_annotation
- riverpod_generator
- drift
- drift_flutter
- build_runner
- freezed/freezed_annotation if selected
- json_annotation/json_serializable if selected
- shared_preferences
- flutter_secure_storage
- path_provider
- file_picker
- share_plus
- pdf
- printing
- flutter_local_notifications
- local_auth
- intl
- uuid
- collection
- crypto
- archive

### 0.4 Configure Static Analysis

- Enable strict lints.
- Configure `analysis_options.yaml`.
- Disallow implicit dynamic where practical.
- Require explicit return types for public APIs.
- Enable unused import and dead-code detection.

### 0.5 Configure Formatting and Code Generation

- Standardize Dart formatter usage.
- Add code generation command documentation.
- Add generated-file exclusions to linting where necessary.
- Verify Riverpod/Drift generation works in a clean checkout.

### 0.6 Configure Environment Constants

Create typed application configuration for:

- Database name
- Database version
- Backup format version
- Receipt template version
- Logging flags
- Feature flags

No secrets should be embedded because the MVP has no backend/API dependency.

### 0.7 Add Error Boundary and Logging Foundation

- Add top-level Flutter error handler.
- Add zone error handling during bootstrap.
- Create structured local logger abstraction.
- Disable verbose logs in release builds.
- Ensure tenant financial information is not written to logs unnecessarily.

### 0.8 Establish Git Workflow

- Add `.gitignore`.
- Define branch naming convention.
- Define commit convention if team uses one.
- Add pull request checklist.

### 0.9 Add CI Validation

Configure CI steps for:

- Dependency restore
- Code generation
- Format validation
- Static analysis
- Unit tests
- Android debug build

Add iOS build validation where CI environment permits.

## Deliverables

- Clean Flutter project
- Build succeeds on Android and iOS
- Lint/test pipeline established
- Architecture folders available

## Acceptance Criteria

- Fresh clone can build using documented steps.
- `flutter analyze` reports no blocking issues.
- Base unit test suite executes successfully.

---

# 5. Phase 1 — Core Architecture & Local Database

## Goal

Implement reusable architecture foundations and make SQLite/Drift the reliable local source of truth.

## Tasks

### 1.1 Implement Application Bootstrap

- Initialize Flutter bindings.
- Initialize preferences.
- Initialize secure storage abstraction.
- Open Drift database.
- Initialize notification system.
- Resolve current locale/theme.
- Start Riverpod root container.

### 1.2 Define Core Result/Error Types

Create application error categories:

- ValidationError
- DatabaseError
- NotFoundError
- ConflictError
- FileSystemError
- BackupError
- RestoreError
- SecurityError
- PermissionError

Create a common result pattern if used by the architecture.

### 1.3 Define Base Domain Types

Create reusable value types:

- Money/Amount
- MonthKey or BillingMonth
- DateRange
- EntityId
- PhoneNumber
- MeterReading
- ChargeType
- PaymentMethod

Money should use integer minor units or a decimal-safe representation. Avoid binary floating-point for financial calculations.

### 1.4 Design Initial Drift Schema

Create tables for at least:

- properties
- units
- tenants
- tenancies
- recurring_charge_rules
- utility_meter_configs
- monthly_bills
- bill_line_items
- payments
- payment_allocations
- deposits
- deposit_transactions
- repairs
- repair_attachments
- settings/business_profile
- audit_events if enabled
- schema_metadata

### 1.5 Define Primary Keys and IDs

- Use UUIDs or stable locally generated IDs.
- Do not rely solely on auto-increment IDs if exported data may later be merged/imported.
- Ensure IDs remain stable across backup and restore.

### 1.6 Add Referential Integrity

Configure foreign keys and deletion rules.

Examples:

- Property cannot be deleted while active units exist unless a controlled cascade/archive flow is used.
- Unit history must not disappear when a tenant moves out.
- Bill/payment history should never be cascade-deleted accidentally.

### 1.7 Implement Database Indices

Add indices for commonly queried fields:

- property_id
- unit_id
- tenant_id
- tenancy_id
- billing_month
- bill_status
- payment_date
- created_at

### 1.8 Create Database Migration Framework

- Set schema version 1.
- Create migration strategy.
- Add pre-migration and post-migration hooks.
- Add migration test harness.
- Define rollback policy for failed upgrades.

### 1.9 Implement Repository Interfaces

Create domain/application-facing interfaces for:

- PropertyRepository
- UnitRepository
- TenantRepository
- TenancyRepository
- BillingRepository
- PaymentRepository
- DepositRepository
- RepairRepository
- SettingsRepository
- BackupRepository

### 1.10 Implement Drift Repository Base Patterns

- Map database rows to domain entities.
- Keep SQL/Drift details out of UI.
- Use transactions for multi-table financial updates.
- Standardize timestamps.

### 1.11 Add Database Health Check

On app startup:

- Confirm database can open.
- Validate basic schema metadata.
- Detect failed migrations.
- Surface safe recovery instructions on failure.

### 1.12 Create Test Fixtures

Build reusable factories for:

- Property
- Unit
- Tenant
- Tenancy
- Bill
- Payment
- Deposit
- Repair

## Deliverables

- Local database v1
- Core repositories
- Migration infrastructure
- Core domain types

## Acceptance Criteria

- Database persists across app restart.
- Foreign-key constraints work as intended.
- Repository unit tests can run against an in-memory/test database.
- No financial values use unsafe floating-point calculations.

---

# 6. Phase 2 — Localization, Theme & Application Settings

## Goal

Provide a Bangladesh-friendly bilingual application foundation.

## Tasks

### 2.1 Configure Flutter Localization

Support:

- English (`en`)
- Bengali (`bn`)

### 2.2 Create Translation Resource Files

Include translations for:

- Navigation
- Buttons
- Forms
- Validation messages
- Bill labels
- Payment labels
- Receipt labels
- Reports
- Settings
- Common error states

### 2.3 Bengali Number Formatting Strategy

Decide separately for:

- UI amounts
- Dates
- Receipt amounts
- Meter readings

Support Bangla digits where product requirements specify them, while preserving numeric calculation internally.

### 2.4 Implement Currency Formatting

- Default currency: BDT
- Symbol: `৳`
- Use consistent thousand separators.
- Support optional decimal places only where required.

### 2.5 Implement Bengali Date/Month Formatting

Examples:

- October 2026
- অক্টোবর ২০২৬

Create utility helpers so bill screens and receipts use the same formatting rules.

### 2.6 Configure Fonts

- Add Bengali-capable UI font.
- Add Bengali-capable font asset for PDF rendering.
- Verify conjuncts/ligatures.
- Verify digits and currency symbol.

### 2.7 Theme System

Implement:

- Light theme
- Dark theme if included in MVP
- System theme option
- Semantic colors for due/paid/warning states

### 2.8 General Settings Repository

Persist:

- Preferred language
- Theme mode
- Default receipt language
- Default payment method
- Default property
- Reminder settings

### 2.9 Settings UI

Create screens for:

- Language
- Appearance
- Receipt defaults
- Reminder preferences
- Data/backup area placeholder
- Security area placeholder

### 2.10 Localization Tests

- Widget tests in English.
- Widget tests in Bengali.
- Verify no major overflow on Bengali labels.
- Verify PDF font rendering independently.

## Deliverables

- English/Bengali application shell
- Shared number/date/currency formatters
- Settings persistence

---

# 7. Phase 3 — Property & Unit Management

## Goal

Allow landlords to represent their rental properties and units.

## Tasks

### 3.1 Define Property Domain Model

Fields may include:

- ID
- Property name
- Property type
- Address
- Area
- City/District
- Notes
- Active/archived status
- Created/updated timestamps

### 3.2 Property CRUD Use Cases

Implement:

- CreateProperty
- UpdateProperty
- GetProperty
- ListProperties
- ArchiveProperty

### 3.3 Property Validation

Rules:

- Name required.
- Duplicate names allowed only if UX can clearly distinguish them, otherwise warn.
- Archived properties excluded from default operational lists.

### 3.4 Property List UI

Show:

- Property name
- Unit count
- Occupied count
- Vacant count
- Current month due summary where available

### 3.5 Add/Edit Property UI

- Form validation
- Bengali/English labels
- Unsaved changes warning

### 3.6 Property Details UI

Tabs or sections:

- Units
- Tenants/current occupancy
- Monthly summary
- Repairs
- Property settings

### 3.7 Define Unit Domain Model

Fields:

- ID
- Property ID
- Unit number/name
- Floor
- Unit type
- Bedrooms if needed
- Default rent
- Status
- Notes

### 3.8 Unit CRUD Use Cases

Implement:

- CreateUnit
- UpdateUnit
- GetUnit
- ListUnitsByProperty
- ArchiveUnit

### 3.9 Unit Availability Rules

Define states:

- Vacant
- Occupied
- Reserved optional
- Archived

Occupancy must derive from active tenancy where possible rather than manual status alone.

### 3.10 Unit List UI

Provide filters for:

- All
- Occupied
- Vacant
- Archived

### 3.11 Add/Edit Unit UI

Include:

- Unit identifier
- Default monthly rent
- Default utility/service settings shortcut

### 3.12 Property/Unit Tests

Test:

- CRUD
- Archive constraints
- Occupancy derivation
- Cross-property separation

## Deliverables

- Fully functioning property/unit management

---

# 8. Phase 4 — Tenant & Tenancy Management

## Goal

Track tenant identity and occupancy history without destroying historical records.

## Tasks

### 4.1 Define Tenant Model

Fields may include:

- Full name
- Mobile number
- Alternate mobile
- National ID reference/number optional
- Permanent address
- Emergency contact
- Notes
- Photo/document path optional

### 4.2 Tenant CRUD

Implement:

- CreateTenant
- UpdateTenant
- GetTenant
- SearchTenants
- ArchiveTenant

### 4.3 Tenant Search

Search locally by:

- Name
- Phone number
- Unit
- Property

### 4.4 Define Tenancy Model

Fields:

- Tenant ID
- Unit ID
- Start date
- Expected end date optional
- Actual end date optional
- Agreed rent
- Billing day
- Security deposit target
- Advance rent amount
- Agreement notes
- Status

### 4.5 Create Tenancy Flow

Steps:

1. Select property/unit.
2. Select existing tenant or create new.
3. Set move-in date.
4. Set monthly rent.
5. Set billing configuration.
6. Record security deposit/advance if received.
7. Confirm tenancy.

### 4.6 Tenancy Conflict Validation

Prevent:

- Two active tenancies for the same unit for overlapping dates unless shared tenancy is explicitly supported.
- Move-in before another active tenancy ends.

### 4.7 Tenant Details Screen

Show:

- Current unit
- Contact info
- Tenancy start
- Current balance
- Deposit balance
- Billing history
- Payment history
- Repair notes if tenant-related

### 4.8 Move-Out Workflow Foundation

Implement basic move-out process:

- Select effective date.
- Stop future recurring bills.
- Calculate open dues.
- Show security deposit balance.
- Mark unit vacant after settlement or move-out confirmation.

Full settlement logic can be finalized after billing/deposit phases.

### 4.9 Tenancy History

Allow historical occupancy lookup by:

- Unit
- Tenant
- Date range

### 4.10 Tests

Test:

- Overlap prevention
- Move-in/move-out state transitions
- Tenant history preservation

## Deliverables

- Tenant profiles
- Active tenancy management
- Historical occupancy records

---

# 9. Phase 5 — Recurring Charges & Utility Configuration

## Goal

Configure how monthly charges are calculated before implementing the billing engine.

## Tasks

### 5.1 Define Charge Types

Core charge types:

- Rent
- Electricity
- Gas
- Water
- Service charge
- Previous due
- Repair recovery/tenant charge
- Other

### 5.2 Define Recurring Charge Rule Model

Fields:

- Tenancy ID or unit ID
- Charge type
- Calculation method
- Fixed amount
- Unit rate if metered
- Effective from month
- Effective to month optional
- Active flag

### 5.3 Calculation Methods

Support:

- Fixed monthly amount
- Meter reading × rate
- Manual amount each month
- Previous balance carried automatically

### 5.4 Electricity Configuration

Support either:

- Fixed electricity amount, or
- Meter-based calculation

Meter-based fields:

- Previous reading
- Current reading
- Unit consumption
- Rate per unit
- Optional fixed meter/service fee

Formula:

```text
consumption = current_reading - previous_reading
amount = consumption * unit_rate + fixed_fee
```

### 5.5 Gas Configuration

Support:

- Fixed amount
- Manual monthly amount

Optional future extension:

- Meter-based gas

### 5.6 Water Configuration

Support:

- Fixed amount
- Manual amount

Optional future extension:

- Shared-building allocation

### 5.7 Service Charge Configuration

- Fixed recurring amount
- Effective date/month
- Historical rule preservation

### 5.8 Charge Configuration UI

Per tenancy/unit show:

- Monthly rent
- Electricity mode
- Gas
- Water
- Service charge
- Other recurring charges

### 5.9 Effective-Date Rules

Do not rewrite historical bills when a recurring rule changes.

Example:

- Rent changes from ৳15,000 to ৳16,000 in January 2027.
- December 2026 bill must remain at ৳15,000.

### 5.10 Tests

Test:

- Effective date rule selection
- Meter calculations
- Invalid negative consumption
- Rule updates not changing old bills

## Deliverables

- Charge configuration subsystem
- Utility calculation primitives

---

# 10. Phase 6 — Monthly Billing Engine

## Goal

Create the core financial engine that generates deterministic monthly bills.

## Tasks

### 6.1 Define Monthly Bill Model

Header fields:

- Bill ID
- Tenancy ID
- Property ID
- Unit ID
- Billing month
- Issue date
- Due date optional
- Opening due
- Current charges total
- Grand total
- Paid amount
- Outstanding amount
- Status
- Generated timestamp
- Finalized timestamp optional

### 6.2 Define Bill Line Item Model

Each item stores a snapshot:

- Line type
- Description
- Quantity optional
- Unit price/rate optional
- Amount
- Meter readings optional
- Source rule ID optional
- Display order

### 6.3 Billing Calculation Service

Implement a pure domain service that receives:

- Tenancy
- Effective charge rules
- Prior outstanding balance
- Meter data/manual values

And returns a bill draft.

### 6.4 Previous Due Calculation

Define exact rule:

```text
previous_due = unpaid balance from eligible earlier finalized bills
```

Avoid double-counting when old balances have already been carried into another bill.

Recommended approach:

- Keep payment allocation against source bills.
- Display opening balance in current bill from aggregate prior outstanding amount.
- Do not create accounting duplicates of the old principal.

### 6.5 Bill Draft Workflow

Flow:

1. Select month/property/unit/tenant.
2. Load effective recurring charges.
3. Load previous outstanding.
4. Request current electricity reading if needed.
5. Allow manual adjustment of eligible charges.
6. Show bill preview.
7. Confirm/finalize.

### 6.6 Idempotency Rule

Prevent accidental duplicate bill creation for the same tenancy and billing month.

Possible unique constraint:

```text
UNIQUE(tenancy_id, billing_month)
```

Handle regeneration through edit/rebuild rules instead of inserting duplicates.

### 6.7 Bill Statuses

Recommended:

- Draft
- Finalized/Unpaid
- Partially Paid
- Paid
- Cancelled

### 6.8 Finalization Rules

After finalization:

- Snapshot all charge details.
- Do not recalculate automatically from changed settings.
- Require explicit adjustment workflow for corrections.

### 6.9 Bill Editing Rules

Before payment:

- Allow controlled edits.

After payment:

- Prefer adjustment/correction workflow rather than silently changing historical totals.

### 6.10 Bulk Monthly Bill Generation

For a property:

- Detect all active tenancies in selected month.
- Generate drafts.
- Highlight units requiring meter readings/manual values.
- Finalize individually or in batch where no additional input is required.

### 6.11 Current Meter Reading Capture

UI should show:

- Previous reading
- Current reading field
- Consumption preview
- Rate
- Calculated amount

### 6.12 Bill Details UI

Example:

```text
অক্টোবর ২০২৬
Rent: ৳15,000
Electricity: ৳1,430
Gas: ৳1,080
Previous due: ৳2,000
Total: ৳19,510
```

### 6.13 Billing Tests

Create comprehensive unit tests for:

- Fixed charges
- Metered electricity
- Previous dues
- Zero previous due
- Partial prior payment
- Rent change by effective month
- Mid-month move-in policy
- Duplicate generation
- Cancelled bills
- Rounding rules

### 6.14 Golden Financial Test Dataset

Create permanent fixtures representing at least 12 months of billing/payment history. Use them for regression testing whenever financial logic changes.

## Deliverables

- Deterministic monthly billing engine
- Bill generation UI
- Bulk bill generation

## Acceptance Criteria

- Same inputs always produce same bill.
- Historical bills remain unchanged when later configuration changes.
- Duplicate bills are prevented.

---

# 11. Phase 7 — Payments, Dues & Ledger Behavior

## Goal

Record payments reliably and maintain correct outstanding balances.

## Tasks

### 7.1 Define Payment Model

Fields:

- Payment ID
- Tenancy ID
- Tenant ID
- Date/time
- Amount
- Method
- Reference/note
- Created timestamp
- Reversal status

### 7.2 Payment Methods

Support locally recorded methods:

- Cash
- bKash
- Nagad
- Bank transfer
- Cheque
- Other

No online payment API is required.

### 7.3 Define Payment Allocation Model

Fields:

- Payment ID
- Bill ID
- Allocated amount

This allows one payment to cover multiple bills and preserves accounting traceability.

### 7.4 Payment Allocation Strategy

Default recommendation:

- Oldest outstanding bill first.

Allow user override only if business requirements require it.

### 7.5 Record Payment Use Case

Transaction should:

1. Validate payment amount.
2. Insert payment.
3. Allocate across outstanding bills.
4. Recalculate each affected bill balance/status.
5. Commit atomically.

### 7.6 Partial Payment

Example:

- Bill total: ৳19,510
- Payment: ৳10,000
- Remaining due: ৳9,510

Status becomes Partially Paid.

### 7.7 Overpayment Rule

Choose and implement one explicit policy.

Recommended MVP:

- Do not silently over-allocate.
- User may record excess as tenant advance/credit through a separate explicit action.

### 7.8 Payment Reversal

Implement controlled reversal:

- Preserve original payment.
- Record reversal state/event.
- Reverse allocations atomically.
- Recalculate affected bill balances.
- Require reason.

Avoid hard deletion of posted payment history.

### 7.9 Payment Entry UI

Show:

- Outstanding total
- Suggested amount
- Payment date
- Method
- Note/reference
- Post-payment remaining balance preview

### 7.10 Payment History UI

Filters:

- Tenant
- Property
- Unit
- Month/date range
- Payment method

### 7.11 Due Summary

Calculate:

- Current month due
- Previous overdue
- Total outstanding

### 7.12 Tests

Test:

- Full payment
- Partial payment
- Multi-bill payment
- Oldest-first allocation
- Reversal
- Zero amount rejection
- Overpayment rule
- Atomic rollback on failure

## Deliverables

- Payment posting
- Due tracking
- Payment history
- Safe reversal mechanism

---

# 12. Phase 8 — Security Deposit & Advance Management

## Goal

Track tenant funds separately from rent income and dues.

## Tasks

### 8.1 Deposit Account Model

Fields:

- Tenancy ID
- Deposit expected
- Current deposit balance
- Advance rent balance if separate

### 8.2 Deposit Transaction Types

Support:

- Deposit received
- Additional deposit
- Deposit refund
- Deposit deduction
- Transfer to due settlement
- Correction/reversal

### 8.3 Deposit Receipt Recording

- Record amount/date/method/reference.
- Keep deposit history distinct from rent payments.

### 8.4 Deposit Deduction

Possible reasons:

- Damage
- Unpaid rent
- Utility dues
- Other agreed deduction

Require reason/note.

### 8.5 Move-Out Settlement Calculation

Generate settlement summary:

```text
Outstanding rent/utilities
+ approved repair/damage charges
- tenant credits
- deposit applied
= final amount payable/refundable
```

### 8.6 Refund Workflow

- Calculate refundable amount.
- Record refund payment method.
- Finalize deposit balance.

### 8.7 Deposit History UI

Show ledger-style chronology.

### 8.8 Tests

Test:

- Deposit receipt
- Partial refund
- Full refund
- Deduction
- Transfer to outstanding due
- Move-out settlement

## Deliverables

- Deposit/advance ledger
- Move-out settlement support

---

# 13. Phase 9 — Receipt Generation, PDF & Sharing

## Goal

Generate professional Bengali/English rent receipts entirely offline.

## Tasks

### 9.1 Define Receipt Data Model/View Model

Receipt input should include snapshots of:

- Landlord/property information
- Tenant name
- Unit
- Billing month
- Charge breakdown
- Payment amount
- Remaining due
- Payment method
- Receipt number
- Payment date

### 9.2 Receipt Numbering Strategy

Generate unique local receipt number, for example:

```text
BV-2026-10-000123
```

Ensure restored backups do not create collisions.

### 9.3 Build English Receipt Template

Include:

- App/property header
- Tenant/unit details
- Month
- Itemized bill
- Paid amount
- Outstanding amount
- Payment method
- Date
- Optional landlord signature line

### 9.4 Build Bengali Receipt Template

Translate all fixed labels and ensure embedded Bengali font renders correctly.

### 9.5 PDF Generation Service

- Generate PDF in app-private temporary directory.
- Use embedded font asset.
- Avoid network dependency.
- Clean temporary files periodically.

### 9.6 Receipt Preview

Show preview before sharing/printing.

### 9.7 Native Share Sheet

Support sharing via installed apps such as:

- WhatsApp
- Messenger
- Email
- Bluetooth/file transfer

The app does not need direct integrations.

### 9.8 Save Receipt to Device

Where platform permissions allow:

- Export to selected location.
- Use safe filename.

### 9.9 Receipt Regeneration

Historical receipt must use historical bill/payment snapshot, not current rent configuration.

### 9.10 Optional Image Receipt

Post-MVP or if easy to include:

- Render shareable PNG/JPEG summary.

### 9.11 Receipt Tests

- PDF opens successfully.
- Bengali glyph rendering.
- Long tenant/property names.
- Large amounts.
- Partial payment receipt.
- Fully paid receipt.
- Remaining due receipt.

## Deliverables

- Offline PDF receipt generation
- Bengali and English templates
- Native sharing

---

# 14. Phase 10 — Repair & Expense Tracking

## Goal

Track landlord-side maintenance activity and relevant tenant chargebacks.

## Tasks

### 10.1 Repair Model

Fields:

- Property ID
- Unit ID optional
- Tenant/tenancy ID optional
- Title/category
- Description
- Reported date
- Completed date
- Cost
- Paid by landlord/tenant
- Recoverable from tenant flag
- Status
- Notes

### 10.2 Repair Categories

Examples:

- Plumbing
- Electrical
- Appliance
- Painting
- Structural
- Cleaning
- Other

### 10.3 Add Repair Workflow

- Select property/unit.
- Enter problem.
- Estimated/actual cost.
- Status.
- Optional attachment.

### 10.4 Repair Attachments

Store local file references for:

- Photos
- Scanned invoices

Copy imported files into application-controlled storage so source file removal does not break the record.

### 10.5 Tenant-Recoverable Repair Charge

If marked recoverable:

- Create explicit bill adjustment/charge.
- Do not automatically alter rent.

### 10.6 Repair List & Filters

Filter by:

- Property
- Unit
- Status
- Date
- Category

### 10.7 Expense Summary

Calculate property maintenance expense by month/date range.

### 10.8 Tests

- Repair CRUD
- Attachment storage
- Tenant charge linkage
- Archive/history preservation

## Deliverables

- Repair/maintenance tracking
- Basic landlord expense summaries

---

# 15. Phase 11 — Dashboard, Search & Reports

## Goal

Give landlords quick operational visibility without complex accounting software behavior.

## Tasks

### 11.1 Dashboard Query Service

Calculate efficiently:

- Total active properties
- Total units
- Occupied units
- Vacant units
- Current month expected amount
- Current month collected
- Current month outstanding
- Total overdue
- Recent payments

### 11.2 Home Dashboard UI

Sections:

- Current month summary
- Outstanding rent alert
- Recent payments
- Quick actions
- Properties/units overview

### 11.3 Quick Actions

Examples:

- Generate bill
- Record payment
- Add tenant
- Add repair
- Share receipt

### 11.4 Global Search

Search locally across:

- Tenant names
- Phone numbers
- Property names
- Unit numbers
- Receipt numbers

### 11.5 Monthly Collection Report

Show:

- Expected
- Collected
- Outstanding
- Collection percentage

### 11.6 Tenant Due Report

Show:

- Tenant
- Unit
- Oldest unpaid month
- Outstanding amount

### 11.7 Property Income Report

For selected period:

- Rent received
- Utility/service receipts
- Repair expenses
- Net operational cash view if desired

Clearly label this as an operational summary, not formal accounting/tax reporting unless later designed accordingly.

### 11.8 Payment Method Summary

Totals by:

- Cash
- bKash
- Nagad
- Bank
- Other

### 11.9 Export Report to CSV

Optional MVP feature:

- Monthly bills
- Payments
- Tenant list
- Due report

Ensure Bengali content uses UTF-8.

### 11.10 Reporting Performance

- Use database aggregation queries.
- Avoid loading all historical rows into Dart for totals.
- Add required indices.

### 11.11 Tests

Validate report totals against golden financial dataset.

## Deliverables

- Dashboard
- Search
- Core financial/operational reports

---

# 16. Phase 12 — Local Notifications & Reminders

## Goal

Provide reminders without any server or push-notification backend.

## Tasks

### 12.1 Notification Permission Flow

- Request permission only when useful.
- Explain why reminders are useful.

### 12.2 Reminder Types

Support locally scheduled reminders for:

- Monthly bill generation
- Rent due date
- Unpaid rent follow-up
- Custom landlord reminder

### 12.3 Reminder Settings

Allow:

- Enable/disable
- Day of month
- Time
- Reminder before/after due date

### 12.4 Notification Tap Navigation

Deep-link to relevant local screen, such as:

- Due tenant list
- Month billing screen

### 12.5 Rescheduling

Reschedule notifications after:

- App restart
- Device reboot where required
- Settings change

### 12.6 Tests

Test scheduling logic independent of OS plugin where possible.

## Deliverables

- Fully local reminders

---

# 17. Phase 13 — Backup, Restore & Data Export

## Goal

Protect user-owned offline data against device loss, accidental deletion, or migration to a new phone.

## Tasks

### 13.1 Define Backup Format

Recommended archive structure:

```text
bari_vara_backup.bvbackup
  manifest.json
  database.sqlite
  attachments/
  metadata/
```

### 13.2 Backup Manifest

Include:

- Backup format version
- App version
- Database schema version
- Creation timestamp
- Device/app metadata excluding unnecessary personal identifiers
- File hashes

### 13.3 Backup Creation Service

Steps:

1. Ensure database transaction consistency.
2. Checkpoint/copy database safely.
3. Copy attachments.
4. Create manifest.
5. Calculate checksums.
6. Create archive.
7. Return share/export path.

### 13.4 Manual Export

Allow user to save/share backup through native document/share interfaces.

This enables use with any storage provider installed on the device, such as:

- Google Drive
- OneDrive
- Dropbox

without making those providers mandatory app dependencies.

### 13.5 Optional Backup Encryption

Recommended:

- AES-GCM encrypted archive payload.
- User-selected backup password or device-protected key strategy.

If password-based encryption is implemented, use an appropriate password-based key derivation function.

### 13.6 Restore Validation

Before destructive restore:

- Read manifest.
- Validate format version.
- Validate checksums.
- Confirm database schema compatibility.
- Confirm sufficient storage.

### 13.7 Restore Safety Snapshot

Before replacing current database:

- Create automatic temporary safety backup.

### 13.8 Restore Process

Steps:

1. Close database.
2. Extract to temporary location.
3. Validate all files.
4. Run required migrations on restored copy if supported.
5. Replace active files atomically.
6. Reopen database.
7. Run health check.
8. Roll back to safety snapshot if restore fails.

### 13.9 Backup History Metadata

Store local records of:

- Last successful backup time
- Last restore time
- Backup version

Do not assume exported files remain accessible unless the user saved them externally.

### 13.10 CSV/Data Export

Provide optional exports for portability:

- Tenants
- Units
- Bills
- Payments
- Deposits
- Repairs

CSV export is for viewing/reporting, not necessarily full-fidelity restore.

### 13.11 Backup/Restore Tests

Test:

- Backup creation
- Restore to clean app
- Restore with attachments
- Corrupted archive rejection
- Unsupported version handling
- Failed restore rollback
- Bengali filenames/content

## Deliverables

- Reliable manual backup
- Reliable restore
- Portable exports

## Acceptance Criteria

A fresh installation must be able to restore an exported backup and reproduce the same financial balances and record counts.

---

# 18. Phase 14 — Security & Privacy

## Goal

Protect locally stored tenant and financial information without introducing unnecessary complexity.

## Tasks

### 14.1 App Lock Settings

Support:

- Disabled
- PIN lock
- Biometric unlock where available

### 14.2 PIN Security

- Never store plaintext PIN.
- Store a salted derived verifier/hash in secure storage.
- Implement retry throttling.

### 14.3 Biometric Integration

- Use biometrics only as a convenience unlock.
- Define fallback to PIN.
- Handle biometric enrollment changes.

### 14.4 App Background Privacy

Consider hiding sensitive screen previews in app switcher where platform APIs permit.

### 14.5 Secure File Handling

- Store database in application-private storage.
- Store imported tenant documents in app-private storage.
- Avoid leaving temporary receipt/backup files indefinitely.

### 14.6 Backup Security

- Clearly label whether backup is encrypted.
- Warn user if exporting an unencrypted backup containing tenant information.

### 14.7 Sensitive Data Deletion

For delete/archive actions:

- Prefer archive for financial/history records.
- Allow actual deletion only when safe and compliant with app behavior.

### 14.8 Privacy Screen

Explain locally:

- Data is stored on device.
- Core app does not require account/cloud backend.
- Sharing/export occurs only when user initiates it.

### 14.9 Security Tests

Test:

- App lock
- Wrong PIN retries
- Biometric fallback
- No plaintext PIN in preferences/database
- Restore behavior with lock settings

## Deliverables

- Optional app lock
- Secure local handling practices

---

# 19. Phase 15 — Common UI States & UX Hardening

## Goal

Ensure every screen behaves consistently in real-world conditions.

## Tasks

### 15.1 Loading States

Design reusable states for:

- Initial database load
- Report generation
- PDF generation
- Backup creation
- Restore

### 15.2 Empty States

Examples:

- No property
- No unit
- No tenant
- No bills this month
- No due
- No payment history
- No repairs

### 15.3 Error States

Create reusable UI for:

- Save failed
- Database error
- File export failed
- PDF generation failed
- Backup failed
- Restore failed
- Permission denied

### 15.4 Confirmations

Reusable confirmation sheets/dialogs for:

- Delete/archive
- Reverse payment
- Cancel bill
- Move out tenant
- Restore backup
- Discard unsaved changes

### 15.5 Form Components

Create shared components:

- Money input
- Phone input
- Date picker
- Month picker
- Property selector
- Unit selector
- Tenant selector
- Payment method selector
- Meter reading input

### 15.6 Accessibility

- Minimum tap target sizes.
- Semantic labels.
- Text scaling support.
- Avoid conveying financial states with color only.

### 15.7 Low-Literacy-Friendly UX

Because the target market includes small landlords with varied digital familiarity:

- Use simple Bengali labels.
- Prefer direct actions over hidden gestures.
- Avoid accounting jargon where possible.
- Show calculation breakdown before confirmation.

## Deliverables

- Shared production-ready component library
- Consistent application states

---

# 20. Phase 16 — Testing, Performance & Production Hardening

## Goal

Prove financial correctness, data durability, offline reliability, and release quality.

## Tasks

### 16.1 Unit Test Coverage

Priority areas:

- Money calculations
- Billing engine
- Previous due calculation
- Meter calculation
- Payment allocation
- Payment reversal
- Deposit ledger
- Move-out settlement
- Receipt numbering
- Backup manifest validation

### 16.2 Repository/Database Tests

Test:

- CRUD
- Joins
- Aggregations
- Transactions
- Foreign key rules
- Migration behavior

### 16.3 Widget Tests

Cover:

- Property form
- Tenant form
- Bill preview
- Payment form
- Receipt preview
- Backup confirmation

### 16.4 Integration Tests

Critical journeys:

#### Journey A — First-Time Setup

1. Launch app.
2. Select Bengali.
3. Create property.
4. Create unit.
5. Add tenant.
6. Create tenancy.

#### Journey B — Monthly Collection

1. Generate bill.
2. Enter electricity reading.
3. Finalize bill.
4. Record partial payment.
5. Record remaining payment.
6. Generate receipt.

#### Journey C — Due Carry-Forward

1. Generate prior-month bill.
2. Leave partially unpaid.
3. Generate next month.
4. Verify opening due.
5. Pay across multiple months.

#### Journey D — Move Out

1. Open tenant settlement.
2. Include remaining due.
3. Apply deposit.
4. Refund or collect difference.
5. Close tenancy.
6. Verify unit becomes vacant.

#### Journey E — Backup & Restore

1. Create years of sample data.
2. Export backup.
3. Reset/reinstall test environment.
4. Restore backup.
5. Compare balances and counts.

### 16.5 Migration Tests

Maintain golden database files for earlier schema versions.

Test upgrade from:

- v1 → v2
- v2 → v3
- etc.

### 16.6 Performance Dataset

Generate stress dataset larger than target use:

- 10 properties
- 100 units
- 10 years monthly bills
- Thousands of payments/line items

Ensure app remains responsive despite target users normally managing only 2–20 units.

### 16.7 Performance Profiling

Measure:

- Startup time
- Dashboard query time
- Bill generation time
- PDF generation time
- Backup time
- Restore time
- Memory usage

### 16.8 Offline Verification

Test entire MVP with:

- Airplane mode
- No SIM
- No Wi-Fi

No core screen should block on network availability.

### 16.9 Storage Failure Cases

Test:

- Low device storage
- Permission denial for export
- Corrupt attachment
- Interrupted export

### 16.10 Time/Date Edge Cases

Test:

- Month/year boundaries
- Leap year
- Device timezone change
- Manual date entry

### 16.11 Localization QA

Verify:

- Bengali text wrapping
- Fonts
- Currency symbols
- Bengali month labels
- Receipt rendering

### 16.12 Release Logging Review

Confirm release build does not expose:

- Tenant NID
- Phone numbers
- Full bill details
- Database paths unnecessarily

## Deliverables

- Regression suite
- Performance benchmarks
- Production-quality release candidate

---

# 21. Phase 17 — Android Release Preparation

## Tasks

### 17.1 Android App Identity

- Final package ID
- App name
- Versioning strategy

### 17.2 App Icon and Adaptive Icon

- Foreground asset
- Background asset
- Launcher icon verification across OEM launchers

### 17.3 Splash Screen

- Native Android splash setup
- Match app branding

### 17.4 Signing

- Create production keystore.
- Store securely outside source control.
- Configure signing.

### 17.5 Release Build

- Build Android App Bundle.
- Test release-mode database/PDF/share behavior.

### 17.6 Permission Review

Only request required permissions.

Prefer modern document picker/share mechanisms to broad storage permissions.

### 17.7 Play Store Metadata Preparation

- Bengali/English descriptions
- Screenshots
- Privacy disclosure
- Data safety statements consistent with actual implementation

---

# 22. Phase 18 — iOS Release Preparation

## Tasks

### 18.1 Bundle Configuration

- Bundle ID
- Display name
- Version/build numbers

### 18.2 App Icons

Create all App Store/iOS-required icon assets.

### 18.3 Launch Screen

Configure native iOS launch experience.

### 18.4 Entitlements and Permissions

Add only required usage descriptions for:

- Biometrics
- Photos/camera if repair attachments support capture
- Files/document picking where required

### 18.5 Signing & Provisioning

Configure:

- App Store certificate/profile
- Release build

### 18.6 TestFlight Validation

Test:

- Database migration
- Receipt PDF
- Native share sheet
- Backup export/import
- Biometrics
- Local notifications

---

# 23. Post-MVP / Advanced Technical Tasks

These features should be implemented only after the core offline financial workflow is stable.

## 23.1 Multiple Landlord Profiles

- Manage several owners/business profiles.
- Associate properties with owner.

## 23.2 Shared Utility Allocation

Examples:

- Split water bill by occupied units.
- Split common electricity by fixed ratio.
- Split building service charge.

## 23.3 Rent Increase Scheduler

- Schedule future rent changes.
- Notify landlord before effective month.

## 23.4 Tenant Documents

- Agreements
- NID images
- Utility agreements

Require careful backup and privacy handling.

## 23.5 Advanced Expense Categories

- Property tax
- Caretaker salary
- Cleaning
- Generator fuel
- Common electricity

## 23.6 Profit/Loss-Like Operational Summary

Provide simple cash-oriented reporting while avoiding unsupported accounting/tax claims.

## 23.7 Excel Export

Generate XLSX for landlords who want desktop review.

## 23.8 Direct Cloud Backup Integrations

Optional provider-specific backup:

- Google Drive
- OneDrive
- Dropbox

Core app should remain usable without account login or these integrations.

## 23.9 Device-to-Device Transfer

Possible future options:

- Export/import file
- Local network transfer
- QR-assisted pairing plus local transport

Do not introduce server dependency unless product direction changes.

## 23.10 OCR for Meter Reading

Optional camera-assisted reading capture. Always require user confirmation before billing.

---

# 24. Recommended Implementation Sequence Within Each Feature

For every new feature, follow this checklist:

1. Confirm business rules.
2. Update domain entities/value objects.
3. Add/change database schema.
4. Add migration.
5. Update repository interface.
6. Implement Drift repository/DAO.
7. Implement use case/application service.
8. Write domain/unit tests.
9. Add Riverpod providers/controllers.
10. Build UI.
11. Add form validation.
12. Add loading/empty/error states.
13. Add widget tests.
14. Add integration test path.
15. Verify Bengali UI.
16. Verify offline behavior.
17. Review logging/privacy.
18. Update documentation.

---

# 25. Suggested Sprint Breakdown

A practical MVP can be delivered in approximately **10–12 focused development sprints**, depending on team size and design readiness. The sprint numbering below describes sequence, not a fixed calendar duration.

## Sprint 1 — Foundation

- Project setup
- Architecture
- Drift database
- Core domain primitives
- Riverpod setup
- Localization foundation

## Sprint 2 — Properties & Units

- Property CRUD
- Unit CRUD
- Property/unit UI
- Tests

## Sprint 3 — Tenants & Tenancies

- Tenant CRUD
- Tenancy creation
- Occupancy rules
- Tenant details/history

## Sprint 4 — Charge Configuration

- Rent configuration
- Electricity configuration
- Gas/water/service charge
- Effective-date rules

## Sprint 5 — Billing Engine

- Monthly bill model
- Bill calculation
- Previous due logic
- Bill finalization
- Bill screens

## Sprint 6 — Payments & Dues

- Payment entry
- Payment allocation
- Partial payment
- Due calculations
- Reversal

## Sprint 7 — Deposits & Move-Out

- Security deposit ledger
- Advance tracking
- Move-out settlement

## Sprint 8 — Receipts & Sharing

- Bengali/English PDF
- Receipt numbering
- Preview/share/export

## Sprint 9 — Repairs, Dashboard & Reports

- Repairs
- Dashboard
- Due report
- Collection report
- Search

## Sprint 10 — Backup, Restore & Security

- Backup archive
- Restore
- CSV export
- PIN/biometric lock

## Sprint 11 — Notifications & UX Hardening

- Local reminders
- Shared UI states
- Accessibility
- Bengali UX review

## Sprint 12 — Production Hardening

- Integration tests
- Migration tests
- Performance tests
- Store builds
- Release QA

---

# 26. Critical Financial Rules to Lock Before Development Completion

The team must explicitly document and test these rules:

1. Whether rent is prorated for mid-month move-in/move-out.
2. How previous dues appear on a new bill without being double-counted.
3. How payments are allocated when several months are unpaid.
4. Whether overpayments become tenant credit/advance.
5. Whether posted payments can be edited or only reversed.
6. Whether finalized bills can be edited.
7. How corrected meter readings are handled after finalization.
8. How security deposit deductions are approved and recorded.
9. What happens to unpaid dues after move-out.
10. How receipt numbering behaves after backup restore.

Recommended defaults:

- No automatic proration in MVP unless explicitly selected by landlord.
- Oldest due paid first.
- Finalized financial records changed through adjustment/reversal, not silent mutation.
- Overpayment handled explicitly as tenant credit/advance.
- Historical bills remain immutable snapshots of the rules used at that time.

---

# 27. Definition of Done for a Feature

A feature is complete only when:

- Business rule is documented.
- Domain logic implemented.
- Database persistence implemented.
- Migration impact evaluated.
- Repository implemented.
- UI completed.
- English and Bengali labels completed.
- Validation completed.
- Loading/empty/error states completed.
- Unit tests pass.
- Widget/integration coverage added where appropriate.
- Offline mode verified.
- No sensitive logging introduced.
- Backup/restore impact reviewed.
- Historical data behavior verified.
- Code reviewed.

---

# 28. MVP Release Checklist

## Functional

- [ ] Property management
- [ ] Unit management
- [ ] Tenant management
- [ ] Tenancy management
- [ ] Rent configuration
- [ ] Electricity calculation
- [ ] Gas charge
- [ ] Water charge
- [ ] Service charge
- [ ] Previous due handling
- [ ] Monthly bill generation
- [ ] Partial/full payment
- [ ] Payment history
- [ ] Due tracking
- [ ] Deposit/advance tracking
- [ ] Bengali receipt
- [ ] English receipt
- [ ] PDF sharing
- [ ] Repair tracking
- [ ] Dashboard
- [ ] Basic reports
- [ ] Backup
- [ ] Restore
- [ ] Bengali/English settings

## Data Integrity

- [ ] No duplicate monthly bill
- [ ] No negative invalid payment
- [ ] No overlapping active tenancy
- [ ] Payments allocated transactionally
- [ ] Reversal preserves history
- [ ] Historical bill snapshots preserved
- [ ] Restore reproduces balances

## Offline

- [ ] App launches without network
- [ ] Bill generation works offline
- [ ] Payment works offline
- [ ] Receipt generation works offline
- [ ] Reports work offline
- [ ] Backup works offline
- [ ] Restore works offline

## Security

- [ ] Database stored privately
- [ ] PIN not stored in plaintext
- [ ] Biometric fallback tested
- [ ] Temporary files cleaned
- [ ] Release logs reviewed

## Localization

- [ ] Bengali screens reviewed
- [ ] English screens reviewed
- [ ] Bengali PDF reviewed
- [ ] Currency format reviewed
- [ ] Bengali months reviewed

## Release

- [ ] Android release build tested
- [ ] iOS release build tested
- [ ] Store icons/screenshots ready
- [ ] Privacy text accurate
- [ ] Migration test passed
- [ ] Backup/restore release test passed

---

# 29. Recommended Engineering Priorities

The project should prioritize these areas in this order:

1. **Financial correctness** — bills, payments, dues, deposits.
2. **Data durability** — migrations, transactions, backup, restore.
3. **Simple landlord workflow** — minimal taps for monthly rent collection.
4. **Bengali usability** — clear local terminology and reliable font rendering.
5. **Offline independence** — no hidden network dependency.
6. **Historical integrity** — old bills and receipts must remain trustworthy.
7. **Security/privacy** — tenant data stays under the landlord's control.
8. **Advanced convenience features** — only after core stability.

---

# 30. Final Technical Milestone

The first production release should be considered successful when a landlord can install **Bari Vara** on a phone, keep the device completely offline, manage multiple properties/units and tenants, generate monthly rent and utility bills, collect partial or full payments, track dues/deposits, share Bengali receipts, record repairs, view summaries, and safely back up/restore years of records without relying on any remote database or backend service.
