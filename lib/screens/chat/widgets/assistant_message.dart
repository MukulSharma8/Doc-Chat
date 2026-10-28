import 'package:flutter/material.dart';

import 'source_card.dart';

class AssistantMessage extends StatelessWidget {
  final String message;
  final String time;
  final List<Map<String, dynamic>> sources;

  const AssistantMessage({
    super.key,
    required this.message,
    required this.time,
    required this.sources,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: const Color(0xFF6947E8),
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(
              Icons.auto_awesome,
              size: 12,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17).copyWith(
                      topLeft: const Radius.circular(5),
                    ),
                    border: Border.all(
                      color: const Color(0xFFE0DEDB),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    message,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: Color(0xFF242531),
                    ),
                  ),
                ),

                if (sources.isNotEmpty) ...[
                  const SizedBox(height: 11),

                  const Text(
                    'SOURCES',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF5E536E),
                      letterSpacing: 0.4,
                    ),
                  ),

                  const SizedBox(height: 8),

                  ...sources.map(
                        (source) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SourceCard(
                        page: source['page'],
                        title: source['title'],
                        content: source['content'],
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 1),

                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF6452C7),
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