import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText('Portfolio App',
              textStyle: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        ],
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavButton(context, "📊 Excel Extractor", '/excel'),
            _buildNavButton(context, "📸 Recipe Recognition", '/recipe'),
            // _buildNavButton(context, "🔐 Firebase Login", '/login'),
            _buildNavButton(context, "🔐 Splash Screen ", '/splashscreen'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, String text, String route) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onPressed: () => Navigator.pushNamed(context, route),
        child: Text(text, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
