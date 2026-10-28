import 'package:flutter/material.dart';

class HomeTabs extends StatelessWidget {
  const HomeTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 8,
      ),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFE8E7E4),
          ),
          bottom: BorderSide(
            color: Color(0xFFE8E7E4),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F1F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.description_outlined,
                    size: 15,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Documents',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 20),

          const Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.history,
                  size: 15,
                  color: Color(0xFF353641),
                ),
                SizedBox(width: 8),
                Text(
                  'History',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF4C4D57),
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