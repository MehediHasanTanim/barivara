import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

void main() {
  testWidgets('embeds the Bengali font in a generated PDF document', (
    WidgetTester tester,
  ) async {
    final ByteData data = await rootBundle.load(
      'assets/fonts/NotoSansBengali-Regular.ttf',
    );
    final pw.Font font = pw.Font.ttf(data);
    final pw.Document document = pw.Document();
    document.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => pw.Text(
          'অক্টোবর ২০২৬ — মোট ৳১৯,৫১০',
          style: pw.TextStyle(font: font),
        ),
      ),
    );

    final List<int> bytes = await document.save();

    expect(bytes, isNotEmpty);
  });
}
