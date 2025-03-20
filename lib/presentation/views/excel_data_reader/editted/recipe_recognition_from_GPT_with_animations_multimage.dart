import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:excel_retrieval/presentation/app_constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animations/animations.dart';
import 'package:provider/provider.dart';
import '../../../../infrastructure/model/recipe_model.dart';
import '../../../../infrastructure/services/open_ai_service.dart';
import '../../../../infrastructure/services/text_recognition_service.dart';
import '../../../../state_management/providers/recipe_images_provider.dart';
import 'multiselect_images.dart';

class RecipeScreenWithAnimationsWithMultiImage extends StatefulWidget {
  @override
  _RecipeScreenWithAnimationsWithMultiImageState createState() => _RecipeScreenWithAnimationsWithMultiImageState();

  RecipeScreenWithAnimationsWithMultiImage(
      {super.key,
        this.recipe,
       });
  RecipeModel?  recipe; 
}

class _RecipeScreenWithAnimationsWithMultiImageState extends State<RecipeScreenWithAnimationsWithMultiImage> {
  File? _image;
  String extractedText = "";
  // String processedRecipe = "";
  bool isProcessing = false;
  Map<String, dynamic> processedRecipe = {
    "cutting": [],
    "mixing": [],
    "assembling": [],
    "cooking": []
  };


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

  Future<void> showValidation() async {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Entr image.'),
      ),
    );

  }

  Future<void> processRecipe() async {
    setState(() {
      isProcessing = true;
    });

    String response = await _openAIService.processRecipe2( extractedTextByOCR: "Ingredients: 1/2 pkt Tomato Ketchup 1 pound Red Meat  1/2 tspn Soya Sauce 1/2 tspn Chili Sauce 1 tspn Amchor masala 5 Tablespns oil . Steps: Take aknife and cut open the red meat fillet. Stuff it with tomata ketchup and other masalas. Marinate for 10 minutes. On the side, blend garlic and ginger together. After marination put meat in a large skillet. Put oil under it. Then add the water and cook for a half hour. Tips: Dont marinate for too long . ");
    try{
      final respo = await _openAIService.makeContentChunks(recipeText: response);

      setState(() {
        processedRecipe = respo;
        debugPrint("${processedRecipe['Mixing']}");
        isProcessing =false;
      });

    }catch(e){
      setState(() {
        isProcessing =false;
      });
      rethrow ;
    }


  }

  // Card Colors based on step
  Color getCardColor(String step) {
    switch (step) {
      case 'Cutting':
        return Colors.blue[100]!;
      case 'Mixing':
        return Colors.green[100]!;
      case 'Assembling':
        return Colors.yellow[100]!;
      case 'Cooking':
        return Colors.red[100]!;
      default:
        return Colors.grey[200]!;
    }
  }


  Widget buildStepCard({required String title,required  List steps}) {
    return steps.isEmpty
        ? Container()
        :Container(
      color: getCardColor(title),
      child: Column(
        children: [
          Text(
            title.toUpperCase(),
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),

            shrinkWrap: true,
            itemCount: steps.length,
            itemBuilder: (context, index) => ListTile(
              leading: Icon(Icons.check_circle, color: Colors.grey[700]),
              title: Text(
                steps[index],
                style: GoogleFonts.poppins(),
              ),
            ),
          )
        ],
      ),

    );


  }


  @override
  Widget build(BuildContext context) {
    final isNewProduct = widget.recipe == null;
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (_) => RecipeProvider()..init(widget.recipe ??null )),
    ],
    builder: (context, child) {
    return Scaffold(
      appBar: AppBar(title: Text("Recipe Processor", style: GoogleFonts.poppins())),
      body:Consumer<RecipeProvider>(
        builder: (c, prov, _) {
          return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),

            children: [
            MultiSelectImagesForForm(
                imageFileList: prov.imageFileList,
                onImagePickerPressed: () async {
                  await prov.pickImages(context);
                },
                onIndexPickerPressed: (i) {
                  prov.pickImage(i);
                },
                onRemovePressed: (i) {
                  prov.removeFromImageFileList(i);
                },
                length: 10,
                images: prov.images,
                isNew: isNewProduct,
                onEditImagePickerPressed: () async {
                 // await prov.pickImagesEdit(context);
                },
                onEditIndexPickerPressed: (i) {
                //  prov.pickImageEdit(i);
                },
                onEditRemovePressed: (i) {
                  if (!prov.deletedImages.any(
                          (element) => element.id == prov.images[i].id)) {
                    prov.addNewDeletedImage(prov.images[i]);
                  }
                  prov.removeFromImagesList(i);
                }),

            20.height,
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
                onPressed:
                // _image == null   ? showValidation :
                isProcessing? null:
                processRecipe,
                child: Text("Process Recipe"),
              ),
            ),
            SizedBox(height: 10),

            // Loading Animation when processing
            isProcessing
                ? SpinKitWave(color: Colors.blue, size: 30.0)
                : processedRecipe != null && processedRecipe!.isNotEmpty
                ? ListView(
              physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    processedRecipe["Cutting"]== null
                        ? 0.height
                        : buildStepCard(title: 'Cutting', steps: processedRecipe["Cutting"]),
                    processedRecipe["Mixing"]== null
                        ? 0.height
                        : buildStepCard(title: "Mixing", steps: processedRecipe["Mixing"]),
                    processedRecipe["Assembling"]== null
                        ? 0.height
                        : buildStepCard(title: "Assembling",steps: processedRecipe["Assembling"]),
                    processedRecipe["Cooking"]== null
                        ? 0.height
                        : buildStepCard(title: "Cooking", steps: processedRecipe["Cooking"]),
                  ],
                )
                :Container()

            //     : processedRecipe.isNotEmpty
            //     ? FadeTransition(
            //   opacity: AlwaysStoppedAnimation(1.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text("Processed Recipe:", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            //       SingleChildScrollView(child: Text(processedRecipe)),
            //     ],
            //   ),
            // )
            //     : Container(),
          ],
                  ),
                );
  },
),
    );}
);
  }
}
