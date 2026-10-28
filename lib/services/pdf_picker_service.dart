import 'package:file_picker/file_picker.dart';

class PdfPickerService {
  Future<PlatformFile?> pickPdf() async {
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (files.isEmpty) {
      return null;
    }

    return files.first;
  }
}