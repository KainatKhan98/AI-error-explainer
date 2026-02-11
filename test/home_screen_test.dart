
// Import necessary packages
import 'package:aiproject/controllers/ai_controller.dart';
import 'package:aiproject/screens/error_explainer_screen.dart';
import 'package:aiproject/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Mock the AiController class
class MockAiController extends Mock implements AiController {}

// Test the HomeScreen widget
void main() {
  // Create a test widget
  Widget createTestWidget() {
    return MaterialApp(
      home: HomeScreen(),
    );
  }

  // Test the widget
  testWidgets('renders ErrorExplainerScreen', (tester) async {
    // Build the widget
    await tester.pumpWidget(createTestWidget());

    // Verify that the ErrorExplainerScreen is rendered
    expect(find.byType(ErrorExplainerScreen), findsOneWidget);
  });

  // Test the Obx widget
  testWidgets('renders Obx widget with totalTokensUsed', (tester) async {
    // Create a mock AiController
    final mockController = MockAiController();

    // Set the totalTokensUsed to a specific value
    when(mockController.totalTokensUsed).thenReturn(10 as RxInt);

    // Create a test widget with the mock controller
    final testWidget = MaterialApp(
      home: HomeScreen(key: Get.put(mockController as Key?)),
    );

    // Build the widget
    await tester.pumpWidget(testWidget);

    // Verify that the Obx widget is rendered with the correct text
    expect(find.text('Tokens: 10'), findsOneWidget);
  });
}
