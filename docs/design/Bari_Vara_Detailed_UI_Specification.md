# Bari Vara — Detailed Mobile UI Specification

**Product:** Bari Vara — Landlord / Rent Manager  
**Platform:** Android and iOS mobile app  
**Market:** Bangladesh  
**Primary users:** Small landlords managing approximately 2–20 rental units  
**Operating model:** Fully offline; local database is the source of truth  
**Languages:** বাংলা and English  
**Document purpose:** Production-ready UI/UX specification for design and Flutter implementation

---

# 1. UI/UX Product Principles

## 1.1 Primary UX Goals

The interface should be designed for landlords who may not be highly technical. The experience must therefore prioritize:

- Simple navigation.
- Large, obvious primary actions.
- Minimal typing.
- Bengali-first readability.
- Clear money and due calculations.
- Strong confirmation before financial changes.
- Fast entry of monthly rent and utility information.
- Clear distinction between bill, payment, due, deposit, and credit.
- Offline confidence: users should never wonder whether a server connection is required.
- Safe financial history: finalized bills and posted payments should not silently change.

## 1.2 Design Tone

The visual tone should feel:

- Trustworthy.
- Calm.
- Practical.
- Financially clear.
- Local to Bangladesh without looking informal.
- Suitable for both younger and older landlords.

Avoid:

- Dense ERP-style interfaces.
- Excessive charts.
- Tiny controls.
- Technical accounting jargon unless explained.
- Hidden financial calculations.
- Destructive actions without confirmation.

---

# 2. Global Mobile Layout

## 2.1 Bottom Navigation

Use five primary destinations:

1. **Home / হোম**
2. **Tenants / ভাড়াটিয়া**
3. **Bills / বিল**
4. **Payments & Dues / পেমেন্ট ও বকেয়া**
5. **More / আরও**

### More Menu

The More screen exposes:

- Properties & Units
- Repairs
- Reports
- Receipts
- Backup & Restore
- Settings
- Help/About

## 2.2 Top App Bar

Standard app bar should support:

- Screen title.
- Back button when applicable.
- Search icon when useful.
- Filter icon where applicable.
- Overflow menu for secondary actions.
- Property selector when multiple properties exist.
- Month selector on month-sensitive screens.

## 2.3 Floating/Primary Action

Where a screen has one dominant creation action, use either:

- Extended FAB: `+ Add Tenant`
- Fixed bottom primary button: `Record Payment`
- Sticky footer for multi-step forms.

Avoid showing multiple equally prominent primary buttons.

---

# 3. Global Visual Language

## 3.1 Money

Always display Bangladeshi Taka consistently.

Examples:

- `৳15,000`
- `৳1,430`
- `৳0`
- `-৳500` for negative adjustments where required.

In Bengali numeral mode:

- `৳১৫,০০০`
- `৳১,৪৩০`

Financial totals should use stronger type hierarchy than labels.

## 3.2 Status Chips

Recommended statuses:

- **Paid / পরিশোধিত**
- **Partial / আংশিক**
- **Due / বকেয়া**
- **Draft / খসড়া**
- **Finalized / চূড়ান্ত**
- **Vacant / খালি**
- **Occupied / ভাড়ায় আছে**
- **Active / সক্রিয়**
- **Moved Out / চলে গেছেন**
- **Reversed / বাতিল**
- **Credit / অগ্রিম ব্যালেন্স**

Color must never be the only status indicator; always include text/icon.

## 3.3 Cards

Cards can be used for:

- Unit summaries.
- Tenant summaries.
- Bill summaries.
- Due summaries.
- Monthly collection KPIs.
- Recent activity.

Card information order:

1. Entity name/title.
2. Status.
3. Important amount/date.
4. Secondary details.
5. Contextual action.

## 3.4 Forms

Form conventions:

- Label above input.
- Optional fields explicitly marked optional.
- Numeric keyboard for money/meter reading.
- Date picker for dates.
- Dropdown/bottom sheet for enums.
- Inline validation below field.
- Preserve entered data on validation errors.
- Warn before leaving a dirty form.

---

# 4. Localization

## 4.1 Language Options

- বাংলা
- English

Language can be changed at any time without restarting setup.

## 4.2 Bengali Content Rules

Use familiar Bengali wording rather than literal accounting translations.

Examples:

- Rent → `ভাড়া`
- Previous due → `আগের বকেয়া`
- Security deposit → `জামানত`
- Service charge → `সার্ভিস চার্জ`
- Record payment → `পেমেন্ট নিন`
- Receipt → `রসিদ`
- Unit → `ইউনিট`
- Property → `বাড়ি / প্রপার্টি`

## 4.3 Number Preference

User may choose:

- English digits.
- Bengali digits.

Internal stored values remain numeric and locale-independent.

---

# 5. Accessibility and Usability

- Minimum touch target: approximately 44–48 dp.
- Body text should remain readable on smaller phones.
- Respect OS text scaling where practical.
- Do not encode due/paid states only with red/green.
- Use icons plus labels.
- Confirmation dialogs should describe financial impact.
- Support dark mode.
- Support reduced motion.
- Important receipts and totals must be screen-reader friendly.

---

# 6. Core Navigation Map

```text
Launch
 └─ Setup
    └─ Home

Home
 ├─ Monthly Summary
 ├─ Quick Actions
 └─ Recent Activity

Tenants
 ├─ Tenant List
 ├─ Tenant Details
 │  ├─ Rental Terms
 │  ├─ Deposit
 │  ├─ Documents
 │  ├─ Ledger
 │  └─ Move-Out
 └─ Add/Edit Tenant

Bills
 ├─ Monthly Dashboard
 ├─ Generate Bills
 ├─ Bill List
 └─ Bill Details
    ├─ Edit Draft
    ├─ Meter Reading
    ├─ Adjustment
    ├─ Previous Due
    └─ Finalize

Payments & Dues
 ├─ Payment List
 ├─ Record Payment
 ├─ Payment Details
 ├─ Due Summary
 └─ Due Details

More
 ├─ Properties & Units
 ├─ Repairs
 ├─ Reports
 ├─ Receipts
 ├─ Backup & Restore
 └─ Settings
```

---

# 7. A — Launch and Initial Setup

## Screen 1 — Splash

### Purpose

Provide immediate brand recognition while the app:

- Opens the local database.
- Runs migrations if required.
- Loads settings.
- Checks app-lock state.
- Determines whether onboarding is complete.

### UI

- Bari Vara logo.
- App name: `Bari Vara`.
- Optional Bangla subtitle: `বাড়ি ভাড়া ব্যবস্থাপনা`.
- Minimal progress indicator only if startup takes noticeable time.

### Navigation Logic

- First launch → Language Selection.
- Setup completed + app lock disabled → Home.
- Setup completed + lock enabled → Unlock screen.
- Database migration required → Database Upgrade state.

### Error Handling

If database cannot open:

- Show a clear local-data error.
- Actions: `Retry`, `Restore Backup` if possible.

---

## Screen 2 — Language Selection

### Purpose

Choose initial UI language.

### UI

Title:

