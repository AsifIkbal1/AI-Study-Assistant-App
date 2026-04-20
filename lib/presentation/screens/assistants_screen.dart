import 'package:ai_study_asssitant/core/theme.dart';
import 'package:ai_study_asssitant/presentation/screens/tool_detail_screen.dart';
import 'package:flutter/material.dart';

class AssistantsScreen extends StatelessWidget {
  const AssistantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AI Assistants",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildTabs(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildAssistantItem(
                    context,
                    "Summaries",
                    "Condense long texts into key points.",
                    Icons.article_outlined,
                    Colors.blue,
                    "Summaries",
                    "Paste your notes or text here to summarize...",
                  ),
                  _buildAssistantItem(
                    context,
                    "Essay Generator",
                    "Create well-structured essays.",
                    Icons.edit_note,
                    Colors.orange,
                    "Essay",
                    "Enter the topic for your essay...",
                  ),
                  _buildAssistantItem(
                    context,
                    "Writing Tutor",
                    "Improve your grammar and style.",
                    Icons.spellcheck,
                    Colors.green,
                    "Writing Tutor",
                    "Paste your writing here for grammar and style suggestions...",
                  ),
                  _buildAssistantItem(
                    context,
                    "Paraphraser",
                    "Rewrite text to be unique and plagiarism-free.",
                    Icons.cached,
                    Colors.teal,
                    "Paraphraser",
                    "Enter the text you want to paraphrase...",
                  ),
                  _buildAssistantItem(
                    context,
                    "Quiz Generator",
                    "Generate multiple-choice quizzes.",
                    Icons.quiz_outlined,
                    Colors.purple,
                    "Quiz",
                    "Paste your study notes to generate a quiz...",
                  ),
                  _buildAssistantItem(
                    context,
                    "Presentations",
                    "Generate comprehensive presentation outlines.",
                    Icons.slideshow,
                    Colors.red,
                    "Presentations",
                    "Enter the topic for your presentation...",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        _buildTab("All", true),
        const SizedBox(width: 10),
        _buildTab("Writing", false),
        const SizedBox(width: 10),
        _buildTab("Study", false),
      ],
    );
  }

  Widget _buildTab(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppTheme.primaryColor : AppTheme.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : AppTheme.textSecondaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAssistantItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    String type,
    String hint,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) =>
                ToolDetailScreen(title: title, hint: hint, toolType: type),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.black.withOpacity(0.03)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppTheme.textSecondaryColor.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
