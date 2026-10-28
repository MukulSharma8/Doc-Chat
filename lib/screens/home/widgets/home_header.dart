import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF191B27),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.picture_as_pdf_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),

          const SizedBox(width: 10),

          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              children: [
                TextSpan(
                  text: 'Doc',
                  style: TextStyle(
                    color: Color(0xFF11121A),
                  ),
                ),
                TextSpan(
                  text: 'Chat',
                  style: TextStyle(
                    color: Color(0xFF6847E8),
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F1FF),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFE5DDFB),
              ),
            ),
            child: const Text(
              'Y',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF6847E8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}