`Choose your language / ভাষা নির্বাচন করুন`

Two large selectable cards:

- `বাংলা`
- `English`

Optional checkbox/toggle:

- Use Bengali digits / বাংলা সংখ্যা ব্যবহার করুন.

Primary button:

`Continue / চালিয়ে যান`

### Behavior

Preview selected language immediately.

---

## Screen 3 — Welcome

### Purpose

Explain the app in simple terms before setup.

### Content

Headline:

`Manage rent, bills and receipts — fully offline.`

Bengali equivalent.

Three benefit rows:

- Track tenants and rent.
- Calculate utilities and dues.
- Generate and share receipts.

Offline reassurance:

`Your rental data stays on this phone unless you export or back it up.`

Primary:

`Set Up My Property`

Secondary:

`Restore Existing Backup`

---

## Screen 4 — App Lock Setup

### Purpose

Offer local privacy protection.

### Controls

- Enable App Lock toggle.
- PIN setup.
- Confirm PIN.
- Use fingerprint/Face ID if device supports it.
- Auto-lock timing:
  - Immediately
  - After 1 minute
  - After 5 minutes
  - After 15 minutes

### Actions

Primary: `Save & Continue`  
Secondary: `Skip for Now`

### Validation

- PIN length requirement.
- PIN confirmation must match.

---

## Screen 5 — Create Property

### Purpose

Create the first landlord property.

### Fields

Required:

- Property name.

Optional:

- Property nickname.
- House/holding number.
- Road.
- Area.
- District/city.
- Postal code.
- Notes.

Optional owner details:

- Owner name.
- Phone number.

### Example

`Rahman Villa`

### Primary

`Save Property`

### Secondary

`I'll Add Details Later`

---

## Screen 6 — Add First Unit

### Purpose

Create at least one rentable unit.

### Fields

- Unit name/number.
- Floor.
- Monthly rent.
- Default service charge.
- Gas charging mode.
- Water charging mode.
- Electricity billing mode.
- Meter number if relevant.
- Notes.

### Electricity Billing Options

- Meter based.
- Fixed amount.
- Manual monthly amount.
- Included in rent.

### Primary

`Save Unit`

### Secondary

`Add Another Unit`

---

## Screen 7 — Add First Tenant

### Purpose

Optionally populate the first tenant during onboarding.

### Fields

- Tenant name.
- Mobile number.
- Unit.
- Move-in date.
- Monthly rent.
- Security deposit.
- Advance rent.
- Rent due day.
- Optional national ID/reference.
- Emergency/contact person.

### Actions

Primary: `Save Tenant`  
Secondary: `Skip — Add Later`

---

## Screen 8 — Setup Complete

### Purpose

Confirm that the app is ready.

### UI

Success illustration/icon.

Summary:

- Property created.
- Units created.
- Tenant count.
- Language.
- App lock status.

Primary:

`Go to Dashboard`

Secondary quick action:

`Add Another Unit`

---

# 8. B — Home

## Screen 9 — Dashboard

### Purpose

Give the landlord a quick monthly operational view.

### Header

- Property selector.
- Current month.
- Notification/reminder icon.

### KPI Cards

1. **Expected this month**
2. **Collected**
3. **Due**
4. **Occupied / Vacant**

### Main Sections

#### Collection Progress

Example:

`৳68,500 of ৳92,000 collected`

Progress bar.

#### Attention Needed

Cards for:

- Bills not generated.
- Rent overdue.
- Partial payments.
- Units missing meter reading.

#### Recent Payments

Show latest 3–5 entries:

- Tenant.
- Unit.
- Amount.
- Date.
- Receipt status.

#### Quick Actions

- Generate Bills
- Record Payment
- Add Tenant
- Add Meter Reading

### Empty First-Use State

When no tenant exists:

`Add your first tenant to start tracking rent.`

Primary: `Add Tenant`

---

## Screen 10 — Monthly Collection Summary

### Purpose

Detailed monthly financial summary.

### Header

Month selector.

### Summary

- Opening due.
- Current month rent.
- Utility charges.
- Adjustments.
- Total collectible.
- Collected.
- Remaining due.
- Credit balance if any.

### Breakdown

Expandable sections:

- Rent.
- Electricity.
- Gas.
- Water.
- Service charge.
- Repairs billed to tenant.
- Other charges.

### Unit/Tenant Status List

Each row:

- Tenant.
- Unit.
- Bill total.
- Paid.
- Due.
- Status chip.

### Actions

- View Bills
- Export Report

---

## Screen 11 — Quick Actions

### Purpose

One-tap access to common workflows.

### Grid/List

- `Generate Monthly Bills`
- `Record Payment`
- `Add Tenant`
- `Add Unit`
- `Enter Meter Reading`
- `Add Repair`
- `View Dues`
- `Create Backup`

May open as a full screen or bottom sheet from Home.

---

# 9. C — Properties and Units

## Screen 12 — Property List

### Purpose

Manage one or multiple properties.

### Property Card

- Property name.
- Address summary.
- Occupied units.
- Vacant units.
- Current month due.
- Optional monthly collection indicator.

### Actions

Primary FAB: `+ Add Property`

Card tap → Property Details.

### Filters

- All.
- Has vacancy.
- Has due.

### Empty State

`No property has been added yet.`

---

## Screen 13 — Property Details

### Header

- Property name.
- Edit icon.
- Overflow menu.

### Summary

- Total units.
- Occupied.
- Vacant.
- Active tenants.
- Current due.

### Tabs/Sections

1. Units
2. Financial snapshot
3. Repairs
4. Property information

### Actions

- Add Unit.
- View Reports.
- Edit Property.
- Archive Property.

---

## Screen 14 — Add/Edit Property

### Fields

- Property name.
- Owner display name.
- Phone.
- Holding/house.
- Road.
- Area.
- City/district.
- Postal code.
- Notes.

### Advanced Optional Fields

- Default rent due day.
- Default service charge.
- Receipt header text.

### Footer

Primary: `Save`  
Secondary: `Cancel`

Archive only available when editing.

---

## Screen 15 — Unit List

### Header

Property selector.

### Filter Chips

- All
- Occupied
- Vacant
- Has Due

### Unit Row/Card

- Unit number/name.
- Floor.
- Occupancy status.
- Current tenant or `Vacant`.
- Monthly rent.
- Current due if occupied.
- Meter icon if meter-based electricity.

### Actions

FAB: `+ Add Unit`

---

## Screen 16 — Unit Details

### Header

Unit name and occupancy chip.

### Sections

#### Current Rental

If occupied:

- Tenant.
- Move-in date.
- Monthly rent.
- Due day.
- Current due.

If vacant:

- Vacant since.
- Last tenant.

#### Charge Setup

- Electricity mode.
- Gas.
- Water.
- Service charge.

#### Meter

- Meter number.
- Last reading.
- Last reading date.

#### History

- Past tenants.
- Repairs.
- Rent changes.

### Actions

- Edit Unit.
- View Tenant.
- Enter Meter Reading.
- Mark Vacant / Assign Tenant.

---

