import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class AIService {
  Future<String> getCompletion(String prompt);
  Future<String> summarize(String text);
  Future<String> generateEssay(String topic);
  Future<String> generateQuiz(String notes);
  Future<String> generateFlashcards(String notes);
  Future<String> generateNotes(String content);
  Future<String> generateStudyPlan(String content);
  Future<String> solveDoubt(String content);
  Future<String> summarizeVideo(String content);
  Future<String> helpWithCode(String content);
}

class GroqService implements AIService {
  final String apiKey;
  final String model;

  GroqService({required this.apiKey, this.model = "llama-3.3-70b-versatile"});

  @override
  Future<String> getCompletion(String prompt) async {
    if (apiKey.isEmpty) return "Error: API Key is missing. Please add your Groq API key in settings.";
    
    try {
      final response = await http.post(
        Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": model,
          "messages": [
            {"role": "user", "content": prompt}
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        return "Error: ${response.statusCode} - ${response.body}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }

  @override
  Future<String> summarize(String text) => getCompletion("Summarize this text into key points:\n\n$text");

  @override
  Future<String> generateEssay(String topic) => getCompletion("Write a comprehensive essay on: $topic");

  @override
  Future<String> generateQuiz(String notes) => getCompletion("Create a 5-question multiple choice quiz with answers from these notes:\n\n$notes");

  @override
  Future<String> generateFlashcards(String notes) => getCompletion("Create a set of flashcards (Question and Answer format) from these notes:\n\n$notes");

  @override
  Future<String> generateNotes(String content) => getCompletion("Generate clean, structured study notes from the following content:\n\n$content");

  @override
  Future<String> generateStudyPlan(String content) => getCompletion("Create a personalized study schedule based on these exams or topics:\n\n$content");

  @override
  Future<String> solveDoubt(String content) => getCompletion("Provide a step-by-step explanation and solution for this doubt:\n\n$content");

  @override
  Future<String> summarizeVideo(String content) => getCompletion("Provide a summary and key points from this video transcript or link details:\n\n$content");

  @override
  Future<String> helpWithCode(String content) => getCompletion("Debug, explain, or convert this code as requested:\n\n$content");
}
