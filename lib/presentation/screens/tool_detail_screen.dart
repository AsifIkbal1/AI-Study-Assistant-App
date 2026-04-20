import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme.dart';
import '../../providers/ai_provider.dart';

class ToolDetailScreen extends ConsumerStatefulWidget {
  final String title;
  final String hint;
  final String toolType;

  const ToolDetailScreen({
    super.key,
    required this.title,
    required this.hint,
    required this.toolType,
  });

  @override
  ConsumerState<ToolDetailScreen> createState() => _ToolDetailScreenState();
}

class _ToolDetailScreenState extends ConsumerState<ToolDetailScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _result = "";
  bool _isLoading = false;

  void _process() async {
    final input = _inputController.text.trim();
    if (input.isEmpty) return;

    setState(() {
      _isLoading = true;
      _result = "";
    });

    final ai = ref.read(aiServiceProvider);
    String response = "";

    try {
      switch (widget.toolType) {
        case 'Summaries':
          response = await ai.summarize(input);
          break;
        case 'Essay':
          response = await ai.generateEssay(input);
          break;
        case 'Quiz':
          response = await ai.generateQuiz(input);
          break;
        case 'Flashcards':
          response = await ai.generateFlashcards(input);
          break;
        default:
          response = await ai.getCompletion(input);
      }
    } catch (e) {
      response = "Error: Please check your API key in Settings.";
    }

    if (mounted) {
      setState(() {
        _result = response;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              maxLines: 8,
              style: const TextStyle(color: AppTheme.textColor),
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: TextStyle(
                  color: AppTheme.textSecondaryColor.withOpacity(0.5),
                ),
                filled: true,
                fillColor: AppTheme.cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _process,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "Generate AI Result",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
              ),
            ),
            const SizedBox(height: 30),
            if (_result.isNotEmpty || _isLoading)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.cardColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: Colors.black.withOpacity(0.03)),
                ),
                child: MarkdownBody(
                  data: _isLoading ? "AI is thinking..." : _result,
                  styleSheet: MarkdownStyleSheet(
                    p: const TextStyle(color: AppTheme.textColor, fontSize: 15),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
