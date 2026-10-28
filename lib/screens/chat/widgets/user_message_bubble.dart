import 'package:flutter/material.dart';

class UserMessageBubble extends StatelessWidget {
  final String message;
  final String time;

  const UserMessageBubble({
    super.key,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: const BoxConstraints(
                maxWidth: 270,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 13,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF171A26),
                borderRadius: BorderRadius.circular(18).copyWith(
                  bottomRight: const Radius.circular(5),
                ),
                border: Border.all(
                  color: const Color(0xFF080A11),
                ),
              ),
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.45,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 5),
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
    );
  }
}