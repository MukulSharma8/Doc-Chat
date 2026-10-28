import 'package:docchat/screens/chat/chat_screen.dart';
import 'package:flutter/material.dart';

class DocumentCard extends StatelessWidget {
  final String category;
  final Color categoryColor;
  final Color categoryTextColor;
  final String title;
  final String pages;
  final String sizeAndDate;
  final String? localPath;


  const DocumentCard({
    super.key,
    required this.category,
    required this.categoryColor,
    required this.categoryTextColor,
    required this.title,
    required this.pages,
    required this.sizeAndDate,
    this.localPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              documentTitle: title,
              localPath: localPath,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE1DFDC),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPreview(),
      
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: categoryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 9,
                            color: categoryTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
      
                      const Spacer(),
      
                      Text(
                        pages,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF686974),
                        ),
                      ),
                    ],
                  ),
      
                  const SizedBox(height: 9),
      
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.3,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF171821),
                    ),
                  ),
      
                  const SizedBox(height: 6),
      
                  Text(
                    sizeAndDate,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF73747E),
                    ),
                  ),
      
                  const SizedBox(height: 10),
      
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.chat_bubble_outline,
                      size: 13,
                      color: Color(0xFF6847E8),
                    ),
                    label: const Text(
                      'Chat',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF292A35),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: const BorderSide(
                        color: Color(0xFFE1DFDC),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreview() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 14,
      ),
      color: const Color(0xFFFAFAF9),
      child: Center(
        child: Container(
          width: 174,
          height: 190,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
              color: const Color(0xFFE5E3E0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              const Text(
                '1',
                style: TextStyle(
                  fontSize: 7,
                  color: Color(0xFF666770),
                ),
              ),

              const SizedBox(height: 8),

              ...List.generate(
                8,
                    (index) => Container(
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: index == 2 || index == 5
                        ? const Color(0xFFE8E7E4)
                        : const Color(0xFFEDECEA),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  width: index.isEven ? 125 : 145,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}