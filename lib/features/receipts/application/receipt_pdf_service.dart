import 'dart:io';

import 'package:barivara/core/domain/models.dart';
import 'package:barivara/core/domain/value_types.dart';
import 'package:barivara/core/localization/bari_vara_formatters.dart';
import 'package:barivara/features/settings/domain/app_settings.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Produces entirely local, font-embedded Bengali and English receipt PDFs.
class ReceiptPdfService {
  const ReceiptPdfService();

  Future<Uint8List> build(
    ReceiptSnapshot receipt, {
    required ReceiptLanguage language,
    PdfPageFormat pageFormat = PdfPageFormat.a4,
  }) async {
    final ByteData regularData = await rootBundle.load(
      'assets/fonts/NotoSansBengali-Regular.ttf',
    );
    final ByteData boldData = await rootBundle.load(
      'assets/fonts/NotoSansBengali-Bold.ttf',
    );
    final pw.Font regular = pw.Font.ttf(regularData);
    final pw.Font bold = pw.Font.ttf(boldData);
    final _ReceiptLabels labels = _ReceiptLabels.forLanguage(language);
    final pw.ThemeData theme = pw.ThemeData.withFont(base: regular, bold: bold);
    final pw.Document document = pw.Document(theme: theme);
    final pw.TextStyle body = pw.TextStyle(font: regular, fontSize: 10);
    final pw.TextStyle heading = pw.TextStyle(
      font: bold,
      fontSize: 11,
      fontWeight: pw.FontWeight.bold,
    );
    final pw.TextStyle title = pw.TextStyle(
      font: bold,
      fontSize: 20,
      fontWeight: pw.FontWeight.bold,
    );
    final String month = receipt.billingMonths
        .map(
          (BillingMonth value) => BariVaraFormatters.billingMonth(
            value,
            language: language == ReceiptLanguage.bengali
                ? AppLanguage.bengali
                : AppLanguage.english,
            digitStyle: language == ReceiptLanguage.bengali
                ? DigitStyle.bengali
                : DigitStyle.english,
          ),
        )
        .join(', ');
    String money(Money value) => BariVaraFormatters.money(
      value,
      digitStyle: language == ReceiptLanguage.bengali
          ? DigitStyle.bengali
          : DigitStyle.english,
      showMinorUnits: true,
    );

    document.addPage(
      pw.MultiPage(
        pageFormat: pageFormat,
        margin: const pw.EdgeInsets.all(36),
        header: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: <pw.Widget>[
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: <pw.Widget>[
                      pw.Text(receipt.propertyName, style: title),
                      if (receipt.propertyAddress != null)
                        pw.Text(receipt.propertyAddress!, style: body),
                      if (receipt.landlordName != null)
                        pw.Text(
                          '${labels.landlord}: ${receipt.landlordName}',
                          style: body,
                        ),
                      if (receipt.landlordPhone != null)
                        pw.Text(receipt.landlordPhone!, style: body),
                    ],
                  ),
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: <pw.Widget>[
                    pw.Text(labels.title, style: title),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      '${labels.receiptNo}: ${receipt.receiptNumber}',
                      style: heading,
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 16),
            pw.Container(height: 1, color: PdfColors.blueGrey300),
            pw.SizedBox(height: 14),
          ],
        ),
        footer: (pw.Context context) => pw.Padding(
          padding: const pw.EdgeInsets.only(top: 12),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[
              pw.Text(
                labels.generatedOffline,
                style: pw.TextStyle(font: regular, fontSize: 8),
              ),
              pw.Text(
                '${context.pageNumber}/${context.pagesCount}',
                style: pw.TextStyle(font: regular, fontSize: 8),
              ),
            ],
          ),
        ),
        build: (pw.Context context) => <pw.Widget>[
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.blueGrey200),
            columnWidths: const <int, pw.TableColumnWidth>{
              0: pw.FlexColumnWidth(1),
              1: pw.FlexColumnWidth(1.4),
            },
            children: <pw.TableRow>[
              _detailRow(labels.tenant, receipt.tenantName, heading, body),
              _detailRow(labels.unit, receipt.unitName, heading, body),
              _detailRow(labels.month, month, heading, body),
              _detailRow(
                labels.paymentDate,
                _date(receipt.paymentDate, language),
                heading,
                body,
              ),
              _detailRow(
                labels.paymentMethod,
                labels.method(receipt.paymentMethod),
                heading,
                body,
              ),
            ],
          ),
          pw.SizedBox(height: 18),
          pw.Text(labels.chargeBreakdown, style: heading),
          pw.SizedBox(height: 6),
          pw.TableHelper.fromTextArray(
            headers: <String>[labels.description, labels.amount],
            data: receipt.chargeBreakdown
                .map(
                  (ReceiptLineItem item) => <String>[
                    item.description,
                    money(item.amount),
                  ],
                )
                .toList(growable: false),
            headerStyle: pw.TextStyle(
              font: bold,
              fontWeight: pw.FontWeight.bold,
            ),
            cellStyle: body,
            headerDecoration: const pw.BoxDecoration(
              color: PdfColors.blueGrey100,
            ),
            cellAlignment: pw.Alignment.centerLeft,
            headerAlignment: pw.Alignment.centerLeft,
            columnWidths: const <int, pw.TableColumnWidth>{
              0: pw.FlexColumnWidth(3),
              1: pw.FlexColumnWidth(1),
            },
            border: pw.TableBorder.all(color: PdfColors.blueGrey200),
          ),
          pw.SizedBox(height: 18),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Container(
              width: 220,
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: PdfColors.blueGrey50,
                border: pw.Border.all(color: PdfColors.blueGrey300),
              ),
              child: pw.Column(
                children: <pw.Widget>[
                  _totalRow(
                    labels.paidAmount,
                    money(receipt.paymentAmount),
                    heading,
                    body,
                  ),
                  pw.SizedBox(height: 8),
                  _totalRow(
                    labels.remainingDue,
                    money(receipt.remainingDue),
                    heading,
                    body,
                  ),
                ],
              ),
            ),
          ),
          pw.SizedBox(height: 46),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Column(
              children: <pw.Widget>[
                pw.Container(
                  width: 140,
                  height: 1,
                  color: PdfColors.blueGrey700,
                ),
                pw.SizedBox(height: 5),
                pw.Text(labels.signature, style: body),
              ],
            ),
          ),
        ],
      ),
    );
    return document.save();
  }

  static pw.TableRow _detailRow(
    String label,
    String value,
    pw.TextStyle labelStyle,
    pw.TextStyle bodyStyle,
  ) => pw.TableRow(
    children: <pw.Widget>[
      pw.Padding(
        padding: const pw.EdgeInsets.all(7),
        child: pw.Text(label, style: labelStyle),
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.all(7),
        child: pw.Text(value, style: bodyStyle),
      ),
    ],
  );

  static pw.Widget _totalRow(
    String label,
    String value,
    pw.TextStyle labelStyle,
    pw.TextStyle bodyStyle,
  ) => pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: <pw.Widget>[
      pw.Text(label, style: labelStyle),
      pw.Text(value, style: bodyStyle),
    ],
  );

  static String _date(DateTime value, ReceiptLanguage language) {
    if (language == ReceiptLanguage.bengali) {
      return BariVaraFormatters.bengaliDigits(
        DateFormat('dd MMMM y', 'en_US').format(value.toLocal()),
      );
    }
    return DateFormat('dd MMMM y', 'en_US').format(value.toLocal());
  }
}