## Screen 17 — Add/Edit Unit

### Fields

Required:

- Unit name/number.
- Property.
- Monthly base rent.

Optional:

- Floor.
- Bedroom note.
- Meter number.
- Service charge.
- Gas amount.
- Water amount.
- Notes.

### Electricity Configuration

Radio selection:

- Meter based.
- Fixed.
- Manual monthly.
- Included in rent.

For meter based:

- Rate per unit.
- Initial/current meter reading.

### Validation

- Unit name unique within property.
- Money values cannot be negative.
- Meter rate must be greater than zero when required.

---

## Screen 18 — Vacancy Details

### Purpose

Show vacancy state and help prepare a unit for a new tenant.

### UI

- Unit.
- Vacant since.
- Last tenant.
- Last rent.
- Last meter reading.
- Outstanding repair items.
- Deposit settlement status from previous tenant.

### Actions

Primary: `Add New Tenant`

Secondary:

- Edit Unit.
- Add Repair.
- View Previous Tenant.

---

# 10. D — Tenants

## Screen 19 — Tenant List

### Search

Search by:

- Tenant name.
- Mobile number.
- Unit.

### Filter Chips

- Active.
- Due.
- Paid.
- Moving out.
- Former tenants.

### Tenant Row

- Name.
- Unit.
- Phone.
- Current month bill status.
- Due amount.
- Small overdue indicator when applicable.

### Actions

FAB: `+ Add Tenant`

Long press or overflow:

- Call.
- View ledger.
- Record payment.

---

## Screen 20 — Tenant Details

### Header

- Tenant name.
- Unit.
- Active/Former chip.
- Edit.

### Summary Card

- Current bill.
- Paid.
- Due.
- Deposit held.
- Credit balance.

### Quick Actions

- Record Payment.
- View Bill.
- Create Receipt.
- Call Tenant.

### Sections

#### Contact

- Phone.
- Alternate phone.
- Emergency/contact person.

#### Rental

- Property/unit.
- Move-in date.
- Monthly rent.
- Due day.

#### Financial

- Security deposit.
- Advance rent.
- Current due.
- Tenant credit.

#### History

- Recent bills.
- Payments.
- Repairs charged.
- Notes.

### More Actions

- Rental Terms.
- Documents.
- Ledger.
- Move Out.

---

## Screen 21 — Add Tenant

### Step 1 — Basic Information

- Full name.
- Phone number.
- Alternate phone.
- NID/reference number optional.
- Address/home district optional.
- Emergency contact.

### Step 2 — Unit & Tenancy

- Property.
- Unit.
- Move-in date.
- Rent amount.
- Rent due day.

### Step 3 — Deposit & Advance

- Security deposit.
- Advance rent.
- Payment received date.
- Note.

### Step 4 — Utility Setup Confirmation

Review inherited unit defaults.

### Footer

`Save Tenant`

Option:

`Save & Create First Bill`

---

## Screen 22 — Edit Tenant

Same main fields as Add Tenant, but financial-history-sensitive data needs special handling.

### Editable Directly

- Name.
- Phone.
- Notes.
- Contact person.
- Documents.

### Historical Caution

Changes to:

- Rent.
- Unit.
- Deposit.
- tenancy dates

should route to dedicated domain workflows rather than rewrite finalized history.

### Warning

`Changes to current rent apply going forward and do not alter finalized bills.`

---

## Screen 23 — Rental Terms

### Purpose

Display/edit the current rental agreement snapshot.

### Fields

- Rent amount.
- Effective from.
- Due day.
- Security deposit agreed.
- Advance rent.
- Electricity mode/rate.
- Gas charge.
- Water charge.
- Service charge.
- Notice period.
- Additional notes.

### History

Show prior rent/rental term versions.

### Action

`Update Terms`

When rent changes:

- Ask effective month.
- Show impact preview.

---

## Screen 24 — Deposit Details

### Summary

- Original deposit.
- Additional deposit.
- Deposit deductions.
- Refunds.
- Current deposit balance.

### Transaction Timeline

Each entry:

- Date.
- Type.
- Amount.
- Note.

### Actions

- Add Deposit.
- Record Refund.
- Record Deduction.
- View Move-Out Settlement.

### Confirmation

Deposit deduction must require:

- Amount.
- Reason.
- Confirmation.

---

## Screen 25 — Tenant Documents

### Purpose

Store local-only document images/files.

### Categories

- NID.
- Agreement.
- Photo.
- Utility document.
- Other.

### Item

- Thumbnail/icon.
- Name.
- Date added.
- File size.
- Category.

### Actions

- Camera/photo picker.
- File picker.
- Rename.
- Delete.
- View.

### Privacy

Show note:

`Documents are stored locally on this device and are included in backups when attachments are selected.`

---

## Screen 26 — Tenant Ledger

### Purpose

Chronological account history.

### Header Summary

- Opening balance.
- Total billed.
- Total paid.
- Credit.
- Current balance.

### Timeline/Table Rows

- Date.
- Description.
- Debit.
- Credit.
- Running balance.

Examples:

- October rent bill.
- Payment.
- Repair charge.
- Payment reversal.
- Deposit is shown separately unless accounting rules intentionally include it.

### Filters

- Date range.
- Bill.
- Payment.
- Adjustment.

### Actions

- Export PDF.
- Export CSV.

---

## Screen 27 — Move-Out

### Purpose

Start tenant move-out workflow.

### Fields

- Move-out date.
- Final meter reading.
- Notice note.
- Outstanding repair charges.
- Other deductions.

### Pre-Move-Out Summary

- Unpaid rent/bills.
- Deposit held.
- Tenant credit.
- Draft final charges.

### Primary

`Review Settlement`

No tenancy data is finalized yet.

---

## Screen 28 — Move-Out Settlement

### Purpose

Calculate final tenant balance.

### Breakdown

- Outstanding bills.
- Final utility charges.
- Repair deductions.
- Other deductions.
- Deposit available.
- Tenant credit.
- Refund due OR final amount due.

### Example

```text
Outstanding dues       ৳3,000
Final electricity      ৳1,120
Repair deduction       ৳800
Total payable          ৳4,920
Deposit held           ৳10,000
Refund to tenant       ৳5,080
```

### Actions

- Edit Charges.
- Confirm Move-Out.
- Generate Settlement PDF.
- Record Deposit Refund.

### Final Confirmation

Explain:

- Tenant becomes former.
- Unit becomes vacant.
- Settlement history is retained.

---

# 11. E — Bills

## Screen 29 — Monthly Bill Dashboard

### Header

Month selector.

### Summary Cards

- Units expected.
- Bills finalized.
- Draft bills.
- Missing bills.
- Total billed.
- Total due.

### Action Areas

- Generate Bills.
- Enter Meter Readings.
- Review Drafts.

### List

Per unit:

- Tenant.
- Unit.
- Bill amount.
- Status.
- Paid/Due.

---

## Screen 30 — Month Selector

### Purpose

Reusable billing-period picker.

### UI

