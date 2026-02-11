import 'package:aiproject/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';


class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to HomeScreen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => HomeScreen());
    });

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image with border radius
            ClipRRect(
              borderRadius: BorderRadius.circular(20), // change radius as needed
              child: Image.asset(
                'assets/images/bunny.jpg', // your local image
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ).animate()
                .scale(duration: 1000.ms)
                .fade(duration: 1000.ms),

            const SizedBox(height: 20),

            // Text using AppTheme textTheme
            Text(
              'Welcome to AI Error Explainer',
              style: theme.textTheme.titleLarge, // uses your purple title style
              textAlign: TextAlign.center,
            ).animate().fadeIn(duration: 1500.ms),
          ],
        ),
      ),
    );
  }
}