/// Writes PDFs only under the app-private temporary cache and purges stale files.
class ReceiptFileService {
  const ReceiptFileService();

  Future<File> write(ReceiptSnapshot receipt, Uint8List bytes) async {
    final Directory root = await getTemporaryDirectory();
    final Directory folder = Directory('${root.path}/bari_vara_receipts');
    if (!await folder.exists()) await folder.create(recursive: true);
    await _clean(folder);
    final String safe = receipt.receiptNumber.replaceAll(
      RegExp(r'[^A-Za-z0-9._-]'),
      '_',
    );
    final File file = File('${folder.path}/$safe.pdf');
    return file.writeAsBytes(bytes, flush: true);
  }

  Future<void> _clean(Directory folder) async {
    final DateTime cutoff = DateTime.now().subtract(const Duration(days: 7));
    await for (final FileSystemEntity entity in folder.list()) {
      try {
        if (entity is File && (await entity.stat()).modified.isBefore(cutoff)) {
          await entity.delete();
        }
      } on FileSystemException {
        // Cache cleanup is best-effort and must not block receipt creation.
      }
    }
  }
}

class _ReceiptLabels {
  const _ReceiptLabels({
    required this.title,
    required this.receiptNo,
    required this.landlord,
    required this.tenant,
    required this.unit,
    required this.month,
    required this.paymentDate,
    required this.paymentMethod,
    required this.chargeBreakdown,
    required this.description,
    required this.amount,
    required this.paidAmount,
    required this.remainingDue,
    required this.signature,
    required this.generatedOffline,
    required this.cash,
    required this.bank,
    required this.bkash,
    required this.nagad,
    required this.rocket,
    required this.cheque,
    required this.other,
  });

