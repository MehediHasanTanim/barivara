import 'dart:typed_data';

import 'package:barivara/core/domain/models.dart';
import 'package:barivara/features/receipts/application/receipt_pdf_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

/// Reviews an immutable receipt before the user prints, shares, or exports it.
class ReceiptPreviewScreen extends StatefulWidget {
  const ReceiptPreviewScreen({
    required this.receipt,
    required this.initialLanguage,
    super.key,
  });

  final ReceiptSnapshot receipt;
  final ReceiptLanguage initialLanguage;

  @override
  State<ReceiptPreviewScreen> createState() => _ReceiptPreviewScreenState();
}

class _ReceiptPreviewScreenState extends State<ReceiptPreviewScreen> {
  final ReceiptPdfService _pdf = const ReceiptPdfService();
  final ReceiptFileService _files = const ReceiptFileService();
  late ReceiptLanguage _language = widget.initialLanguage;
  bool _working = false;

  Future<Uint8List> _build(PdfPageFormat format) =>
      _pdf.build(widget.receipt, language: _language, pageFormat: format);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.receipt.receiptNumber),
      actions: <Widget>[
        PopupMenuButton<ReceiptLanguage>(
          tooltip: 'Receipt language',
          initialValue: _language,
          onSelected: (ReceiptLanguage value) =>
              setState(() => _language = value),
          itemBuilder: (BuildContext context) =>
              const <PopupMenuEntry<ReceiptLanguage>>[
                PopupMenuItem(
                  value: ReceiptLanguage.bengali,
                  child: Text('বাংলা'),
                ),
                PopupMenuItem(
                  value: ReceiptLanguage.english,
                  child: Text('English'),
                ),
              ],
          icon: const Icon(Icons.language_rounded),
        ),
        IconButton(
          onPressed: _working ? null : _share,
          tooltip: 'Share receipt',
          icon: const Icon(Icons.share_rounded),
        ),
        IconButton(
          onPressed: _working ? null : _save,
          tooltip: 'Save receipt',
          icon: const Icon(Icons.save_alt_rounded),
        ),
      ],
    ),
    body: PdfPreview(
      key: ValueKey<ReceiptLanguage>(_language),
      build: _build,
      pdfFileName: '${widget.receipt.receiptNumber}.pdf',
      canChangePageFormat: false,
      canChangeOrientation: false,
      allowSharing: false,
      onError: (BuildContext context, Object error) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text('Could not render this receipt: $error'),
        ),
      ),
    ),
  );

  Future<void> _share() async {
    await _run(() async {
      final Uint8List bytes = await _build(PdfPageFormat.a4);
      final file = await _files.write(widget.receipt, bytes);
      await SharePlus.instance.share(
        ShareParams(
          files: <XFile>[XFile(file.path, mimeType: 'application/pdf')],
          subject: 'Rent receipt ${widget.receipt.receiptNumber}',
          text: 'Rent receipt ${widget.receipt.receiptNumber}',
        ),
      );
    });
  }

  Future<void> _save() async {
    await _run(() async {
      final Uint8List bytes = await _build(PdfPageFormat.a4);
      final Uri? location = await FilePicker.saveFile(
        dialogTitle: 'Save receipt PDF',
        fileName: '${widget.receipt.receiptNumber}.pdf',
        bytes: bytes,
        mimeType: 'application/pdf',
        type: FileType.custom,
        allowedExtensions: const <String>['pdf'],
      );
      if (location != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Receipt saved to selected location.')),
        );
      }
    });
  }

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _working = true);
    try {
      await action();
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Receipt action could not be completed.'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }
}
