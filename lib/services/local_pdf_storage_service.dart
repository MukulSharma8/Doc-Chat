
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class LocalPdfStorageService {
  Future<String> savePdf(PlatformFile file) async {
    final sourcePath = file.path;

    if (sourcePath == null || sourcePath.isEmpty) {
      throw Exception('The selected PDF has no accessible file path.');
    }

    final sourceFile = File(sourcePath);

    if (!await sourceFile.exists()) {
      throw Exception('The selected PDF could not be found.');
    }

    final appDirectory = await getApplicationDocumentsDirectory();

    final pdfDirectory = Directory(
      p.join(appDirectory.path, 'documents'),
    );

    if (!await pdfDirectory.exists()) {
      await pdfDirectory.create(recursive: true);
    }

    final safeName = p.basename(file.name);
    final uniqueName =
        '${DateTime.now().millisecondsSinceEpoch}_$safeName';

    final destinationPath = p.join(
      pdfDirectory.path,
      uniqueName,
    );

    final savedFile = await sourceFile.copy(destinationPath);

    return savedFile.path;
  }
}
