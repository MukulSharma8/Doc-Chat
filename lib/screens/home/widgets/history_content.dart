import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../chat/chat_screen.dart';

class HistoryContent extends StatefulWidget {
  const HistoryContent({super.key});

  @override
  State<HistoryContent> createState() => _HistoryContentState();
}

class _HistoryContentState extends State<HistoryContent> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = [];
  bool isLoading = true;

  String _formatDate(dynamic timestamp) {
    if (timestamp is! Timestamp) return '';

    final date = timestamp.toDate();
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final result = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('documents')
        .orderBy('createdAt', descending: true)
        .get();

    if (mounted) {
      setState(() {
        documents = result.docs;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Chat history',
            style: TextStyle(
              fontSize: 27,
              height: 1.15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF11121B),
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Every conversation with every document, searchable.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF686974),
            ),
          ),

          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 11,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFFE2E0DD),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.search,
                  size: 18,
                  color: Color(0xFF4D4E58),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Search conversations, documents, or messages',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF696A74),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (documents.isEmpty)
            const Text(
              'No chat history yet.',
              style: TextStyle(color: Color(0xFF686974)),
            )
          else
            ...documents.map((document) {
              final data = document.data();

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(17),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          documentId: document.id,
                          documentTitle: data['fileName'] ?? 'Untitled PDF',
                          localPath: data['localPath'] as String?,
                        ),
                      ),
                    );
                  },
                  child: _HistoryCard(
                    item: _HistoryItem(
                      title: data['fileName'] ?? 'Untitled PDF',
                      document: 'PDF document',
                      time: _formatDate(data['createdAt']),
                      message: 'Tap to continue this conversation',
                    ),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}

class _HistorySection extends StatelessWidget {
  final String title;
  final List<_HistoryItem> items;

  const _HistorySection({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4D4E58),
            letterSpacing: 0.3,
          ),
        ),

        const SizedBox(height: 12),

        ...items.map(
              (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _HistoryCard(item: item),
          ),
        ),
      ],
    );
  }
}

class _HistoryItem {
  final String title;
  final String document;
  final String time;
  final String message;

  const _HistoryItem({
    required this.title,
    required this.document,
    required this.time,
    required this.message,
  });
}

class _HistoryCard extends StatelessWidget {
  final _HistoryItem item;

  const _HistoryCard({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFE2E0DD),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: const Color(0xFFF0ECFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.chat_bubble_outline,
              size: 18,
              color: Color(0xFF6948E8),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF151620),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Text(
                      item.time,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF777882),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Text(
                  item.document,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF686974),
                  ),
                ),

                const SizedBox(height: 9),

                Text(
                  item.message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.45,
                    color: Color(0xFF4F505A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}