- Current month prominent.
- Previous/next arrows.
- Month grid or wheel.
- Optional Bengali month display only as a secondary label if desired; accounting period remains Gregorian month/year.

### Rules

- Future month generation may require confirmation.
- Very old months display archived/finalized context.

---

## Screen 31 — Generate Bills

### Purpose

Bulk bill-generation workflow.

### Step 1 — Choose Month

Selected month.

### Step 2 — Choose Tenancies

Checkbox list:

- Tenant.
- Unit.
- Base rent.
- Status.

Filter:

- Missing bill only.
- All active tenants.

### Step 3 — Missing Inputs

Highlight:

- Missing meter readings.
- Manual electricity amount needed.
- Custom utility amount missing.

Actions:

- Enter now.
- Use previous/default where allowed.
- Skip tenant.

### Step 4 — Preview

For each tenant:

- Rent.
- Utilities.
- Service charge.
- Previous due.
- Adjustments.
- Total.

### Primary

`Generate Draft Bills`

Optional:

`Generate & Finalize` only if business rules allow and user confirms.

---

## Screen 32 — Bill List

### Header

Month selector.

### Filters

- All.
- Draft.
- Finalized.
- Paid.
- Partial.
- Due.

### Bill Row

- Tenant.
- Unit.
- Bill number/reference.
- Total.
- Paid.
- Due.
- Status.

### Search

Tenant/unit.

---

## Screen 33 — Bill Details

### Header

- Month.
- Tenant.
- Unit.
- Bill status.

### Breakdown

Example:

```text
Rent                 ৳15,000
Electricity           ৳1,430
Gas                   ৳1,080
Water                   ৳500
Service charge          ৳500
Previous due          ৳2,000
--------------------------------
Total                ৳20,510
Paid                  ৳5,000
Remaining            ৳15,510
```

### Metadata

- Bill created date.
- Finalized date.
- Previous due source.
- Meter readings used.

### Actions

For draft:

- Edit.
- Finalize.
- Delete draft.

For finalized:

- Record Payment.
- Create/View Receipt.
- View Audit History.

### Rule

Finalized financial components are read-only.

---

## Screen 34 — Edit Draft Bill

### Fields

Editable bill items:

- Rent.
- Electricity.
- Gas.
- Water.
- Service charge.
- Repair charge.
- Other charge.
- Discount.
- Notes.

Previous due is system-derived and should not be manually overwritten without an explicit adjustment workflow.

### Bottom Summary

- Subtotal.
- Previous due.
- Total.

### Actions

`Save Draft`  
`Save & Finalize`

---

## Screen 35 — Electricity Reading Entry

### Header

Month + Unit/Tenant.

### Meter-Based Fields

- Meter number.
- Previous reading.
- Previous reading date.
- Current reading.
- Reading date.
- Rate per unit.

### Auto Calculation

```text
Units consumed = Current - Previous
Electricity amount = Units consumed × Rate
```

Display immediately.

### Optional

- Attach meter photo.
- Note.

### Validation

Current reading cannot be below previous reading unless:

- Meter was replaced/reset.
- User selects `Meter Changed`.

---

## Screen 36 — Add Adjustment

### Types

- Additional charge.
- Discount.
- Correction.
- Repair charge.
- Other.

### Fields

- Type.
- Label.
- Amount.
- Note.

### Preview

Show how total changes.

### Confirmation

For finalized bills, do not silently edit. Create a separate adjustment transaction or next-bill adjustment depending on accounting rules.

---

## Screen 37 — Finalize Bill

### Purpose

Dedicated confirmation screen/bottom sheet.

### Summary

- Tenant.
- Month.
- Bill total.
- Previous due.
- Number of bill items.

### Warning

`After finalizing, bill amounts cannot be directly edited. Corrections must be recorded separately.`

### Actions

Primary: `Finalize Bill`  
Secondary: `Review Again`

Option:

- Generate receipt only after payment, not bill finalization.

---

## Screen 38 — Previous Due Breakdown

### Purpose

Make carried-forward dues transparent.

### Summary

`Previous Due: ৳2,000`

### Breakdown by source

- September 2026 bill — remaining ৳1,500.
- August adjustment — ৳500.

### Actions

- Open source bill.
- Open payment history.

No direct editing.

---

# 12. F — Payments

## Screen 39 — Payment List

### Header

Property + date/month filter.

### Summary

- Total received this month.
- Number of payments.

### Payment Row

- Tenant.
- Unit.
- Amount.
- Date.
- Payment method.
- Receipt number.
- Reversed indicator if applicable.

### Filters

- Cash.
- Bank.
- Mobile financial service.
- Other.
- Reversed.

### Search

Tenant, unit, receipt.

---

## Screen 40 — Record Payment

### Step 1 — Tenant

Select:

- Tenant.
- Unit.

Show balance:

- Total due.
- Tenant credit.

### Step 2 — Payment

Fields:

- Amount.
- Payment date.
- Payment method.
- Transaction/reference ID optional.
- Note.

Methods:

- Cash.
- bKash.
- Nagad.
- Rocket.
- Bank transfer.
- Cheque.
- Other.

### Step 3 — Allocation Preview

Default allocation:

Oldest eligible due first.

Show:

- Bill/month.
- Due before.
- Applied amount.
- Remaining.

### Actions

Primary: `Record Payment`

After success:

- View Receipt.
- Share Receipt.
- Done.

---

## Screen 41 — Partial Payment

### Purpose

Explicitly explain impact when amount is below balance.

### Example

```text
Total due       ৳19,510
Payment          ৳8,000
Remaining       ৳11,510
```

### Allocation

Show which bill items/months are covered according to allocation logic.

### Confirmation

`Record ৳8,000 as partial payment`

---

## Screen 42 — Payment Details

### Header

Payment amount + status.

### Information

- Tenant.
- Unit.
- Date.
- Payment method.
- Reference.
- Receipt number.
- Note.

### Allocation

List all bills/months receiving this payment.

### Actions

- View Receipt.
- Share Receipt.
- Reverse Payment.

If reversed:

- Show reversal date/reason.
- Disable reverse again.

---

## Screen 43 — Reverse Payment

### Purpose

Financial correction workflow.

### Show

- Original amount.
- Tenant.
- Date.
- Affected bills.
- Current balances after reversal preview.

### Required

- Reversal reason.

### Warning

`This does not delete the original payment. A reversal record will be created and affected dues will be reopened.`

### Primary

`Confirm Reversal`

Require PIN/biometric optionally for sensitive actions.

---

## Screen 44 — Tenant Credit

### Purpose

Display overpayment / credit balance.

### Summary

- Current credit.
- Credit origin.
- Amount already used.

### Timeline

- Overpayment created.
- Credit applied to later bill.
- Manual correction if supported.

### Actions

- Apply Credit to Eligible Bill.
- Refund Credit if supported.
- View Ledger.

---

# 13. G — Receipts

## Screen 45 — Receipt Preview

### Purpose

Preview exact receipt before sharing/exporting.

### Header

- Property name.
- Receipt number.
- Date.

### Tenant Information

- Tenant.
- Unit.
- Payment month/reference.

