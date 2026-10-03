# Bari Vara — Detailed Feature Specification

## 1. Product Overview

**Bari Vara** is a fully offline mobile application for small Bangladeshi landlords who manage approximately **2–20 rental units**. The app is designed to help landlords keep accurate tenant, rent, utility, due, deposit, repair, and payment records without requiring any backend server or continuous internet connection.

The app stores all operational data locally on the mobile device and focuses on simple workflows, Bengali-first usability, fast monthly billing, and easy receipt sharing.

### 1.1 Core Product Promise

Bari Vara should allow a landlord to answer these questions instantly:

- কে কোন বাসায়/ইউনিটে থাকে?
- এই মাসের ভাড়া কত?
- বিদ্যুৎ, গ্যাস, পানি ও সার্ভিস চার্জ কত?
- আগের বকেয়া আছে কি?
- কত টাকা অগ্রিম/সিকিউরিটি ডিপোজিট আছে?
- এই মাসে কত টাকা পাওয়া হয়েছে?
- কে এখনো টাকা দেয়নি?
- কোন ইউনিটে কী মেরামত হয়েছে?
- ভাড়াটিয়াকে বাংলা রসিদ কীভাবে পাঠাব?

### 1.2 Target Users

Primary users:

- Small residential landlords in Bangladesh
- Building owners with 2–20 rental units
- Family-owned rental properties
- Landlords who currently use notebooks, Excel, WhatsApp, or paper receipts

Secondary users:

- Property caretaker or manager operating the app on behalf of the owner
- Small mixed-use property owners managing both residential and commercial units

### 1.3 Operating Model

- Mobile-first
- Fully offline
- No mandatory account
- No mandatory backend
- Local database as source of truth
- Optional manual backup/export to external storage/cloud providers in a later phase
- Bengali and English UI support
- Bengali receipt generation

---

# 2. Product Goals

## 2.1 Primary Goals

1. Make monthly rent calculation simple and reliable.
2. Preserve tenant and payment history month by month.
3. Reduce manual calculation errors.
4. Show current dues instantly.
5. Make Bengali receipt generation easy.
6. Help landlords track deposits and repair costs separately from rent.
7. Provide a complete offline experience.
8. Keep the interface simple enough for non-technical users.

## 2.2 Non-Goals for MVP

The MVP does not require:

- Online landlord portal
- Tenant mobile app
- Real-time cloud synchronization
- Bank API integration
- Automatic bKash/Nagad payment verification
- Online payment gateway
- Government tax filing
- Full property management ERP
- Remote multi-user collaboration

---

# 3. Recommended MVP Scope

The MVP should include:

- Property management
- Building/floor/unit management
- Tenant management
- Rental agreement summary
- Monthly bill generation
- Rent tracking
- Utility charges
- Previous dues
- Advance/security deposit tracking
- Payment collection
- Partial payment support
- Receipt generation
- Bengali receipt sharing
- Repair/maintenance records
- Monthly dashboard
- Due list
- Search/filter
- Local database
- Backup/restore file
- CSV/PDF export where practical
- PIN/app lock
- Bengali/English language
- Light/dark/system theme

---

# 4. Property and Unit Management

## 4.1 Property List

Support landlords who own one or more properties.

Each property may contain:

- Property name
- Property nickname
- Address
- Area
- City/district
- Optional description
- Owner name
- Owner phone
- Receipt header details
- Default currency: BDT
- Property status: Active / Archived

Example:

> Property: Rahman Villa  
> Address: Mirpur 10, Dhaka

## 4.2 Building Structure

Allow the landlord to organize units by:

- Building
- Floor
- Unit

Examples:

- Ground Floor — Unit A
- 1st Floor — Flat 1A
- 1st Floor — Flat 1B
- 2nd Floor — Flat 2A

The app should not force a complex hierarchy if the landlord has only a few units.

## 4.3 Unit Information

Each unit should support:

- Unit name/number
- Floor
- Unit type
  - Apartment
  - Room
  - Shop
  - Office
  - Garage
  - Other
- Bedroom count
- Bathroom count
- Default monthly rent
- Default service charge
- Default water charge
- Default gas charge
- Electricity billing mode
- Occupancy status
  - Vacant
  - Occupied
  - Reserved
  - Under maintenance
