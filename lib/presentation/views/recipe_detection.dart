// import 'package:excel_retrieval/presentation/app_constants/extensions.dart';
// import 'package:excel_retrieval/state_management/providers/recipe_provider.dart';
// import 'package:excel_retrieval/state_management/providers/stepper_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:provider/provider.dart';
// import '../elements/custom_snackbar.dart';
// import '../elements/custom_stepper_widget.dart';
// import '../elements/image_picker.dart';
// import 'package:flutter_quill/flutter_quill.dart';
//
//
// class MakeRecipePost extends StatefulWidget {
//   @override
//   _MakeRecipePostState createState() => _MakeRecipePostState();
// }
//
// class _MakeRecipePostState extends State<MakeRecipePost> {
//
//   File? _image;
//   String _recognizedText = "Select an image to extract text";
//   QuillController _controller =QuillController.basic();
//
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   // Pick an image from the gallery or camera
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//       _processImage(_image!);
//     }
//   }
//
//   // Process image using ML Kit Text Recognition
//   Future<void> _processImage(File image) async {
//     final inputImage = InputImage.fromFile(image);
//     final textRecognizer = TextRecognizer();
//     final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
//
//     setState(() {
//       _recognizedText = recognizedText.text; // Extracted text
//     });
//
//     textRecognizer.close();
//   }
//
//
//
//   Map<String, List<String>> classifyText(String text) {
//     List<String> lines = text.split('\n'); // Split text by lines
//     List<String> ingredients = [];
//     List<String> instructions = [];
//     List<String> tips = [];
//
//     for (String line in lines) {
//       String lowerLine = line.toLowerCase().trim();
//
//       // Classify as Ingredients (if contains food quantities or common ingredients)
//       if (RegExp(r'(\d+ (cup|tbsp|tsp|oz|ml|g|kg|l))', caseSensitive: false).hasMatch(lowerLine) ||
//           lowerLine.contains("ingredients:") || lowerLine.contains("ingredient")) {
//         ingredients.add(line);
//       }
//       // Classify as Instructions (if it contains action verbs)
//       else if (RegExp(r'\b(mix|stir|bake|cook|chop|boil|heat|whisk|blend|fry|pour|add|preheat|let|serve|sprinkle)\b', caseSensitive: false).hasMatch(lowerLine)) {
//         instructions.add(line);
//       }
//       // Classify as Tips (if starts with "Tip" or "Note")
//       else if (lowerLine.startsWith("tip") || lowerLine.startsWith("note") || lowerLine.startsWith("pro tip")) {
//         tips.add(line);
//       }
//     }
//
//     return {
//       'ingredients': ingredients,
//       'instructions': instructions,
//       'tips': tips,
//     };
//   }
//
//
//
//   pickImage() async {
//     try {
//       final pickedFile =
//       await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         image = File(pickedFile.path);
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => StepperProvider()),
//         ChangeNotifierProvider(create: (_) => RecipeProvider()),
//       ],
//
//     builder: (context, child) {
//
//       _controller.addListener(() {
//         Provider.of<RecipeProvider>(context, listen: false).wordCount = countWords(_controller.document.toPlainText());
//       });
//
//     final stepperProvider = context.watch<StepperProvider>();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Text Recognition'),
//         bottom: PreferredSize(
//           preferredSize: Size(context.screenWidth, 40),
//           child: Padding(
//           padding: const EdgeInsets.only(bottom: 10.0),
//           child: CustomStepperWidget(
//           onFirstStepperTap: () {
//           stepperProvider.isOnFirstStep = true;
//           stepperProvider.isFirstStepDone = false;
//           },
//           isDone: stepperProvider.isFirstStepDone,
//           firstStepHeader: 'Job Info',
//           secondStepHeader: "Company Info")
//               .space(width: context.screenWidth),
//           ),
//         ),
//     ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){},
//         child:
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.only(bottom: 20.0, left: 16, right: 16),
//         child: SizedBox(
//           height: 56,
//           child: Consumer<RecipeProvider>(
//             builder: (c, prov, _) {
//               return ElevatedButton(
//                 onPressed: () {
//                   if (prov.imageFileList.isNotEmpty ||
//                       prov.images.isNotEmpty) {
//                     if (xey.currentState!.validate()) {
//                       prov.saveForm(context, widget.bsnsId, isNewProduct);
//                     }
//                   } else {
//                     showCustomSnackBar(context, "Please select an image");
//                   }
//                 },
//                 child: prov.isLoading
//                     ? const CircularProgressIndicator.adaptive()
//                     : widget.product != null
//                     ? AppText(
//                       text: "Update",
//                       color: context.colorScheme.surface,
//                     )
//                     : AppText(
//                       text: "Add",
//                       color: context.colorScheme.surface,
//                     ),
//               );
//             },
//           ),
//         ),
//       ),
//       body: Form(
//     key: _jobkey,
//     child: stepperProvider.isOnFirstStep
//     ?
//     Padding(
//     padding: const EdgeInsets.all(16.0),
//     child:
//     Container(
//     decoration: BoxDecoration(
//     border: Border.all(color: Colors.black),
//     borderRadius: BorderRadius.circular(12),
//     color: context.colorScheme.outline
//     ),
//     child: Column(
//     children: [
//     SingleChildScrollView(
//     scrollDirection: Axis.horizontal,
//     child: Wrap(
//     children: [
//     // QuillToolbarHistoryButton(
//     //   isUndo: true,
//     //   controller: _controller,
//     // ),
//     // QuillToolbarHistoryButton(
//     //   isUndo: false,
//     //   controller: _controller,
//     // ),
//     QuillToolbarToggleStyleButton(
//     options: const QuillToolbarToggleStyleButtonOptions(),
//     controller: _controller,
//     attribute: Attribute.bold,
//     ),
//     QuillToolbarToggleStyleButton(
//     options: const QuillToolbarToggleStyleButtonOptions(),
//     controller: _controller,
//     attribute: Attribute.italic,
//     ),
//     QuillToolbarToggleStyleButton(
//     controller: _controller,
//     attribute: Attribute.underline,
//     ),
//     QuillToolbarClearFormatButton(
//     controller: _controller,
//     ),
//     // QuillToolbarColorButton(
//     //   controller: _controller,
//     //   isBackground: false,
//     // ),
//     // QuillToolbarColorButton(
//     //   controller: _controller,
//     //   isBackground: true,
//     // ),
//     QuillToolbarSelectHeaderStyleDropdownButton(
//     controller: _controller,
//     ),
//     // QuillToolbarSelectLineHeightStyleDropdownButton(
//     //   controller: _controller,
//     // ),
//     // QuillToolbarToggleCheckListButton(
//     //   controller: _controller,
//     // ),
//     QuillToolbarToggleStyleButton(
//     controller: _controller,
//     attribute: Attribute.ol,
//     ),
//     QuillToolbarToggleStyleButton(
//     controller: _controller,
//     attribute: Attribute.ul,
//     ),
//     // QuillToolbarToggleStyleButton(
//     //   controller: _controller,
//     //   attribute: Attribute.inlineCode,
//     // ),
//     // QuillToolbarToggleStyleButton(
//     //   controller: _controller,
//     //   attribute: Attribute.blockQuote,
//     // ),
//     // QuillToolbarIndentButton(
//     //   controller: _controller,
//     //   isIncrease: true,
//     // ),
//     // QuillToolbarIndentButton(
//     //   controller: _controller,
//     //   isIncrease: false,
//     // ),
//     QuillToolbarLinkStyleButton(controller: _controller),
//     ],
//     ),
//     ),
//     Divider(),
//     Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 14.0),
//     child: Container(
//     decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(12),
//     color: context.colorScheme.outline.withOp(1)
//     ),
//     child: QuillEditor.basic(
//     controller: _controller,
//     configurations: const QuillEditorConfigurations(),
//     ).space(height: 100)
//     ),
//     ),
//
//     ],
//     ),
//     ).space(height: 400)
//
//       ):  0.height ,
//     ),
// );
//   });
// }
//
//
