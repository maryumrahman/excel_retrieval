// SingleChildScrollView(
//
// child: Column(
// children: [
// const Text(
// "Photo",
// style: TextStyle(fontWeight: FontWeight.w600),
// ),
// 10.height,
//
// if (RecipeProvider.image != null) Image.file(RecipeProvider.image!) else const Icon(
// Icons.camera_enhance_rounded,
// // color: AppConstants().appColor,
// ),
//
// GestureDetector(
// onTap: () async {
// await pickImage();
// },
// child: ClipRRect(
// borderRadius: BorderRadius.circular(8),
// child: Image.file(
// File(RecipeProvider.image!.path),
// fit: BoxFit.cover,
// height: context.screenHeight * 0.2,
// width: context.screenWidth,
// ),
// ),
// ),
//
//
//
//
//
// ElevatedButton(
// onPressed: _pickImage,
// child: Text("Pick an Image"),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Text(_recognizedText),
// ),
//
// ],
// ),