- Notes

## 4.4 Electricity Billing Mode

Each unit may support one of these modes:

1. Fixed monthly electricity charge
2. Meter-based calculation
3. Manually entered monthly amount
4. Included in rent
5. Not applicable

For meter-based billing, store:

- Meter number
- Previous reading
- Current reading
- Unit consumption
- Rate per unit
- Additional meter charge

Formula:

> Consumption = Current Reading - Previous Reading

> Electricity Amount = Consumption × Rate + Additional Charge

---

# 5. Tenant Management

## 5.1 Tenant List

Show:

- Tenant name
- Unit
- Phone number
- Move-in date
- Current due
- Current month payment status
- Active/Former status

Filters:

- Active tenants
- Former tenants
- Due tenants
- Fully paid tenants
- Property
- Unit

## 5.2 Tenant Profile

Store:

- Full name
- Bengali name, optional
- Mobile number
- Alternative phone
- Email, optional
- NID number, optional
- Occupation
- Employer/company, optional
- Permanent address
- Emergency contact
- Family/member count
- Move-in date
- Expected move-out date, optional
- Profile photo, optional local image
- Notes

## 5.3 Tenant Documents

Optional local attachments:

- NID copy
- Passport photo
- Rental agreement photo/PDF
- Police verification document
- Other documents

All files remain on the device.

## 5.4 Tenant Status

Statuses:

- Active
- Notice given
- Moving out
- Former
- Blacklisted, optional

## 5.5 Tenant History

When a tenant leaves, do not delete their records.

Preserve:

- Payment history
- Bill history
- Deposit history
- Repair responsibility records
- Move-in/move-out dates
- Previous unit occupancy

---

# 6. Rental Agreement and Rent Setup

## 6.1 Rental Terms

For each tenancy:

- Monthly rent
- Service charge
- Water charge
- Gas charge
- Electricity setup
- Parking charge
- Other recurring charge
- Rent due date
- Grace period, optional
- Late fee rule, optional advanced feature
- Security deposit
- Advance rent
- Agreement start date
- Agreement end date, optional
- Increment/review date
- Notes

## 6.2 Security Deposit

Track separately from monthly income.

Fields:

- Deposit amount
- Date received
- Payment method
- Receipt/reference
- Refundable amount
- Deductions
- Refund date
- Refund status

Statuses:

- Not collected
- Partially collected
- Held
- Partially refunded
- Fully refunded
- Adjusted

## 6.3 Advance Rent

Advance rent should be different from security deposit.

Support:

- Advance months paid
- Amount
- Date received
- Applied month(s)
- Remaining unapplied advance

---

# 7. Monthly Billing

## 7.1 Monthly Bill Creation

The landlord selects a month, for example:

> অক্টোবর ২০২৬

The app generates a bill for each active tenant using configured recurring charges.

## 7.2 Bill Components

Each bill can contain:

- Monthly rent
- Electricity
- Gas
- Water
- Service charge
- Parking
- Previous due
- Repair charge
- Late fee
- Other charge
- Discount/adjustment
- Advance adjustment

## 7.3 Example Bill

> অক্টোবর ২০২৬  
> Rent: ৳15,000  
> Electricity: ৳1,430  
> Gas: ৳1,080  
> Previous due: ৳2,000  
> **Total: ৳19,510**

## 7.4 Monthly Billing Workflow

Recommended flow:

1. Select month
2. Show all active tenants
3. Generate draft bills
4. Enter electricity reading/amount
5. Review utility amounts
6. Add adjustments if needed
7. Confirm/finalize bill
8. Share bill summary or wait until payment

## 7.5 Draft and Finalized Bill State

Bill statuses:

- Draft
- Finalized
- Partially paid
- Paid
- Overpaid
- Cancelled

Finalized bills should be protected from accidental edits.

If edited later, preserve audit/history where practical.

## 7.6 Previous Due Calculation

Previous due should be calculated automatically from prior unpaid balance.

Example:

September total = ৳18,000  
September paid = ৳16,000  
Remaining = ৳2,000

October bill:

> Previous Due: ৳2,000

## 7.7 Carry Forward Rules

Support:

- Automatic carry forward
- Manual override
- Waive previous due
- Partial adjustment

