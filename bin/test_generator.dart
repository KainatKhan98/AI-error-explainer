// bin/test_generator.dart
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:dotenv/dotenv.dart' show DotEnv;

void main(List<String> args) async {
  // Load .env file correctly
  final dotEnv = DotEnv()..load(); // ✅ Works for dotenv ^5.x
  final apiKey = dotEnv['OPENAI_API_KEY'];

  if (apiKey == null || apiKey.isEmpty) {
    print('❌ ERROR: OPENAI_API_KEY not found in .env file');
    exit(1);
  }

  if (args.length < 2) {
    print('Usage: dart run bin/test_generator.dart <file_path> <test_type>');
    print('test_type: unit | widget | bloc');
    exit(0);
  }

  final filePath = args[0];
  final testType = args[1];

  final file = File(filePath);
  if (!file.existsSync()) {
    print('❌ ERROR: File $filePath does not exist');
    exit(1);
  }

  final code = await file.readAsString();

  final prompt = '''
Generate a Flutter $testType test.
- Output ONLY valid Dart code.
- Include mock classes for any controllers or widgets as needed.
- If a controller uses GetX reactive types (RxInt, RxString, RxBool, RxDouble):
  - Initialize them correctly in the mock (e.g., RxInt total = 10.obs)
  - **When setting values in tests, always use .value** (e.g., controller.total.value = 10)
- Include proper imports and use flutter_test package.
- Do NOT include any comments or explanations outside of code.
$code
IMPORTANT: Only output Dart code; nothing else.
''';


  // Call the AI API
  final response = await generateTest(apiKey, prompt);

  // Determine test file path
  final testDir = Directory('test');
  if (!testDir.existsSync()) testDir.createSync();

  final fileName = p.basenameWithoutExtension(filePath) + '_test.dart';
  final testFile = File(p.join('test', fileName));
  await testFile.writeAsString(response);

  print('✅ Test generated: test/$fileName');
}

Future<String> generateTest(String apiKey, String prompt) async {
  final url = Uri.parse('https://api.groq.com/openai/v1/chat/completions');

  final response = await http.post(
    url,
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'model': 'llama-3.1-8b-instant', // fast and supported
      'messages': [
        {
          'role': 'system',
          'content':
          'You are an expert Flutter developer who writes correct Bloc, widget, and unit tests.'
        },
        {
          'role': 'user',
          'content': prompt,
        }
      ],
      'temperature': 0.2,
      'max_tokens': 1500,
    }),
  );

  if (response.statusCode != 200) {
    print('❌ Groq API error: ${response.body}');
    exit(1);
  }

  final data = jsonDecode(response.body);
  return data['choices'][0]['message']['content'];
}