### Breakdown

- Payment amount.
- Applied bills.
- Payment method.
- Remaining due.

### Footer

- Landlord/manager name.
- Optional phone.
- `Generated by Bari Vara`.

### Actions

- Share.
- Save PDF.
- Print if supported.
- Switch language.

---

## Screen 46 — Bengali Receipt

### Example Content

```text
ভাড়া পরিশোধের রসিদ

রসিদ নং: BV-2026-00125
তারিখ: ০৫ অক্টোবর ২০২৬

ভাড়াটিয়া: মোঃ করিম
ইউনিট: 3B

অক্টোবর ২০২৬

ভাড়া                 ৳১৫,০০০
বিদ্যুৎ                ৳১,৪৩০
গ্যাস                  ৳১,০৮০
আগের বকেয়া             ৳২,০০০
--------------------------------
মোট                  ৳১৯,৫১০

পরিশোধ               ৳১৯,৫১০
বর্তমান বকেয়া                ৳০
```

### Requirements

- Correct Bengali font embedding in PDF.
- No text clipping.
- Taka symbol supported.
- Proper Bengali digit rendering when enabled.

---

## Screen 47 — English Receipt

Same data as Bengali receipt with English labels.

### Example Labels

- Rent.
- Electricity.
- Gas.
- Previous due.
- Total.
- Paid.
- Remaining due.

---

## Screen 48 — Share Receipt

### Purpose

Prepare receipt output.

### Options

- Share PDF.
- Share image if supported.
- Save to Files.
- Copy short text summary.

### Suggested Text

`Rent payment receipt for October 2026 — ৳19,510 received.`

### Native Share Sheet

Use platform share sheet. App should not require network; destination apps may require network independently.

---

## Screen 49 — Receipt History

### Search

- Receipt number.
- Tenant.
- Unit.

### Filters

- Month.
- Tenant.
- Payment method.

### Receipt Row

- Receipt number.
- Tenant.
- Date.
- Amount.
- Language/template indicator optional.

Tap → receipt preview.

---

# 14. H — Dues

## Screen 50 — Due Summary

### Header

Month/property selector.

### KPI Cards

- Total outstanding.
- Number of tenants with due.
- Overdue from previous months.
- Current-month unpaid.

### Distribution

Simple categories:

- Current month.
- 1 month old.
- 2+ months old.

### Actions

- View Tenants.
- Export Due Report.

---

## Screen 51 — Due Tenant List

### Sort

- Highest due.
- Oldest due.
- Tenant name.
- Unit.

### Tenant Row

- Name.
- Unit.
- Total due.
- Oldest unpaid month.
- Current status.

### Quick Actions

- Record Payment.
- Call Tenant.
- View Due Details.

---

## Screen 52 — Due Details

### Header

Tenant + total due.

### Breakdown by Month

Each expandable month:

- Bill total.
- Paid.
- Remaining.
- Bill date.

### Other Balances

- Tenant credit.
- Deposit shown separately and never automatically netted unless settlement workflow.

### Actions

- Record Payment.
- View Ledger.
- View Bill.

---

## Screen 53 — Monthly Due Breakdown

### Purpose

Explain how outstanding balance evolved.

### Rows

- Billing month.
- Opening due.
- New charges.
- Payments.
- Closing due.

### Footer

Current total due.

Can be exported.

---

# 15. I — Repairs

## Screen 54 — Repair List

### Filters

- Open.
- Completed.
- Tenant responsible.
- Landlord responsible.
- Property/unit.

### Repair Card

- Title/category.
- Unit.
- Reported date.
- Status.
- Cost.
- Responsibility.

### FAB

`+ Add Repair`

---

## Screen 55 — Repair Details

### Sections

- Problem.
- Property/unit.
- Reported date.
- Completed date.
- Responsibility.
- Cost.
- Vendor/worker optional.
- Notes.
- Attachments/photos.

### Billing Link

If tenant responsible:

- `Added to bill: October 2026`
or
- `Not yet billed`

### Actions

- Edit.
- Mark Complete.
- Add Cost to Bill.
- Add Photo.

---

## Screen 56 — Add Repair

### Fields

- Property.
- Unit.
- Tenant optional.
- Category.
- Description.
- Reported date.
- Responsibility.
- Estimated/actual cost.
- Vendor/technician optional.
- Notes.
- Photos optional.

### Categories

- Plumbing.
- Electrical.
- Appliance.
- Door/lock.
- Paint.
- Structure.
- Cleaning.
- Other.

### Primary

`Save Repair`

---

## Screen 57 — Add Repair Cost to Bill

### Purpose

Create a tenant charge from an eligible repair.

### Show

- Repair.
- Cost.
- Tenant.
- Responsibility.

### Fields

- Amount to charge.
- Billing month.
- Bill-item label.
- Note.

### Rules

If target bill is draft:

- Add directly as a draft line item.

If finalized:

- Create adjustment/next eligible bill item, not silent modification.

### Primary

`Add Charge`

---

# 16. J — Reports

## Screen 58 — Reports Home

### Report Cards

- Monthly Collection.
- Tenant Ledger.
- Deposit Report.
- Repair Expense.
- Vacancy.
- Property Income Summary.
- Due Report.

Each card includes:

- Icon.
- One-line description.
- Last selected period if helpful.

---

## Screen 59 — Monthly Collection Report

### Filters

- Property.
- Month.

### Summary

- Expected.
- Billed.
- Collected.
- Remaining due.
- Collection percentage.

### Breakdown

Per tenant/unit:

- Bill.
- Paid.
- Due.

### Actions

- Export PDF.
- Export CSV.
- Share.

---

## Screen 60 — Tenant Ledger Report

### Filters

- Tenant.
- Date range.

### Summary

- Opening balance.
- Charges.
- Payments.
- Closing balance.

### Transaction table

Chronological ledger.

### Actions

PDF / CSV.

---

## Screen 61 — Deposit Report

### Summary

- Total deposits held.
- Deposits received.
- Refunds.
- Deductions.

### Rows

- Tenant.
- Unit.
- Deposit received.
- Adjustments.
- Current held amount.

### Filter

Active/former tenants.

---

## Screen 62 — Repair Report

### Filters

- Date range.
- Property.
- Unit.
- Responsibility.
- Category.

### Summary

- Total repair expense.
- Tenant recoverable.
- Landlord responsibility.
- Completed/open counts.

### Rows

Repair details and cost.

---

## Screen 63 — Vacancy Report

### Summary

- Total units.
- Occupied.
- Vacant.
- Vacancy rate.
- Estimated monthly rent opportunity.

### Rows

- Unit.
- Vacant since.
- Last rent.
- Days/months vacant.
- Last tenant.

---

# 17. K — Backup, Export and Settings

## Screen 64 — Backup & Restore

### Purpose

Central data-safety screen.

### Top Status

- Last backup date/time.
- Backup location if known.
- Database size.
- Attachment size.

### Actions

- Create Backup.
- Restore Backup.
- Export Data.
- Backup Settings.

### Safety Message

`Bari Vara stores your data on this device. Regular backups are strongly recommended.`