Any override should be recorded in the bill history.

---

# 8. Utility Management

## 8.1 Electricity

Support:

- Meter-based amount
- Fixed amount
- Manual monthly amount
- Included in rent
- Not applicable

Meter-based inputs:

- Previous reading
- Current reading
- Units consumed
- Rate per unit
- Fixed/meter fee
- Final amount

## 8.2 Gas

Modes:

- Fixed monthly amount
- Meter-based future option
- Included in rent
- Not applicable

## 8.3 Water

Modes:

- Fixed monthly amount
- Shared building cost divided equally
- Shared building cost divided by tenant count
- Manual amount
- Included in rent

## 8.4 Service Charge

Support:

- Fixed monthly charge
- Different by unit
- Included in rent
- Temporarily waived

## 8.5 Shared Utility Allocation

Advanced feature:

Suppose total water bill = ৳6,000 for 6 units.

Allocation strategies:

- Equal division
- Occupied units only
- By number of residents
- Custom ratio
- Manual override

---

# 9. Payment Collection

## 9.1 Record Payment

Payment fields:

- Tenant
- Month/bill
- Amount
- Payment date
- Payment method
- Reference number
- Notes

Payment methods:

- Cash
- bKash
- Nagad
- Rocket
- Bank transfer
- Cheque
- Other

## 9.2 Partial Payments

Example:

Total bill = ৳19,510

Tenant pays:

- ৳15,000 on 5 October
- ৳4,510 on 12 October

The app should show:

- Total
- Paid
- Remaining
- Payment history

## 9.3 Multi-Month Payment

Support recording a payment that covers:

- Current month
- Previous due
- Advance month

The app may allow manual allocation.

## 9.4 Overpayment

If tenant pays more than due:

Options:

- Store as tenant credit
- Apply to next month
- Mark as advance payment

## 9.5 Payment Reversal

Allow reversal/correction if a payment was entered by mistake.

Do not silently delete confirmed transactions.

Store:

- Reversal reason
- Reversal date
- Original payment reference

---

# 10. Receipts

## 10.1 Receipt Generation

Generate receipt after payment.

Receipt should contain:

- Property name
- Property address
- Receipt number
- Date
- Tenant name
- Unit
- Billing month
- Rent
- Utilities
- Previous due
- Other charges
- Total payable
- Amount paid
- Remaining due
- Payment method
- Landlord/manager name
- Optional signature image
- Notes

## 10.2 Bengali Receipt

Example:

> **বাড়ি ভাড়ার রসিদ**  
> মাস: অক্টোবর ২০২৬  
> ভাড়াটিয়া: মোঃ করিম  
> ফ্ল্যাট: ২বি  
> 
> বাড়ি ভাড়া: ৳১৫,০০০  
> বিদ্যুৎ: ৳১,৪৩০  
> গ্যাস: ৳১,০৮০  
> পূর্বের বকেয়া: ৳২,০০০  
> **মোট: ৳১৯,৫১০**  
> পরিশোধ: ৳১৯,৫১০  
> **বাকি: ৳০**

## 10.3 Receipt Format

Support:

- Bengali
- English
- Bengali + English

## 10.4 Receipt Output

Generate as:

- Shareable image
- PDF
- Printable layout

Share through installed apps such as:

- WhatsApp
- Messenger
- IMO
- Email
- Bluetooth
- Files

The app itself does not require internet for receipt generation.

## 10.5 Receipt Numbering

Example scheme:

> RV-2026-10-0007

Configurable prefix may be supported.

---

# 11. Due Management

## 11.1 Due Dashboard

Show:

- Total outstanding dues
- Number of tenants with dues
- Current month unpaid
- Previous month unpaid
- Overdue amount

## 11.2 Due List

Example:

| Tenant | Unit | Current Bill | Paid | Due |
|---|---|---:|---:|---:|
| Karim | 2B | ৳19,510 | ৳15,000 | ৳4,510 |
| Salma | 3A | ৳17,000 | ৳0 | ৳17,000 |

## 11.3 Due Details

Show due by month:

- August 2026: ৳0
- September 2026: ৳2,000
- October 2026: ৳4,510

Total due:

> ৳6,510

---

# 12. Repairs and Maintenance

## 12.1 Repair Record

Track repairs by:

