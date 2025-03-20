import 'package:excel_retrieval/presentation/views/app_home_screen.dart';
import 'package:excel_retrieval/presentation/views/excel_data_reader/editted/recipe_recognition_from_GPT_with_animations_multimage.dart';
import 'package:excel_retrieval/presentation/views/excel_data_reader/excel_reader_view.dart';
import 'package:excel_retrieval/presentation/views/excel_data_reader/recipe_recognition_from_GPT.dart';
import 'package:excel_retrieval/presentation/views/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';


Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  await Hive.initFlutter();
  //Hive.registerAdapter(ImageModelAdapter());

  // Keep splash screen until the app is ready
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Add delay to remove splash screen
  Future.delayed(Duration(seconds: 2), () {
    FlutterNativeSplash.remove(); // Removes native splash
  });

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
        '/excel': (context) => ExcelReaderPage(),
        '/recipe': (context) => RecipeScreenWithAnimationsWithMultiImage(),
         '/splashscreen': (context) => SplashScreen(),
        // '/login': (context) => FirebaseLoginScreen(),
      },
    );
  }
}
