import 'package:flutter/material.dart';

class DocumentHistoryToggle extends StatelessWidget {
  final bool showDocuments;
  final ValueChanged<bool> onChanged;

  const DocumentHistoryToggle({
    super.key,
    required this.showDocuments,
    required this.onChanged,
  });

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
            child: _buildTab(
              title: 'Documents',
              icon: Icons.description_outlined,
              selected: showDocuments,
              onTap: () => onChanged(true),
            ),
          ),
          Expanded(
            child: _buildTab(
              title: 'History',
              icon: Icons.history,
              selected: !showDocuments,
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String title,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFF0F1F5)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 15,
              color: const Color(0xFF252631),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF252631),
              ),
            ),
          ],
        ),
      ),
    );
  }
}