- Property
- Unit
- Tenant
- Date
- Problem type
- Description
- Vendor/technician
- Cost
- Paid by
- Chargeable to tenant?
- Receipt/photo attachment
- Status

## 12.2 Repair Categories

Examples:

- Plumbing
- Electrical
- Paint
- Door/window
- AC
- Bathroom
- Kitchen
- Appliance
- Gas line
- Water line
- Common area
- Other

## 12.3 Repair Responsibility

Support:

- Landlord expense
- Tenant expense
- Shared expense

If tenant is responsible, allow adding the amount to the monthly bill.

## 12.4 Maintenance History

Show unit-wise repair history and total maintenance cost.

---

# 13. Vacancy and Move-Out

## 13.1 Mark Unit Vacant

When tenant moves out:

- Record move-out date
- Finalize outstanding dues
- Calculate deposit settlement
- Record damage deductions
- Refund remaining deposit
- Archive tenancy
- Mark unit vacant

## 13.2 Deposit Settlement

Example:

Security deposit: ৳30,000

Deductions:

- Remaining rent: ৳5,000
- Repair: ৳2,500

Refund:

> ৳22,500

## 13.3 Move-Out Statement

Generate a summary containing:

- Final bill
- Outstanding amount
- Deposit balance
- Deductions
- Refund amount

---

# 14. Dashboard

## 14.1 Home Dashboard

Show simple summary cards:

- Total units
- Occupied
- Vacant
- This month expected rent
- This month collected
- This month due
- Total deposit held
- Repairs this month

## 14.2 Monthly Status

Example:

> October 2026  
> Expected: ৳1,20,000  
> Collected: ৳93,500  
> Due: ৳26,500

## 14.3 Quick Actions

- Add tenant
- Record payment
- Generate monthly bills
- Add meter reading
- Add repair
- Share receipt

---

# 15. Reports

## 15.1 Monthly Collection Report

Show:

- Expected rent
- Collected rent
- Utility collected
- Previous dues collected
- Total received
- Outstanding dues

## 15.2 Tenant Ledger

For a selected tenant:

- Month
- Bill amount
- Paid amount
- Remaining amount
- Receipt references

## 15.3 Property Income Summary

By month/year:

- Rental income
- Utility recoveries
- Other income
- Repair expense
- Net collection

## 15.4 Deposit Report

Show:

- Tenant
- Deposit received
- Deposit refunded
- Deposit held
- Adjustments

## 15.5 Vacancy Report

Show:

- Current vacant units
- Vacancy start date
- Previous tenant
- Previous rent

## 15.6 Repair Expense Report

Show:

- Date
- Unit
- Category
- Cost
- Paid by landlord/tenant

---

# 16. Search, Filters and Sorting

Global search should support:

- Tenant name
- Mobile number
- Unit
- Property
- Receipt number

Filters should support:

- Paid/unpaid
- Month
- Property
- Unit
- Tenant status
- Payment method
- Repair category

---

# 17. Notifications and Reminders

All reminders are generated locally on the device.

## 17.1 Rent Due Reminder

Examples:

- Rent due today
- 3 tenants have unpaid rent
- Prepare next month bills

## 17.2 Manual Reminder Setup

Allow user to choose:

- Monthly bill generation reminder
- Rent collection reminder
- Utility reading reminder
- Agreement expiry reminder
- Deposit settlement reminder

## 17.3 No Server Dependency

Use device local notifications only.

---

# 18. Bengali and English Support

## 18.1 Language Modes

- বাংলা
- English

## 18.2 Bengali-Friendly Content

Important terminology should be localized naturally.

Examples:

- Tenant → ভাড়াটিয়া
- Rent → বাড়ি ভাড়া
- Due → বকেয়া
- Deposit → জামানত / সিকিউরিটি ডিপোজিট
- Electricity → বিদ্যুৎ
- Gas → গ্যাস
- Water → পানি
- Service Charge → সার্ভিস চার্জ
- Receipt → রসিদ
- Payment → পরিশোধ

## 18.3 Bengali Number Display

Optional setting:

- English numerals: 15,000
- Bengali numerals: ১৫,০০০

Currency display:

- ৳15,000
- ৳১৫,০০০

---

# 19. Data Storage and Offline Architecture Requirements

