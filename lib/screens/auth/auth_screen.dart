import 'package:flutter/material.dart';
import 'widgets/auth_form.dart';
import 'widgets/auth_toggle.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isSignIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFCFB),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 36,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: const Color(0xFF191B27),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Icon(
                    Icons.picture_as_pdf_outlined,
                    color: Colors.white,
                    size: 21,
                  ),
                ),

                const SizedBox(height: 22),

                // Heading
                Text(
                  isSignIn ? 'Welcome back' : 'Create your account',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF11121A),
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  isSignIn
                      ? 'Sign in to continue chatting with your documents.'
                      : 'Start chatting with your PDFs in under a minute.',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF55555E),
                  ),
                ),

                const SizedBox(height: 20),

                // Sign in / Sign up
                AuthToggle(
                  isSignIn: isSignIn,
                  onChanged: (value) {
                    setState(() {
                      isSignIn = value;
                    });
                  },
                ),

                const SizedBox(height: 25),

                // Form
                AuthForm(
                  isSignIn: isSignIn,
                ),

                const SizedBox(height: 25),

                // Divider
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Color(0xFFDCDCD9),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'or',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF666771),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Color(0xFFDCDCD9),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // Google button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF171821),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      side: const BorderSide(
                        color: Color(0xFFDCDCD9),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'G',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Continue with Google',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Demo account
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Use demo account',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF4D5060),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Disclaimer
                const Center(
                  child: Text(
                    'This is a design preview — any email works and no data is sent\n'
                        'anywhere.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 9.5,
                      height: 1.5,
                      color: Color(0xFF777883),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}