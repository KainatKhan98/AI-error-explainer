
import 'dart:convert';
import 'package:http/http.dart' as http;

class AiResponse {
  final String text;
  final int tokens;
  AiResponse(this.text, this.tokens);
}

class GroqService {
  static const _apiKey = 'YOUR_API_KEY_HERE';


  Future<AiResponse> explainError(String error) async {
    final res = await http.post(
      Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "llama-3.1-8b-instant",
        "messages": [
          {
            "role": "system",
            "content": "You are a senior Flutter developer. Explain errors clearly and suggest fixes."
          },
          {"role": "user", "content": error}
        ]
      }),
    );

    final data = jsonDecode(res.body);

    if (data['error'] != null) {
      return AiResponse("❌ Groq Error: ${data['error']['message']}", 0);
    }

    final choices = data['choices'];
    if (choices == null || choices.isEmpty) {
      return AiResponse("❌ No response from AI.", 0);
    }

    final text = choices[0]['message']['content'];
    final tokens = data['usage']?['total_tokens'] ?? 0;

    return AiResponse(text, tokens);
  }
}
