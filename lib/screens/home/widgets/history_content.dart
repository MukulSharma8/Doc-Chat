import 'package:flutter/material.dart';

class HistoryContent extends StatelessWidget {
  const HistoryContent({super.key});

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

          const SizedBox(height: 30),

          const _HistorySection(
            title: 'TODAY',
            items: [
              _HistoryItem(
                title: 'Runway & growth metrics deep-dive',
                document: 'Nexora Labs — Series B Pitch Deck',
                time: 'Today, 11:02',
                message:
                'DocChat: The deck targets a \$25M Series B, which extends runway to 28...',
              ),
              _HistoryItem(
                title: 'Gross margin change over year',
                document: 'Q3 2026 Financial Report',
                time: 'Today, 08:27',
                message:
                'DocChat: Gross margin improved from 71.4% in Q3 2025 to 76.8% in Q3 2026 ...',
              ),
            ],
          ),

          const SizedBox(height: 28),

          const _HistorySection(
            title: 'YESTERDAY',
            items: [
              _HistoryItem(
                title: 'Termination & liability clauses',
                document: 'Master Services Agreement — Atlas Health',
                time: 'Yesterday, 19:44',
                message:
                'DocChat: Yes — aggregate liability is capped at the fees paid in the 12...',
              ),
              _HistoryItem(
                title: 'How multi-head attention works',
                document: 'Attention Is All You Need (Vaswani et al., 2017)',
                time: 'Yesterday, 14:05',
                message:
                'DocChat: Multi-head attention allows the model to focus on different...',
              ),
            ],
          ),
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