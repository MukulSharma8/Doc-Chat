
import 'package:flutter/material.dart';

import '../../services/pdf_text_service.dart';
import '../../services/chat_service.dart';
import 'widgets/assistant_message.dart';
import 'widgets/chat_composer.dart';
import 'widgets/user_message_bubble.dart';

class ChatScreen extends StatefulWidget {
  final String documentTitle;
  final String? localPath;

  const ChatScreen({
    super.key,
    required this.documentTitle,
    this.localPath,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final PdfTextService _pdfTextService = PdfTextService();
  final ChatService _chatService = ChatService();

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController =
  TextEditingController();

  final List<Map<String, dynamic>> messages = [];

  String _pdfText = '';
  bool _isLoadingPdf = true;
  bool _isSending = false;
  String? _pdfError;

  @override
  void initState() {
    super.initState();
    _loadPdfText();
  }

  Future<void> _loadPdfText() async {
    final path = widget.localPath;

    if (path == null || path.isEmpty) {
      if (!mounted) return;

      setState(() {
        _isLoadingPdf = false;
        _pdfError = 'This document has no local PDF file available.';
      });
      return;
    }

    try {
      final text = await _pdfTextService.extractText(path);

      if (!mounted) return;

      setState(() {
        _pdfText = text;
        _isLoadingPdf = false;

        if (text.trim().isEmpty) {
          _pdfError =
          'No readable text was found in this PDF. '
              'It may contain scanned images instead of selectable text.';
        }
      });

      debugPrint('PDF text extracted: ${text.length} characters');
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _isLoadingPdf = false;
        _pdfError = 'Unable to read this PDF. Please reopen the document.';
      });

      debugPrint('PDF extraction failed: $error');
    }
  }

  Future<void> _sendMessage() async {
    final question = _messageController.text.trim();

    if (question.isEmpty || _isSending || _isLoadingPdf) {
      return;
    }

    if (_pdfText.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _pdfError ?? 'The PDF text is not available yet.',
          ),
        ),
      );
      return;
    }

    setState(() {
      messages.add({
        'type': 'user',
        'message': question,
        'time': _currentTime(),
      });

      _messageController.clear();
      _isSending = true;
    });

    _scrollToBottom();

    try {
      final answer = await _chatService.askQuestion(
        question: question,
        pdfText: _pdfText,
      );

      if (!mounted) return;

      setState(() {
        messages.add({
          'type': 'assistant',
          'message': answer,
          'time': _currentTime(),
          'sources': <Map<String, dynamic>>[],
        });
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        messages.add({
          'type': 'assistant',
          'message':
          'Sorry, I couldn’t generate an answer. '
              'Please check your connection and try again.\n\n'
              'Details: ${_friendlyError(error)}',
          'time': _currentTime(),
          'sources': <Map<String, dynamic>>[],
          'isError': true,
        });
      });
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
        _scrollToBottom();
      }
    }
  }

  String _friendlyError(Object error) {
    return error.toString().replaceFirst('Exception: ', '');
  }

  String _currentTime() {
    final now = DateTime.now();
    final hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F7),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF9F7),
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Color(0xFF11121B),
          ),
        ),
        title: Text(
          widget.documentTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF11121B),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_horiz,
              size: 20,
              color: Color(0xFF11121B),
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFE7E5E2),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            if (_isLoadingPdf)
              const LinearProgressIndicator(
                minHeight: 2,
                color: Color(0xFF6C63FF),
              ),
            Expanded(
              child: messages.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
                itemCount: messages.length + (_isSending ? 1 : 0),
                itemBuilder: (context, index) {
                  if (_isSending && index == messages.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Thinking...',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final message = messages[index];

                  if (message['type'] == 'user') {
                    return UserMessageBubble(
                      message: message['message'] as String,
                      time: message['time'] as String,
                    );
                  }

                  return AssistantMessage(
                    message: message['message'] as String,
                    time: message['time'] as String,
                    sources: message['sources'] ?? [],
                  );
                },
              ),
            ),
            ChatComposer(
              controller: _messageController,
              onSend: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final isReady = !_isLoadingPdf && _pdfText.trim().isNotEmpty;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.picture_as_pdf_outlined,
              size: 42,
              color: Color(0xFF6C63FF),
            ),
            const SizedBox(height: 16),
            Text(
              isReady
                  ? 'Chat with your PDF'
                  : _isLoadingPdf
                  ? 'Reading your PDF...'
                  : 'Unable to read this PDF',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF11121B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isReady
                  ? 'Ask a question about "${widget.documentTitle}" to get started.'
                  : _isLoadingPdf
                  ? 'Please wait while we prepare your document.'
                  : _pdfError ?? 'Please check the PDF file.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
