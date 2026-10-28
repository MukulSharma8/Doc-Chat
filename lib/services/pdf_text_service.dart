import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfTextService {
  Future<String> extractText(String filePath) async {
    final file = File(filePath);

    if (!await file.exists()) {
      throw Exception('PDF file not found.');
    }

    final bytes = await file.readAsBytes();
    final document = PdfDocument(inputBytes: bytes);

    try {
      final text = PdfTextExtractor(document).extractText();

      if (text.trim().isEmpty) {
        throw Exception(
          'No readable text found. This PDF may contain scanned pages.',
        );
      }

      return text;
    } finally {
      document.dispose();
    }
  }
}