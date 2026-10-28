
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Save a document's metadata for a user.
  Future<void> saveDocument({
    required String userId,
    required String documentId,
    required String fileName,
    required String storagePath,
  }) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('documents')
        .doc(documentId)
        .set({
      'fileName': fileName,
      'storagePath': storagePath,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Get a user's documents.
  Stream<QuerySnapshot<Map<String, dynamic>>> getDocuments(
      String userId,
      ) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('documents')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // Save a chat message for a document.
  Future<void> saveMessage({
    required String userId,
    required String documentId,
    required String role,
    required String message,
  }) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('documents')
        .doc(documentId)
        .collection('messages')
        .add({
      'role': role,
      'message': message,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
