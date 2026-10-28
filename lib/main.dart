import 'package:docchat/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const DocChat());
}

class DocChat extends StatelessWidget {
  const DocChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DocChat',
      theme: ThemeData(
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
