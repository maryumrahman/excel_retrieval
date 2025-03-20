import 'dart:io';

import 'package:excel_retrieval/infrastructure/model/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../infrastructure/model/image_model.dart';


class RecipeProvider extends ChangeNotifier{
  List<File> _imageFileList = [];
  List<ImageModel> _deletedImages = [];
  List<ImageModel> _images = [];



  Future<void> pickImages(BuildContext context) async {
    try {
      final pickedFiles = await ImagePicker().pickMultiImage();
      if (pickedFiles.length <= 10) {
        for (var pickedFile in pickedFiles) {
          _imageFileList.add(File(pickedFile.path));
          notifyListeners();
        }
      } else {
        Future.microtask(() {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('You can only select up to 3 images.'),
            ),
          );
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  removeFromImageFileList(int index) {
    _imageFileList.removeAt(index);
    notifyListeners();
  }

  removeFromImagesList(int index) {
    _images.removeAt(index);
    notifyListeners();
  }

  Future<void> pickImage(int index) async {
    try {
      final pickedFile = await ImagePicker()
          .pickImage(imageQuality: 4, source: ImageSource.gallery);
      if (pickedFile != null) {
        _imageFileList[index] = File(pickedFile.path);
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  addNewDeletedImage(ImageModel image) {
    _deletedImages.add(image);
    notifyListeners();
  }

  init(RecipeModel? recipe ){}


  List<File> get imageFileList => _imageFileList;

  set imageFileList(List<File> value) {
    _imageFileList = value;
  }

  List<ImageModel> get deletedImages => _deletedImages;

  set deletedImages(List<ImageModel> value) {
    _deletedImages = value;
  }

  List<ImageModel> get images => _images;

  set images(List<ImageModel> value) {
    _images = value;
  }


// Future<void> pickImagesEdit(BuildContext context) async {
  //   try {
  //     final pickedFiles = await ImagePicker().pickMultiImage();
  //     if (pickedFiles.length <= 10) {
  //       for (var pickedFile in pickedFiles) {
  //         _images.add(
  //             ImageModel(id: 0, productBToCId: 0, imageLink: pickedFile.path));
  //       }
  //       notifyListeners();
  //     } else {
  //       Future.microtask(() {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             content: Text('You can only select up to 3 images.'),
  //           ),
  //         );
  //       });
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
  //
  // Future<void> pickImageEdit(int index) async {
  //   try {
  //     final pickedFile =
  //     await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (pickedFile != null) {
  //       _images[index] =
  //           _images[index].copyWith(imageLink: pickedFile.path, updated: true);
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
  //
  //


}