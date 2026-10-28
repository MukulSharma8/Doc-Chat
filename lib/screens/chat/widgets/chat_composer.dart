import 'package:flutter/material.dart';

class ChatComposer extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatComposer({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
      decoration: const BoxDecoration(
        color: Color(0xFFFAF9F7),
        border: Border(
          top: BorderSide(
            color: Color(0xFFE6E4E1),
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 13,
              right: 6,
              top: 6,
              bottom: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(
                color: const Color(0xFFE0DEDB),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 7,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.attach_file,
                  size: 17,
                  color: Color(0xFF454650),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: TextField(
                    controller: controller,
                    minLines: 1,
                    maxLines: 4,
                    textInputAction: TextInputAction.newline,
                    decoration: const InputDecoration(
                      hintText: 'Ask anything about this',
                      hintStyle: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF777883),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                InkWell(
                  onTap: onSend,
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    padding: const EdgeInsets.all(9),
                    decoration: const BoxDecoration(
                      color: Color(0xFF8C8D94),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 7),

          const Text(
            'DocChat can make mistakes — check the cited pages.',
            style: TextStyle(
              fontSize: 9,
              color: Color(0xFF777883),
            ),
          ),
        ],
      ),
    );
  }
}