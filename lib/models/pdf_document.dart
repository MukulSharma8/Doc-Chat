class PdfDocument {
  final String name;
  final String path;
  final int sizeInBytes;

  const PdfDocument({
    required this.name,
    required this.path,
    required this.sizeInBytes,
  });

  String get formattedSize {
    if (sizeInBytes < 1024 * 1024) {
      return '${(sizeInBytes / 1024).toStringAsFixed(1)} KB';
    }

    return '${(sizeInBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}