## 19.1 Local-First Requirement

The app must remain fully usable without:

- Internet
- Sign-in
- Cloud service
- Backend API

## 19.2 Local Database

Recommended local database options:

For Flutter:

- Drift/SQLite
- Isar

For native Android:

- Room / SQLite

For iOS native:

- SwiftData / Core Data

## 19.3 Local Attachments

Store documents and images locally in application-managed storage.

The database should store file references rather than large binary blobs where practical.

## 19.4 Data Integrity

Important financial operations should use database transactions.

Examples:

- Finalize monthly bill
- Record payment
- Apply payment to bill
- Reverse payment
- Deposit settlement

---

# 20. Backup, Restore and Export

Even though the app is fully offline, backup is essential because losing the phone must not automatically mean losing years of rental records.

## 20.1 Manual Backup

Generate a complete backup file containing:

- Properties
- Units
- Tenants
- Tenancies
- Bills
- Payments
- Deposits
- Repairs
- Settings
- Attachments where supported

## 20.2 Backup Protection

Optional:

- Encrypted backup file
- Password-protected backup

## 20.3 Restore

Restore options:

- Replace existing data
- Merge, advanced feature

Before restore:

- Validate backup version
- Validate integrity
- Show summary
- Confirm overwrite

## 20.4 External Storage/Cloud Export

Future/advanced integration:

- Google Drive
- OneDrive
- Dropbox
- Device file storage

The cloud provider is only used as file storage; Bari Vara still does not require its own backend.

## 20.5 CSV Export

Support export for:

- Tenant list
- Monthly bills
- Payment ledger
- Due report
- Repair report

## 20.6 PDF Export

Support:

- Receipt
- Monthly collection summary
- Tenant ledger
- Deposit settlement

---

# 21. Security and Privacy

## 21.1 App Lock

Support:

- PIN
- Fingerprint
- Face authentication where available

## 21.2 Sensitive Data

Potential sensitive records:

- Tenant NID
- Phone number
- Address
- Financial transactions
- Deposit information

## 21.3 Local Encryption

Recommended:

- Encrypt highly sensitive values where appropriate
- Store app keys using platform secure storage

## 21.4 Screenshot Protection

Optional advanced feature for sensitive screens.

---

# 22. Settings

## 22.1 General Settings

- Language
- Currency
- Bengali/English numerals
- Date format
- First day of month view
- Default receipt language

## 22.2 Billing Settings

- Default due date
- Auto carry forward due
- Default service charge
- Default gas charge
- Default water charge
- Receipt prefix

## 22.3 Notification Settings

- Rent due reminder
- Bill generation reminder
- Utility reading reminder
- Agreement expiry reminder

## 22.4 Appearance

- Light
- Dark
- System
- Text size

## 22.5 Backup Settings

- Last backup date
- Create backup
- Restore backup
- Export data

---

# 23. Suggested Mobile Navigation

Recommended bottom navigation:

1. Home
2. Tenants
3. Bills
4. Payments
5. More

## 23.1 More Menu

Include:

- Properties
- Units
- Dues
- Deposits
- Repairs
- Reports
- Backup & Restore
- Settings
- Help

---

# 24. Important User Flows

## 24.1 First-Time Setup

1. Open app
2. Select language
3. Create property
4. Add units
5. Add first tenant
6. Enter rent and deposit
7. Set utility charges
8. Finish setup
9. View dashboard

## 24.2 Add Tenant

1. Select vacant unit
2. Enter tenant information
3. Set move-in date
4. Enter monthly rent
5. Configure utilities
6. Enter deposit/advance
7. Save tenancy

## 24.3 Generate Monthly Bills

1. Open Bills
2. Select month
3. Tap Generate Bills
4. Enter meter readings
5. Review bills
6. Finalize

## 24.4 Collect Rent

1. Open tenant or unpaid bill
2. Tap Record Payment
3. Enter amount
4. Choose payment method
5. Save
6. Generate receipt
7. Share receipt

## 24.5 Handle Partial Payment

1. Open bill
2. Record partial amount
3. Remaining due updates automatically
4. Share partial payment receipt
5. Remaining amount carries forward if unpaid

## 24.6 Tenant Move-Out

