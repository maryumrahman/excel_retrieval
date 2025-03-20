import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animations/animations.dart';
import '../../../infrastructure/services/open_ai_service.dart';
import '../../../infrastructure/services/text_recognition_service.dart';

class RecipeScreenWithAnimations extends StatefulWidget {
  @override
  _RecipeScreenWithAnimationsState createState() => _RecipeScreenWithAnimationsState();
}

class _RecipeScreenWithAnimationsState extends State<RecipeScreenWithAnimations> {
  File? _image;
  String extractedText = "";
  String processedRecipe = "";
  bool isProcessing = false;

  final ImagePicker _picker = ImagePicker();
  final TextRecognitionService _textService = TextRecognitionService();
  final OpenAIService _openAIService = OpenAIService();

  // Pick Image
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      extractText();
    }
  }

  // Extract text using OCR
  Future<void> extractText() async {
    if (_image == null) return;
    String text = await _textService.extractText(_image!);
    setState(() {
      extractedText = text;
    });
  }

  // Process extracted text with OpenAI
  Future<void> processRecipe() async {
    setState(() {
      isProcessing = true;
    });

    String response = await _openAIService.processRecipe(extractedText);

    setState(() {
      processedRecipe = response;
      isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recipe Processor", style: GoogleFonts.poppins())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Pick Image Button with Ripple Effect
            OpenContainer(
              closedBuilder: (_, openContainer) => ElevatedButton(
                onPressed: openContainer,
                child: Text("Pick Recipe Image"),
              ),
              openBuilder: (_, closeContainer) {
                pickImage();
                closeContainer();
                return Container();
              },
              transitionType: ContainerTransitionType.fadeThrough,
            ),
            SizedBox(height: 10),

            // Image Display with Fade Transition
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: _image != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(_image!, height: 200, fit: BoxFit.cover),
              )
                  : Container(),
            ),
            SizedBox(height: 10),

            // Extracted Text with Slide Transition
            extractedText.isNotEmpty
                ? TweenAnimationBuilder(
              duration: Duration(milliseconds: 500),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (_, double opacity, __) => Opacity(
                opacity: opacity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Extracted Text:", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    Text(extractedText),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            )
                : Container(),

            // Process Recipe Button with Animated Scaling
            Transform.scale(
              scale: 1.1,
              child: ElevatedButton(
                onPressed: processRecipe,
                child: Text("Process Recipe"),
              ),
            ),
            SizedBox(height: 10),

            // Loading Animation when processing
            isProcessing
                ? SpinKitWave(color: Colors.blue, size: 30.0)
                : processedRecipe.isNotEmpty
                ? FadeTransition(
              opacity: AlwaysStoppedAnimation(1.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Processed Recipe:", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  SingleChildScrollView(child: Text(processedRecipe)),
                ],
              ),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
