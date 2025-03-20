import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../infrastructure/services/open_ai_service.dart';
import '../../../infrastructure/services/text_recognition_service.dart';

class RecipeScreen extends StatefulWidget {
  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  File? _image;
  String extractedText = "Extracted text will appear here";
  String processedRecipe = "Processed recipe will appear here";

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
    String response = await _openAIService.processRecipe(extractedText);
    setState(() {
      processedRecipe = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recipe Processor")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: pickImage,
              child: Text("Pick Recipe Image"),
            ),
            SizedBox(height: 10),
            _image != null ? Image.file(_image!) : Container(),
            SizedBox(height: 10),
            Text("Extracted Text:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(extractedText),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: processRecipe,
              child: Text("Process Recipe"),
            ),
            SizedBox(height: 10),
            Text("Processed Recipe:", style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: SingleChildScrollView(child: Text(processedRecipe)),
            ),
          ],
        ),
      ),
    );
  }
}