1. Start move-out
2. Review outstanding dues
3. Add final charges
4. Review deposit
5. Add deductions
6. Record refund
7. Generate settlement summary
8. Archive tenant
9. Mark unit vacant

---

# 25. Common UI States

The product should have consistent designs for:

- Initial loading
- Empty property list
- Empty tenant list
- Empty bill list
- Empty payment history
- Empty due list
- Empty repair list
- No search results
- Save in progress
- Save successful
- Save failed
- Delete confirmation
- Delete failed
- Unsaved changes
- Invalid amount
- Invalid meter reading
- Duplicate payment warning
- Finalized bill edit warning
- Payment reversal confirmation
- Backup in progress
- Backup success
- Backup failed
- Restore confirmation
- Restore failed
- Database migration
- Local storage almost full
- Permission denied
- File access unavailable
- PDF generation failed
- Receipt sharing unavailable

---

# 26. Validation Rules

Examples:

## Tenant

- Name required
- Unit required
- Move-in date required
- Monthly rent cannot be negative

## Meter Reading

- Current reading should not normally be less than previous reading
- Confirm if meter has been replaced/reset

## Payment

- Amount must be greater than zero
- Payment date required
- Warn if amount exceeds outstanding balance

## Deposit

- Refund cannot exceed currently held amount unless manually overridden

## Bill

- Total should equal sum of charges minus discounts/credits

---

# 27. Financial Calculation Rules

## 27.1 Bill Total

Formula:

> Total = Rent + Electricity + Gas + Water + Service Charge + Parking + Previous Due + Repair Charge + Other Charges + Late Fee - Discount - Advance/Credit Adjustment

## 27.2 Remaining Due

> Remaining Due = Final Bill Total - Payments Applied

## 27.3 Credit

If payment exceeds due:

> Credit = Payment - Outstanding Amount

## 27.4 Deposit Balance

> Deposit Balance = Deposit Received - Deposit Refunded - Deposit Adjusted

---

# 28. Audit and History

A lightweight local activity history is recommended.

Track important actions:

- Tenant created
- Tenant moved out
- Rent changed
- Bill finalized
- Bill changed after finalization
- Payment recorded
- Payment reversed
- Deposit received
- Deposit refunded
- Due waived
- Backup restored

This is especially useful when financial values change later.

---

# 29. Advanced Features

These are suitable after MVP validation.

## 29.1 Rent Increase Management

- Schedule future rent change
- Effective month
- Preserve historical rent

## 29.2 Automatic Late Fee

Rules such as:

- Fixed amount after due date
- Percentage of rent
- Manual override

## 29.3 Shared Building Expenses

- Cleaner salary
- Lift maintenance
- Generator fuel
- Security guard
- Common electricity

Allocate charges across units.

## 29.4 Photo Meter Reading

Allow attaching a local photo of the electricity meter.

## 29.5 Receipt Templates

Multiple styles:

- Simple Bengali
- Formal receipt
- Compact WhatsApp image

## 29.6 Tenant Balance Statement

Generate full statement between two dates.

## 29.7 Multiple Owners

Track ownership share for a property.

## 29.8 Caretaker Mode

Restrict caretaker access to operational functions.

Possible role permissions:

- View tenants
- Record payment
- Add meter reading
- Add repair
- Cannot change property setup
- Cannot delete financial records

Since the app has no server, role separation is limited to the local device profile.

## 29.9 Expense Tracking

General landlord expenses:

- Tax
- Maintenance
- Salary
- Cleaning
- Common utilities
- Repairs

## 29.10 Profit/Loss Summary

Simple report:

> Rental Income - Property Expenses = Net Property Cash Flow

---

# 30. Potential Future Features

These should not complicate the initial product.

- Optional tenant-facing receipt QR
- Optional SMS message templates
- WhatsApp-ready payment reminder text
- Rental agreement templates
- Bangla voice input for notes
- OCR from electricity bill
- Smart meter reading from camera
- Local AI assistant, if future device capabilities permit
- Optional cloud backup integrations
- Tablet layout
- Multi-property owner analytics

---

# 31. Suggested MVP Screens

## A. Launch and Setup

1. Splash
2. Language Selection
3. Welcome
4. App Lock Setup
5. Create Property
6. Add First Unit
7. Add First Tenant
8. Setup Complete

