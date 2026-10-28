
import 'package:docchat/screens/auth/auth_screen.dart';
import 'package:docchat/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildSplash();
        }

        if (snapshot.hasData) {
          return const HomeScreen();
        }

        return const AuthScreen();
      },
    );
  }

  Widget _buildSplash() {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFCFB),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),

            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF292B38),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.picture_as_pdf_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),

            const SizedBox(height: 20),

            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 31,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                ),
                children: [
                  TextSpan(
                    text: 'Doc',
                    style: TextStyle(color: Color(0xFF11121A)),
                  ),
                  TextSpan(
                    text: 'Chat',
                    style: TextStyle(color: Color(0xFF6847E8)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Turn any PDF into a conversation. Ask,\n'
                    'understand, cite.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF4D4D57),
                  fontSize: 13,
                  height: 1.6,
                ),
              ),
            ),

            const Spacer(),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 80),
              child: LinearProgressIndicator(
                minHeight: 4,
                color: Color(0xFF6847E8),
                backgroundColor: Color(0xFFE8E5F2),
              ),
            ),

            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
