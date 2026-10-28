
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ChatService {
  static const String _baseUrl = 'http://10.0.2.2:3000';

  Future<String> askQuestion({
    required String question,
    required String pdfText,
  }) async {
    final response = await http
        .post(
      Uri.parse('$_baseUrl/api/chat'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'question': question,
        'pdfText': pdfText,
      }),
    )
        .timeout(const Duration(seconds: 65));

    final Map<String, dynamic> data =
    jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 200) {
      throw Exception(
        data['error']?.toString() ?? 'Failed to get an AI response.',
      );
    }

    final answer = data['answer'];

    if (answer is! String || answer.trim().isEmpty) {
      throw Exception('The AI returned an empty response.');
    }

    return answer;
  }
}
