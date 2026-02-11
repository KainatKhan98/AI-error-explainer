import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/ai_controller.dart';
import 'error_explainer_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final c = Get.put(AiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Dev Toolkit'),
        actions: [
          Obx(
                () => Padding(
              padding: const EdgeInsets.all(12),
              child: Center(child: Text('Tokens: ${c.totalTokensUsed}')),
            ),
          ),
        ],
      ),
      body: const ErrorExplainerScreen(),
    );
  }
}