---

## Screen 65 — Create Backup

### Options

- Include attachments.
- Encrypt backup with password.
- Backup filename preview.

### Estimated Size

Display approximate backup size.

### Destination

Use system file picker/share flow:

- Device storage.
- Google Drive, OneDrive, Dropbox etc. through OS/provider integration if available.

The app itself remains fully offline.

### Primary

`Create Backup`

### Success

Show:

- Filename.
- Created date.
- Size.
- Share/Save action.

---

## Screen 66 — Restore Backup

### Step 1

Choose backup file.

### Step 2 — Validation

Display:

- Backup version.
- Created date.
- Properties.
- Tenants.
- Attachments.
- Encryption state.

### Step 3 — Warning

`Restoring replaces the current local database.`

Recommend:

`Create a safety backup of current data first.`

### Actions

- Create Safety Backup.
- Continue Restore.

If encrypted, request password.

---

## Screen 67 — Export Data

### Export Types

- Monthly Collection CSV.
- Tenant Ledger CSV.
- Due Report CSV.
- Tenant List CSV.
- Receipt PDF.
- Report PDF.
- Full structured export where supported.

### Filters

Context-specific filters appear after type is selected.

### Destination

Native file save/share sheet.

---

## Screen 68 — Settings Home

### Sections

#### General

- Language.
- Bengali/English digits.
- Date display.
- Default property.

#### Billing

- Billing defaults.
- Utility defaults.
- Payment allocation.

#### Receipt

- Receipt header.
- Owner name.
- Footer.
- Default receipt language.

#### Notifications

- Rent due reminders.
- Backup reminder.

#### Security

- App lock.
- Biometrics.
- Screenshot protection.

#### Appearance

- Theme.
- Text size.

#### Data

- Backup & Restore.
- Export.
- Storage usage.

#### About

- App version.
- Privacy.
- Help.

---

## Screen 69 — Language Settings

### Controls

- বাংলা.
- English.
- Digit style:
  - বাংলা digits.
  - English digits.

### Preview

Show a sample financial line:

`অক্টোবর ২০২৬ — মোট ৳১৯,৫১০`

Changes apply immediately.

---

## Screen 70 — Billing Settings

### Global Defaults

- Default rent due day.
- Service charge.
- Gas charge.
- Water charge.
- Electricity rate.
- Bill creation behavior.
- Default payment allocation method.

### Options

- Automatically include previous due.
- Confirm before carrying credit.
- Show zero-value line items.
- Default bill language.

### Warning

Changing defaults does not alter finalized historical bills.

---

## Screen 71 — Receipt Settings

### Fields

- Receipt title.
- Owner/manager name.
- Phone.
- Property address.
- Footer message.
- Default language.
- Show payment method.
- Show remaining due.
- Show signature line.

### Preview

Live receipt preview.

---

## Screen 72 — Notification Settings

### Local Reminder Toggles

- Rent due reminder.
- Unpaid rent reminder.
- Backup reminder.

### Rent Due Reminder

- Days before due.
- Due-day reminder.
- Days after due.

### Important

Display:

`Reminders are scheduled on this phone and do not require a server.`

Request notification permission only when enabling a reminder.

---

## Screen 73 — Security Settings

### Controls

- App lock.
- Change PIN.
- Use biometrics.
- Auto-lock duration.
- Screenshot protection.
- Lock when app goes to background.

### Sensitive Actions Option

Require PIN/biometric for:

- Payment reversal.
- Restore backup.
- Delete/Archive property.
- Deposit deduction.

---

## Screen 74 — Appearance Settings

### Theme

- Light.
- Dark.
- System.

### Text

- Standard.
- Large.

### Accessibility

- Reduce motion.
- Higher contrast option if implemented.

### Preview

Small card preview.

---

# 18. L — Common UI States

## Screen/State 75 — Empty State

### Structure

- Contextual icon/illustration.
- Clear title.
- One sentence explaining what is empty.
- One primary action.

Examples:

Tenant list:

`No tenants yet.`  
`Add a tenant to start tracking rent and payments.`  
`Add Tenant`

Bills:

`No bills for October 2026.`  
`Generate bills for active tenants.`

---

## Screen/State 76 — No Search Results

### Show

- Search term.
- Applied filter summary.
- Clear Filters.
- Clear Search.

Example:

`No tenant found for "Karim".`

Avoid presenting this as an error.

---

## Screen/State 77 — Save Success

Use a short snackbar/toast or inline confirmation.

Examples:

- `Tenant saved.`
- `Payment recorded.`
- `Bill finalized.`

For major financial actions, navigate to resulting detail screen instead of relying only on a toast.

---

## Screen/State 78 — Save Failure

### Content

- Human-readable message.
- Preserve entered form values.
- Retry.

Example:

`Could not save the payment. Your entered information is still here.`

If caused by storage/database issue, provide appropriate recovery guidance.

---

## Screen/State 79 — Delete Confirmation

### Structure

- Entity name.
- Impact.
- Primary destructive action.
- Cancel.

Where financial history exists, prefer Archive rather than Delete.

Example:

`Archive Rahman Villa? Historical bills and payments will remain available.`

---

## Screen/State 80 — Unsaved Changes

### Message

`You have unsaved changes.`

Actions:

- `Keep Editing`
- `Discard Changes`

Never discard automatically.

---

## Screen/State 81 — Finalized Bill Warning

### Message

`This bill is finalized and its financial values are locked.`

Actions may include:

- View details.
- Add correction/adjustment.
- Record payment.

Do not show an ordinary Edit button.

---

## Screen/State 82 — Backup Failure

### Show

- Backup failed.
- Whether current app data is unaffected.
- Likely actionable reason if known:
  - not enough storage;
  - selected destination unavailable;
  - permission denied;
  - encryption error.

Actions:

- Retry.
- Choose Another Location.

---

## Screen/State 83 — Restore Confirmation

### High-Risk Confirmation

Show:

- Backup date.
- Current data summary.
- Backup data summary.
- Clear replacement warning.

Require explicit confirmation, optionally PIN/biometric.

Recommended checkbox:

`I understand that current local data will be replaced.`

---

## Screen/State 84 — Storage Almost Full

### Show

- App data size.
- Attachments size.
- Device free space when available.

Actions:

- Manage Attachments.
- Create Backup.
- Export Old Files.

Do not suggest deleting financial records casually.

---

## Screen/State 85 — Database Upgrade

### Purpose

Shown during local schema migration.

### UI

`Updating your local data...`

Rules:

- Do not allow normal navigation during migration.
- Keep device awake if necessary.
- Do not show fake percentage unless real progress is available.

### Failure

Provide:

- Retry.
- Restore Backup.
- Diagnostic reference/code if useful.

---

# 19. App Lock / Unlock Screen

Although app-lock setup is part of onboarding, the runtime unlock screen is a required operational screen.

## Layout

- Bari Vara logo.
- `Enter PIN`.
- Numeric keypad.
- `Use fingerprint/Face ID`.
- Forgotten PIN guidance.

## Forgotten PIN

