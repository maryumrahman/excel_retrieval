// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class RecipeProvider extends ChangeNotifier {
//
//
//   bool _isLoading = false;
//   List<ImagesB2C> _deletedImages = [];
//   List<File> _imageFileList = [];
//
//
//
//
//   init( ) async {
//
//
//   }
//
//   int countWords(String text) {
//     if (text.isEmpty) return 0;
//     // Split the text by spaces and remove empty entries
//     return text.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
//   }
//
//
//
//
//   List<ImagesB2C> _images = [];
//
//   List<ImagesB2C> get images => _images;
//
//   set images(List<ImagesB2C> value) {
//     _images = value;
//     notifyListeners();
//   }
//
//
//   bool get isLoading => _isLoading;
//
//   set isLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }
//
//
//
//   updateImage({
//     required String filePath,
//     required String imageId,
//     required String productId,
//     required BuildContext context,
//   }) async {}
//
//
//
//   saveForm(
//       BuildContext context,
//       int? bsnsId,
//       ) async {
//     _isLoading = true;
//
//     String? username = HiveServices.currentUser?.userName;
//
//     {
//       final updateProduct = ProductObjForEditPut.copyWith(
//         name: _prodNameController.text.trim(),
//         description: _descriptionController.text.trim(),
//         discount: double.parse(_discountController.text.trim()),
//         price: double.parse(priceController.text.trim()),
//         productCatId: selectedCategory?.key ?? 0,
//         unitQuantity: double.parse(unitQuantityController.text.trim()),
//         unit: unitController.text.trim(),
//       );
//       List<ImagesB2C> newImages = [];
//       newImages = _images.where((element) => element.id == 0).toList();
//       try {
//         final acc = await HttpServices().putProduct(
//             obj: updateProduct,
//             images: newImages.map((e) => e.imageLink.toString()).toList());
//         ProductObjForEditPut = acc;
//
//         List<ImagesB2C> updatedImages = [];
//
//         updatedImages = _images
//             .where((element) =>
//         (element.id != 0 &&
//             element.productBToCId != 0 &&
//             !_deletedImages.any((e) => e.id == element.id)) &&
//             element.updated)
//             .toList();
//         await Future.forEach(updatedImages, (element) async {
//           debugPrint("images data ${element.id}");
//           await HttpServices().updateProductImage(
//             filePath: element.imageLink.toString(),
//             productId: ProductObjForEditPut.id.toString(),
//             imageId: element.id.toString(),
//           );
//         });
//
//         await Future.forEach(_deletedImages, (element) async {
//           await HttpServices().deleteProductImage(
//             imageUrl: element.imageLink.toString(),
//             imageId: element.id.toString(),
//           );
//         });
//         _isLoading = false;
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text("${ProductObjForEditPut.name} updated successfully!"),
//         ));
//
//         Navigator.pop(context, true);
//       } catch (e) {
//         _isLoading = false;
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(e.toString()),
//         ));
//       }
//     }
//   }
//
//   removeFromImageFileList(int index) {
//     _imageFileList.removeAt(index);
//     notifyListeners();
//   }
//
//   removeFromImagesList(int index) {
//     _images.removeAt(index);
//     notifyListeners();
//   }
//
//   addNewDeletedImage(ImagesB2C image) {
//     _deletedImages.add(image);
//     notifyListeners();
//   }
//
//   List<ImagesB2C> get deletedImages => _deletedImages;
//
//   set deletedImages(List<ImagesB2C> value) {
//     _deletedImages = value;
//     notifyListeners();
//   }
//
//
//   Future<void> pickImagesEdit(BuildContext context) async {
//     try {
//       final pickedFiles = await ImagePicker().pickMultiImage();
//       if (pickedFiles.length <= 10) {
//         for (var pickedFile in pickedFiles) {
//           _images.add(
//               ImagesB2C(id: 0, productBToCId: 0, imageLink: pickedFile.path));
//         }
//         notifyListeners();
//       } else {
//         Future.microtask(() {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('You can only select up to 10 images at a time.'),
//             ),
//           );
//         });
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
//
//   Future<void> pickImageEdit(int index) async {
//     try {
//       final pickedFile =
//       await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         _images[index] =
//             _images[index].copyWith(imageLink: pickedFile.path, updated: true);
//         notifyListeners();
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
//
//
//   List<File> get imageFileList => _imageFileList;
//
//   set imageFileList(List<File> value) {
//     _imageFileList = value;
//     notifyListeners();
//   }
//
//   Future<void> pickImages(BuildContext context) async {
//     try {
//       final pickedFiles = await ImagePicker().pickMultiImage();
//       if (pickedFiles.length <= 10) {
//         for (var pickedFile in pickedFiles) {
//           _imageFileList.add(File(pickedFile.path));
//           notifyListeners();
//         }
//       } else {
//         Future.microtask(() {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('You can only select up to 3 images.'),
//             ),
//           );
//         });
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
//
//   Future<void> pickImage(int index) async {
//     try {
//       final pickedFile = await ImagePicker()
//           .pickImage(imageQuality: 4, source: ImageSource.gallery);
//       if (pickedFile != null) {
//         _imageFileList[index] = File(pickedFile.path);
//         notifyListeners();
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
// }
