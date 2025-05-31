import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo dan teks NewsWatch
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
          
                const SizedBox(width: 15),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Bewara',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "All type of news from all trusted sources for all type of people",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