Because the app is offline, recovery must not imply server-based reset.

Possible product rule:

- Restore from an encrypted backup after local reset, or
- Use a recovery method established during setup.

The exact security policy must be finalized before implementation.

---

# 20. Global Search

A dedicated global search screen is recommended even if not initially placed in bottom navigation.

## Searchable Entities

- Tenant.
- Mobile number.
- Unit.
- Property.
- Receipt number.
- Bill month/reference.
- Payment reference.

## Results Grouping

- Tenants.
- Units.
- Bills.
- Payments/Receipts.

## Behavior

- Search local DB only.
- Debounced.
- Recent local searches optional.
- Search should work without network.

---

# 21. Notification Center / Reminder List

Recommended supporting screen.

## Sections

- Upcoming rent reminders.
- Overdue local reminders.
- Backup reminder.
- Recently triggered reminders.

### Actions

- Open related tenant/bill.
- Snooze.
- Mark reviewed.
- Change reminder settings.

---

# 22. Advanced Feature Screen Extensions

The screens below should remain outside MVP unless the associated advanced feature is selected.

## A1 — Rent Increase List

Shows:

- Tenant.
- Current rent.
- New rent.
- Effective month.
- Status.

## A2 — Schedule Rent Increase

Fields:

- Tenant/unit.
- Current rent.
- New rent.
- Effective month.
- Reason/note.

Preview:

`Bills through October remain unchanged. New rent applies from November 2026.`

## A3 — Late Fee Rules

Controls:

- Enable late fee.
- Grace period.
- Fixed/percentage.
- Maximum.
- Applicable properties/units.

## A4 — Shared Expense List

Examples:

- Common electricity.
- Cleaning.
- Security.
- Generator.
- Water pump.

## A5 — Allocate Shared Expense

Allocation options:

- Equal per occupied unit.
- Equal per all unit.
- Manual.
- Percentage.

Preview each tenant impact before saving.

## A6 — Expense List

For landlord-side operating expenses.

Fields/cards:

- Date.
- Category.
- Property/unit.
- Amount.
- Vendor.
- Note.

## A7 — Add Expense

Categories:

- Repair.
- Maintenance.
- Utility.
- Cleaning.
- Security.
- Tax/fee.
- Other.

## A8 — Profit/Loss Summary

Per month/property:

- Rent collected.
- Other income.
- Repair expense.
- Operating expense.
- Net cash result.

Clearly label this as a management summary, not formal accounting.

## A9 — Owner List

For multiple owners.

- Name.
- Phone.
- Property association.
- Share percentage if supported.

## A10 — Caretaker Mode

Restricted operational mode.

Allowed actions might include:

- Record meter reading.
- Record payment.
- Add repair.
- View assigned tenants.

Restricted:

- Security settings.
- Backup restore.
- Financial reversals.
- Owner configuration.

Because the app is fully offline, multi-user access on one device needs a clear local role/PIN model.

## A11 — Receipt Template Selection

Templates:

- Compact Bengali.
- Detailed Bengali.
- English.
- Bilingual.

Preview before setting default.

## A12 — Meter Photo Review

Shows:

- Meter image.
- Detected/manual reading.
- Previous reading.
- Unit.
- Date.

If OCR is ever introduced, manual confirmation remains mandatory.

---

# 23. Reusable Components

## 23.1 Property Selector

Use a compact dropdown in top bar when multiple properties exist.

Items show:

- Property name.
- Area.
- Occupancy count.

## 23.2 Month Selector

Reusable across:

- Dashboard.
- Bills.
- Dues.
- Reports.
- Meter readings.

## 23.3 Tenant Selector

Searchable bottom sheet.

Each row:

- Tenant.
- Unit.
- Phone.
- Due.

## 23.4 Money Input

Requirements:

- Numeric keyboard.
- Taka prefix.
- Thousand-separator formatting after input or on blur.
- Decimal handling only where business rule permits.
- No negative input unless adjustment type supports it.

## 23.5 Status Chip

Use consistent text and icon.

## 23.6 Financial Summary Card

Layout:

- Main total.
- 2–4 sub-values.
- Status.
- Optional progress.

## 23.7 Bill Breakdown Row

Left:

- Label.

Right:

- Amount.

Expandable info icon for calculated values such as electricity or previous due.

## 23.8 Bottom Confirmation Sheet

Use for:

- Finalize bill.
- Record payment.
- Reverse payment.
- Deposit deduction.
- Move out.
- Restore backup.

## 23.9 Search and Filter Sheet

Common controls:

- Date/month.
- Property.
- Tenant.
- Unit.
- Status.
- Payment method.

Actions:

- Reset.
- Apply.

## 23.10 Attachment Picker

Options:

- Take Photo.
- Choose Photo.
- Choose File.

Show privacy note for local storage.

---

# 24. Detailed Validation UX

## 24.1 Tenant

- Name required.
- Phone validation should accept Bangladeshi mobile format but not over-restrict legitimate alternatives.
- Unit must be available for new active tenancy.
- Move-in date required.

## 24.2 Unit

- Unit number required.
- Unique within property.
- Base rent must be zero or positive according to product rule.
- Electricity settings must be complete for selected mode.

## 24.3 Meter Reading

- Current reading required.
- Cannot be less than previous reading unless meter-change flow is selected.
- Reading date cannot conflict with selected billing period without confirmation.

## 24.4 Payment

- Amount > 0.
- Payment date required.
- Tenant required.
- Overpayment requires explicit confirmation if it creates credit.

## 24.5 Deposit

- Deduction/refund cannot exceed available deposit unless business rules explicitly support it.
- Reason required for deduction.

## 24.6 Bill

- Must have an active tenancy.
- Duplicate bill for same tenancy/month is blocked.
- Missing required manual/meter amounts highlighted before finalization.

---

# 25. Financial Action Confirmation Rules

The following actions require stronger confirmation than ordinary CRUD:

- Finalize bill.
- Reverse payment.
- Deduct deposit.
- Refund deposit.
- Move tenant out.
- Restore backup.
- Archive property with history.
- Delete draft financial data.
- Apply tenant credit manually.

Confirmation should show:

1. Who/what is affected.
2. Amount.
3. Resulting balance.
4. Whether history is reversible.

---

# 26. Offline UX Requirements

Do not show generic cloud synchronization indicators in the core product.

The user should experience the app as locally available by default.

## Offline Rules

- All lists must load from local DB.
- All forms save locally.
- Receipts generate locally.
- PDF/CSV exports generate locally.
- Notifications are scheduled locally.
- Search is local.
- No login is needed for normal operation.
- No internet warning should block the app.

## External Share/Backup

When the user selects Google Drive, OneDrive, Dropbox, email, WhatsApp, etc., the app hands the file to the operating system/provider.

If that provider requires internet, failure should be attributed to the destination, not presented as a Bari Vara database failure.

---

# 27. Loading UX

Because most operations are local, avoid unnecessary full-screen loaders.

Use:

- Skeletons for larger query screens.
- Small progress indicators for PDF generation.
- Button progress state for saves.
- Blocking progress only for:
  - backup creation;
  - restore;
  - database upgrade;
  - very large export.

