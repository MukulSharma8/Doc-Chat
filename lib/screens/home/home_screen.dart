import 'package:docchat/screens/home/widgets/document_content.dart';
import 'package:docchat/screens/home/widgets/history_content.dart';
import 'package:docchat/screens/home/widgets/home_header.dart';
import 'package:flutter/material.dart';
import '../../widgets/document_history_toggle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showDocuments = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F7),
      body: SafeArea(
        child: Column(
          children: [
            const HomeHeader(),

            DocumentHistoryToggle(
              showDocuments: showDocuments,
              onChanged: (value) {
                setState(() {
                  showDocuments = value;
                });
              },
            ),

            Expanded(
              child: showDocuments
                  ? const DocumentsContent()
                  : const HistoryContent(),
            ),
          ],
        ),
      ),
    );
  }
}