  final String title;
  final String receiptNo;
  final String landlord;
  final String tenant;
  final String unit;
  final String month;
  final String paymentDate;
  final String paymentMethod;
  final String chargeBreakdown;
  final String description;
  final String amount;
  final String paidAmount;
  final String remainingDue;
  final String signature;
  final String generatedOffline;
  final String cash;
  final String bank;
  final String bkash;
  final String nagad;
  final String rocket;
  final String cheque;
  final String other;

  String method(PaymentMethod value) => switch (value) {
    PaymentMethod.cash => cash,
    PaymentMethod.bankTransfer => bank,
    PaymentMethod.bkash => bkash,
    PaymentMethod.nagad => nagad,
    PaymentMethod.rocket => rocket,
    PaymentMethod.cheque => cheque,
    PaymentMethod.other => other,
  };

  factory _ReceiptLabels.forLanguage(ReceiptLanguage language) =>
      language == ReceiptLanguage.bengali
      ? const _ReceiptLabels(
          title: 'ভাড়া পরিশোধ রসিদ',
          receiptNo: 'রসিদ নং',
          landlord: 'বাড়িওয়ালা',
          tenant: 'ভাড়াটিয়া',
          unit: 'ইউনিট',
          month: 'বিলের মাস',
          paymentDate: 'পরিশোধের তারিখ',
          paymentMethod: 'পরিশোধের মাধ্যম',
          chargeBreakdown: 'বিলের বিবরণ',
          description: 'বিবরণ',
          amount: 'পরিমাণ',
          paidAmount: 'পরিশোধিত',
          remainingDue: 'বকেয়া',
          signature: 'বাড়িওয়ালার স্বাক্ষর',
          generatedOffline: 'Bari Vara - অফলাইনে তৈরি',
          cash: 'নগদ',
          bank: 'ব্যাংক ট্রান্সফার',
          bkash: 'বিকাশ',
          nagad: 'নগদ',
          rocket: 'রকেট',
          cheque: 'চেক',
          other: 'অন্যান্য',
        )
      : const _ReceiptLabels(
          title: 'Rent Payment Receipt',
          receiptNo: 'Receipt no.',
          landlord: 'Landlord',
          tenant: 'Tenant',
          unit: 'Unit',
          month: 'Billing month',
          paymentDate: 'Payment date',
          paymentMethod: 'Payment method',
          chargeBreakdown: 'Charge breakdown',
          description: 'Description',
          amount: 'Amount',
          paidAmount: 'Paid amount',
          remainingDue: 'Remaining due',
          signature: 'Landlord signature',
          generatedOffline: 'Bari Vara - generated offline',
          cash: 'Cash',
          bank: 'Bank transfer',
          bkash: 'bKash',
          nagad: 'Nagad',
          rocket: 'Rocket',
          cheque: 'Cheque',
          other: 'Other',
        );
}