---

# 28. Error Message Style

Bad:

`SQLITE_CONSTRAINT_FOREIGNKEY`

Good:

`This unit cannot be removed because it has rental history. Archive it instead.`

Bad:

`Exception`

Good:

`The receipt could not be created. Your payment is already saved; you can generate the receipt again from Payment Details.`

Financial persistence and output generation should be treated separately so receipt failure never implies payment failure.

---

# 29. Recommended Home Empty-to-Mature Progression

## Brand-New App

Show:

- Setup completion.
- Add first tenant.
- Add more units.
- Create backup reminder.

## Active But No Bills This Month

Show:

- `October bills haven't been generated yet.`
- Primary: `Generate Bills`

## Bills Generated, No Payments

Show:

- Amount expected.
- All outstanding.
- `Record Payment`

## Partial Month

Show:

- Collection progress.
- Paid tenants.
- Outstanding tenants.

## Month Fully Collected

Show:

- Success state.
- `All finalized bills are paid.`
- Keep report and next-month actions accessible.

---

# 30. Recommended Screen Priority for Design Handoff

## P0 — Must Design Before MVP Development

1. Splash
2. Language Selection
3. Welcome
4. Create Property
5. Add Unit
6. Add Tenant
7. Dashboard
8. Property List/Details
9. Unit List/Details
10. Tenant List/Details
11. Rental Terms
12. Deposit Details
13. Monthly Bill Dashboard
14. Generate Bills
15. Bill List/Details
16. Edit Draft Bill
17. Meter Reading
18. Finalize Bill
19. Payment List
20. Record Payment
21. Payment Details
22. Receipt Preview
23. Due Summary/List/Details
24. Repair List/Add/Details
25. Reports Home
26. Monthly Collection Report
27. Backup & Restore
28. Create/Restore Backup
29. Settings
30. Critical confirmation/error states

## P1 — Required for Feature-Complete MVP

- Tenant Documents.
- Tenant Ledger.
- Move-Out.
- Deposit Settlement.
- Receipt History.
- All report variants.
- Export.
- Reminder settings.
- Security settings.
- Appearance.
- Global Search.

## P2 — Advanced

- Rent increases.
- Late fees.
- Shared expenses.
- Expense tracking.
- Profit/loss.
- Multi-owner.
- Caretaker mode.
- Receipt templates.
- Meter photo tools.

---

# 31. Suggested Flutter Screen/Route Mapping

Example route organization:

```text
/onboarding/language
/onboarding/welcome
/onboarding/security
/onboarding/property
/onboarding/unit
/onboarding/tenant
/onboarding/complete

/home
/home/monthly-summary

/properties
/properties/new
/properties/:propertyId
/properties/:propertyId/edit
/properties/:propertyId/units
/units/new
/units/:unitId
/units/:unitId/edit

/tenants
/tenants/new
/tenants/:tenantId
/tenants/:tenantId/edit
/tenants/:tenantId/terms
/tenants/:tenantId/deposit
/tenants/:tenantId/documents
/tenants/:tenantId/ledger
/tenants/:tenantId/move-out

/bills
/bills/generate
/bills/:billId
/bills/:billId/edit
/bills/:billId/meter
/bills/:billId/finalize

/payments
/payments/new
/payments/:paymentId

/dues
/dues/:tenantId

/receipts
/receipts/:receiptId

/repairs
/repairs/new
/repairs/:repairId

/reports
/reports/monthly-collection
/reports/tenant-ledger
/reports/deposits
/reports/repairs
/reports/vacancies

/backup
/backup/create
/backup/restore
/export

/settings
/settings/language
/settings/billing
/settings/receipt
/settings/notifications
/settings/security
/settings/appearance
```

Route names are illustrative and should remain decoupled from domain IDs and repository implementation.

---

# 32. UI State Model for Implementation

Each feature screen should explicitly handle relevant states such as:

```text
initial
loading
data
empty
editing
saving
saved
validationError
failure
permissionDenied
notFound
```

Financial screens additionally need:

```text
draft
finalized
partiallyPaid
paid
reversed
creditBalance
```

Do not infer these purely from widget appearance; expose clear presentation state from controller/notifier.

---

# 33. Acceptance Criteria for UI Implementation

A screen is considered implementation-ready only when:

- Both Bengali and English strings are defined.
- Empty state is defined.
- Loading state is defined where needed.
- Failure behavior is defined.
- Validation is defined.
- Primary and secondary actions are clear.
- Back-navigation behavior is defined.
- Unsaved changes are protected.
- Financial totals are visible before confirmation.
- Accessibility labels exist for non-text controls.
- The UI works without internet.
- Dark mode is verified.
- Small Android devices are verified.
- Large text does not clip important values.
- PDF/receipt previews render Bengali correctly.

---

# 34. MVP End-to-End UX Acceptance Flows

## Flow A — First-Time Landlord

```text
Splash
→ Language
→ Welcome
→ App Lock
→ Create Property
→ Add Unit
→ Add Tenant
→ Setup Complete
→ Dashboard
```

Success:

The landlord can reach a useful dashboard without creating an online account.

## Flow B — Monthly Billing

```text
Bills
→ Choose Month
→ Generate Bills
→ Enter Missing Meter Readings
→ Preview
→ Generate Drafts
→ Review Bill
→ Finalize
```

Success:

The total can be understood line-by-line.

## Flow C — Collect Rent

```text
Tenant / Payment
→ Record Payment
→ Allocation Preview
→ Confirm
→ Receipt Preview
→ Share Bengali Receipt
```

Success:

Payment is committed locally even if the share destination is unavailable.

## Flow D — Partial Payment

```text
Record Payment
→ Enter amount lower than due
→ Partial Payment Preview
→ Confirm
→ Updated Due
→ Receipt
```

Success:

Remaining due is immediately visible.

## Flow E — Tenant Move-Out

```text
Tenant
→ Move Out
→ Final Readings / Charges
→ Settlement Preview
→ Deposit Application
→ Confirm
→ Settlement PDF
→ Unit becomes Vacant
```

Success:

Historical bills/payments remain intact.

## Flow F — Device/Data Protection

```text
More
→ Backup & Restore
→ Create Backup
→ Encrypt
→ Save via System Picker
```

Success:

The landlord can create a portable backup without a Bari Vara backend.

---

# 35. Final Design Direction

Bari Vara should feel like a **simple rent notebook upgraded into a trustworthy digital tool**, not like a complicated property-management ERP.

The most important recurring experience is:

```text
Tenant
→ Monthly Bill
→ Utility Charges
→ Previous Due
→ Payment
→ Remaining Due
→ Bengali Receipt
```

Every design decision should make this cycle faster, safer, and easier to understand.

For MVP, prioritize:

1. Billing clarity.
2. Payment safety.
3. Bengali receipt quality.
4. Due visibility.
5. Very simple tenant/unit management.
6. Reliable local data.
7. Easy backup and restore.

The user should be able to run the complete rental workflow with the phone in airplane mode.
