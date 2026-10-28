import 'package:flutter/material.dart';

class UploadPdfCard extends StatelessWidget {

  final VoidCallback onTap;
  const UploadPdfCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 36,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE2E0DD),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F2F7),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.file_upload_outlined,
                size: 20,
                color: Color(0xFF252936),
              ),
            ),

            const SizedBox(height: 18),

            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF11121A),
                ),
                children: [
                  TextSpan(
                    text: 'Drop a PDF here, or ',
                  ),
                  TextSpan(
                    text: 'browse',
                    style: TextStyle(
                      color: Color(0xFF6847E8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 7),

            const Text(
              'Up to 50 MB · PDFs only',
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFF747580),
              ),
            ),
          ],
        ),
      ),
    );
  }
}