## B. Home

9. Dashboard
10. Monthly Collection Summary
11. Quick Actions

## C. Properties and Units

12. Property List
13. Property Details
14. Add/Edit Property
15. Unit List
16. Unit Details
17. Add/Edit Unit
18. Vacancy Details

## D. Tenants

19. Tenant List
20. Tenant Details
21. Add Tenant
22. Edit Tenant
23. Rental Terms
24. Deposit Details
25. Tenant Documents
26. Tenant Ledger
27. Move-Out
28. Move-Out Settlement

## E. Bills

29. Monthly Bill Dashboard
30. Month Selector
31. Generate Bills
32. Bill List
33. Bill Details
34. Edit Draft Bill
35. Electricity Reading Entry
36. Add Adjustment
37. Finalize Bill
38. Previous Due Breakdown

## F. Payments

39. Payment List
40. Record Payment
41. Partial Payment
42. Payment Details
43. Reverse Payment
44. Tenant Credit

## G. Receipts

45. Receipt Preview
46. Bengali Receipt
47. English Receipt
48. Share Receipt
49. Receipt History

## H. Dues

50. Due Summary
51. Due Tenant List
52. Due Details
53. Monthly Due Breakdown

## I. Repairs

54. Repair List
55. Repair Details
56. Add Repair
57. Add Repair Cost to Bill

## J. Reports

58. Reports Home
59. Monthly Collection Report
60. Tenant Ledger Report
61. Deposit Report
62. Repair Report
63. Vacancy Report

## K. Backup and Settings

64. Backup & Restore
65. Create Backup
66. Restore Backup
67. Export Data
68. Settings Home
69. Language Settings
70. Billing Settings
71. Receipt Settings
72. Notification Settings
73. Security Settings
74. Appearance Settings

## L. Common States

75. Empty State
76. No Search Results
77. Save Success
78. Save Failure
79. Delete Confirmation
80. Unsaved Changes
81. Finalized Bill Warning
82. Backup Failure
83. Restore Confirmation
84. Storage Almost Full
85. Database Upgrade

---

# 32. Recommended MVP vs Advanced Breakdown

## MVP

- Fully offline local database
- One or multiple properties
- Unit management
- Tenant management
- Rental terms
- Security deposit
- Advance rent
- Monthly billing
- Electricity
- Gas
- Water
- Service charge
- Previous due
- Manual adjustments
- Partial payments
- Payment methods
- Receipt generation
- Bengali receipt
- PDF/image sharing
- Due tracking
- Repair tracking
- Basic reports
- Local reminders
- Search and filtering
- Backup/restore
- CSV export
- PIN/biometric lock
- Bengali/English UI

## Advanced

- Rent increase scheduling
- Late fee automation
- Shared building expense allocation
- Tenant credit rules
- Caretaker mode
- Rich income/expense reports
- Multiple receipt templates
- Cloud-file backup connectors
- Document management
- Advanced tenant statement
- Property profitability
- Multiple ownership shares
- Meter photo history
- OCR/AI-assisted data entry

---

# 33. Success Metrics

Possible product success indicators:

- User can add property, unit, and tenant in under 5 minutes
- Monthly billing for 10 units can be prepared in under 10 minutes
- User can identify unpaid tenants within 10 seconds
- Receipt can be generated and shared within 20 seconds after recording payment
- User can recover all app data from a backup file
- No core feature requires internet access

---

# 34. Suggested Product Positioning

Possible tagline:

> **বাড়িভাড়া, বকেয়া, বিল ও রসিদের সহজ হিসাব**

Alternative:

> **ছোট বাড়িওয়ালাদের সহজ ভাড়া ব্যবস্থাপনা**

The product should position itself as a focused landlord notebook replacement rather than a complex property management platform.

---

# 35. Final Product Principle

Bari Vara should optimize for:

**Simple > Complex**  
**Offline > Account-dependent**  
**Bangladesh-first > Generic international workflows**  
**Monthly rent workflow > Large-property ERP features**  
**Clear dues > Complicated accounting**  
**Fast Bengali receipt sharing > Heavy reporting**

For the target landlord managing 2–20 units, the best experience should feel like replacing a paper rent notebook with a reliable, searchable, automatic mobile ledger.
