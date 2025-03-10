// import 'dart:io';
//
// import 'package:excel_retrieval/presentation/app_constants/extensions.dart';
// import 'package:excel_retrieval/state_management/providers/recipe_provider.dart';
// import 'package:flutter/material.dart';
//
// if (RecipeProvider.image != null) {
//
//   return GestureDetector(
//     onTap: () async {
//       await masjidFormProvider.pickImage();
//     },
//     child: ClipRRect(
//       borderRadius: BorderRadius.circular(8),
//       child: Image.file(
//         File(masjidFormProvider.image!.path),
//         fit: BoxFit.cover,
//         height: context.screenHeight * 0.2,
//         width: context.screenWidth,
//       ),
//     ),
//   );
// }
//
