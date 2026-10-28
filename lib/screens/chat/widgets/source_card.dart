import 'package:flutter/material.dart';

class SourceCard extends StatelessWidget {
  final String page;
  final String title;
  final String content;

  const SourceCard({
    super.key,
    required this.page,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFBFA),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFE1DFDC),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF0EBFF),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Text(
              page,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6546E8),
              ),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.description_outlined,
                      size: 13,
                      color: Color(0xFF565761),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF20212B),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Page $page',
                      style: const TextStyle(
                        fontSize: 9,
                        color: Color(0xFF747580),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Text(
                  '"$content"',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    height: 1.45,
                    color: Color(0xFF62636E),
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