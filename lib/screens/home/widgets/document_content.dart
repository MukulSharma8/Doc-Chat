
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docchat/screens/home/widgets/recent_chat_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../services/local_pdf_storage_service.dart';
import '../../../services/pdf_picker_service.dart';
import 'upload_pdf_card.dart';
import 'document_card.dart';

class DocumentsContent extends StatefulWidget {
  const DocumentsContent({super.key});

  @override
  State<DocumentsContent> createState() => _DocumentsContentState();
}

class _DocumentsContentState extends State<DocumentsContent> {
  final LocalPdfStorageService localPdfStorageService =
  LocalPdfStorageService();
  final PdfPickerService pdfPickerService = PdfPickerService();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isUploading = false;


  Future<void> _pickPdf() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        _showMessage('Please sign in before adding a document.');
        return;
      }

      final file = await pdfPickerService.pickPdf();

      if (!mounted || file == null) return;

      setState(() => isUploading = true);

      // Save the actual PDF on this device.
      final localPath = await localPdfStorageService.savePdf(file);

      // Save document metadata in Firestore.
      final documentRef = firestore
          .collection('users')
          .doc(user.uid)
          .collection('documents')
          .doc();

      await documentRef.set({
        'fileName': file.name,
        'localPath': localPath,
        'storagePath': null,
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'locally_saved',
      });

      if (!mounted) return;

      _showMessage('PDF saved on this device.');
    } on FirebaseException catch (error) {
      if (mounted) {
        _showMessage(
          'Firebase error: ${error.message ?? error.code}',
        );
      }
    } catch (error) {
      if (mounted) {
        _showMessage('Could not save PDF: $error');
      }
    } finally {
      if (mounted) {
        setState(() => isUploading = false);
      }
    }
  }


  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }


  String _formatDate(dynamic value) {
    if (value is! Timestamp) return 'Just added';

    final date = value.toDate();
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.auto_awesome,
                size: 14,
                color: Color(0xFF6546E8),
              ),
              SizedBox(width: 6),
              Text(
                'YOUR READING SPACE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6546E8),
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 27,
                height: 1.12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF11121B),
              ),
              children: [
                TextSpan(text: 'What are we reading\n'),
                TextSpan(
                  text: 'today?',
                  style: TextStyle(color: Color(0xFF6546E8)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Upload a PDF and ask it anything — every answer '
                'comes with page citations.',
            style: TextStyle(
              fontSize: 13,
              height: 1.45,
              color: Color(0xFF686974),
            ),
          ),
          const SizedBox(height: 28),

          UploadPdfCard(onTap: isUploading ? () {} : _pickPdf),

          if (isUploading) ...[
            const SizedBox(height: 12),
            const LinearProgressIndicator(),
            const SizedBox(height: 4),
            const Text(
              'Saving document details...',
              style: TextStyle(fontSize: 12, color: Color(0xFF686974)),
            ),
          ],

          const SizedBox(height: 38),
          const Text(
            'Recent documents',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF11121B),
            ),
          ),
          const SizedBox(height: 5),

          if (user == null)
            const Text(
              'Sign in to view your saved documents.',
              style: TextStyle(fontSize: 12, color: Color(0xFF4F4F62)),
            )
          else
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: firestore
                  .collection('users')
                  .doc(user.uid)
                  .collection('documents')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text('Could not load documents from Firestore.'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final documents = snapshot.data?.docs ?? [];

                if (documents.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'No documents yet. Upload a PDF to get started.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF686974),
                      ),
                    ),
                  );
                }

                return Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${documents.length} '
                            '${documents.length == 1 ? 'document' : 'documents'} '
                            'saved to your account',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF4F4F62),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    ...documents.map((document) {
                      final data = document.data();
                      final fileName =
                          data['fileName'] as String? ?? 'Untitled PDF';

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: DocumentCard(
                          title: data['fileName'] ?? 'Untitled PDF',
                          localPath: data['localPath'] as String?,
                          category: 'PDF',
                          categoryColor: const Color(0xFFEDE9FF),
                          categoryTextColor: const Color(0xFF6244D8),
                          pages: 'PDF document',
                          sizeAndDate:
                          'Saved on this device · ${_formatDate(data['createdAt'])}',
                        ),
                      );
                    }),
                  ],
                );
              },
            ),

          const SizedBox(height: 24),
          const Text(
            'Continue where you left off',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF171821),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Pick up a conversation from where you left off.',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF73747E),
            ),
          ),
          const SizedBox(height: 12),
          const RecentChatCard(
            title: 'Runway & growth metrics deep-dive',
            subtitle: 'Nexora Labs — Series B Pitch Deck',
          ),
          const SizedBox(height: 10),
          const RecentChatCard(
            title: 'Gross margin change over year',
            subtitle: 'Q3 2026 Financial Report',
          ),
          const SizedBox(height: 10),
          const RecentChatCard(
            title: 'Termination & liability clauses',
            subtitle: 'Master Services Agreement — Atlas Health',
          ),
          const SizedBox(height: 18),
          const Center(
            child: Text(
              'View all chat history →',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6546E8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
