import 'package:flutter/material.dart';

class AuthToggle extends StatelessWidget {
  final bool isSignIn;
  final ValueChanged<bool> onChanged;

  const AuthToggle({
    super.key,
    required this.isSignIn,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F0EE),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildButton(
              title: 'Sign in',
              selected: isSignIn,
              onTap: () => onChanged(true),
            ),
          ),
          Expanded(
            child: _buildButton(
              title: 'Sign up',
              selected: !isSignIn,
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFFDFCFB)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: selected
              ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ]
              : null,
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF181923),
          ),
        ),
      ),
    );
  }
}