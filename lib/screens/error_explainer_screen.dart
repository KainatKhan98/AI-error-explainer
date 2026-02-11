import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/ai_controller.dart';

class ErrorExplainerScreen extends StatelessWidget {
  const ErrorExplainerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AiController>();
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Paste your Flutter/Dart error here...',
              filled: true,
              fillColor: theme.inputDecorationTheme.fillColor, // white
              hintStyle: theme.inputDecorationTheme.hintStyle, // grey hint
              border: theme.inputDecorationTheme.border,
              enabledBorder: theme.inputDecorationTheme.enabledBorder,
            ),
            style: const TextStyle(
              color: Colors.black87, // <-- make text visible on white background
              fontSize: 16,
            ),
            onChanged: (v) => c.errorInput.value = v,
          ),

          const SizedBox(height: 12),
          Obx(() => ElevatedButton(
            onPressed: c.isLoading.value ? null : c.explainError,
            child: const Text('Explain Error'),
          )),
          const SizedBox(height: 16),
          Obx(() {
            if (c.isLoading.value) {
              return const CircularProgressIndicator();
            }
            return Expanded(
              child: SingleChildScrollView(
                child: Text(
                  c.errorResult.value,
                  style: Theme.of(context).textTheme.bodyMedium, // <-- use theme text color
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
