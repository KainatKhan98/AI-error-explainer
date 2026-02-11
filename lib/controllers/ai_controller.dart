import 'package:get/get.dart';

import '../services/openai_service.dart';


class AiController extends GetxController {
  final  GroqService _service = GroqService();

  final isLoading = false.obs;
  final errorInput = ''.obs;
  final errorResult = ''.obs;
  final totalTokensUsed = 0.obs;

  Future<void> explainError() async {
    if (errorInput.value.trim().isEmpty) return;
    isLoading.value = true;
    errorResult.value = '';

    try {
      final res = await _service.explainError(errorInput.value);
      errorResult.value = res.text;
      totalTokensUsed.value += res.tokens;
    } catch (e) {
      errorResult.value = "❌ Something went wrong: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
