import 'package:excel_retrieval/presentation/views/app_home_screen.dart';
import 'package:excel_retrieval/presentation/views/recipe_recognition.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio App',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        // '/excel': (context) => ExcelExtractorScreen(),
        '/recipe': (context) => RecipeRecognitionScreen(),
        // '/login': (context) => FirebaseLoginScreen(),
      },
    );
  }
}
