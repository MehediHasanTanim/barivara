import 'dart:typed_data';

import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/features/receipts/application/receipt_pdf_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdf/pdf.dart';

void main() {
  final ReceiptSnapshot receipt = ReceiptSnapshot(
    id: EntityId('receipt-1'),
    paymentId: EntityId('payment-1'),
    receiptNumber: 'BV-2026-10-000001-AB12CD',
    templateVersion: 1,
    createdAt: DateTime.utc(2026, 10, 5),
    propertyName: 'রহমান ভিলা / Rahman Villa with a deliberately long name',
    propertyAddress: 'ধানমন্ডি, ঢাকা',
    landlordName: 'মোঃ রহমান',
    tenantName: 'আব্দুল করিম with a deliberately long tenant name',
    unitName: 'Floor 10 - Apartment A-1001',
    billingMonths: <BillingMonth>[BillingMonth(2026, 10)],
    chargeBreakdown: <ReceiptLineItem>[
      ReceiptLineItem(
        description: 'House rent',
        amount: Money.fromTaka(999999999),
      ),
      ReceiptLineItem(description: 'বিদ্যুৎ বিল', amount: Money.fromTaka(510)),
    ],
    paymentAmount: Money.fromTaka(8000),
    remainingDue: Money.fromTaka(11510),
    paymentMethod: PaymentMethod.bkash,
    paymentDate: DateTime.utc(2026, 10, 5),
  );

  test('round-trips every immutable receipt value through its stored JSON', () {
    final ReceiptSnapshot restored = ReceiptSnapshot.fromJson(receipt.toJson());

    expect(restored.receiptNumber, receipt.receiptNumber);
    expect(restored.tenantName, receipt.tenantName);
    expect(restored.chargeBreakdown.last.description, 'বিদ্যুৎ বিল');
    expect(restored.paymentAmount, Money.fromTaka(8000));
    expect(restored.remainingDue, Money.fromTaka(11510));
  });

  testWidgets(
    'renders valid-looking English and Bengali PDFs with embedded fonts',
    (WidgetTester tester) async {
      final ReceiptPdfService service = const ReceiptPdfService();
      final Uint8List english = await service.build(
        receipt,
        language: ReceiptLanguage.english,
        pageFormat: PdfPageFormat.a4,
      );
      final Uint8List bengali = await service.build(
        receipt,
        language: ReceiptLanguage.bengali,
        pageFormat: PdfPageFormat.a4,
      );

      expect(english.take(4), orderedEquals(<int>[37, 80, 68, 70]));
      expect(bengali.take(4), orderedEquals(<int>[37, 80, 68, 70]));
      expect(english.length, greaterThan(10000));
      expect(bengali.length, greaterThan(10000));
    },
  );
}
