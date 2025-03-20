import 'dart:io';


import 'package:excel_retrieval/presentation/app_constants/extensions.dart';
import 'package:flutter/material.dart';

import '../../../../infrastructure/model/image_model.dart';
import 'custom_cache_image_widget.dart';


class MultiSelectImagesForForm extends StatelessWidget {
  final bool isNew;
  final List<File> imageFileList;
  final VoidCallback onImagePickerPressed;
  final Function(int) onIndexPickerPressed;
  final Function(int) onRemovePressed;
  final VoidCallback onEditImagePickerPressed;
  final Function(int) onEditIndexPickerPressed;
  final Function(int) onEditRemovePressed;
  final List<ImageModel> images;

  final int length;

  const MultiSelectImagesForForm(
      {super.key,
        required this.imageFileList,
        required this.onImagePickerPressed,
        required this.onIndexPickerPressed,
        required this.onRemovePressed,
        required this.length,
        required this.images,
        required this.isNew,
        required this.onEditImagePickerPressed,
        required this.onEditIndexPickerPressed,
        required this.onEditRemovePressed});

  @override
  Widget build(BuildContext context) {
    return isNew
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Photos",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            (imageFileList.length >= length || imageFileList.isEmpty)
                ? const SizedBox.shrink()
                : IconButton(
                onPressed: onImagePickerPressed,
                icon: const Icon(Icons.camera_enhance_rounded)),
            const Spacer(),
            Text(imageFileList.isEmpty
                ? "0/$length"
                : '${imageFileList.length}/$length')
          ],
        ),
        if (imageFileList.isEmpty) 10.height,
        (imageFileList.isEmpty)
            ? CircleAvatar(
          radius: 30,
          backgroundColor: context.colorScheme.primary.withOp(0.3),
          child: IconButton(
              onPressed: onImagePickerPressed,
              icon: const Icon(
                Icons.camera_alt_rounded,
              )),
        )
            : ListView.separated(
            separatorBuilder: (context, index) => 12.width,
            scrollDirection: Axis.horizontal,
            itemCount: imageFileList.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        onIndexPickerPressed(index);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(imageFileList[index].path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -10,
                    right: -10,
                    child: IconButton(
                        onPressed: () {
                          onRemovePressed(index);
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        )),
                  )
                ],
              ).space(
                  width: context.screenHeight * 0.2,
                  height: context.screenHeight * 0.2);
            }).space(height: context.screenHeight * 0.2),
      ],
    )
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Photos",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            if (images.length <= length)
              IconButton(
                  onPressed: onEditImagePickerPressed,
                  icon: const Icon(Icons.camera_enhance_rounded)),
            const Spacer(),
            Text('${images.length}/$length')
          ],
        ),
        if (images.isEmpty) 10.height,
        (images.isEmpty)
            ? CircleAvatar(
          backgroundColor: context.colorScheme.primary.withOp(0.3),
          radius: 30,
          child: IconButton(
              onPressed: onEditImagePickerPressed, //icon: const
              icon: const Icon(
                Icons.camera_alt_rounded,
                // color: AppConstants().appColor,
              )),
        )
            : ListView.separated(
            separatorBuilder: (context, index) => 12.width,
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        onEditIndexPickerPressed(index);
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: images[index].id == 0
                              ? images[index].imageLink == null
                              ? const SizedBox()
                              : Image.file(
                            File(images[index].imageLink!),
                            fit: BoxFit.cover,
                          )
                              : images[index].imageLink != null &&
                              !images[index].updated
                              ? CustomCacheImageWidget(
                              imageUrl:
                              images[index].imageLink!)
                              : images[index].imageLink != null &&
                              images[index].updated
                              ? Image.file(
                            File(images[index]
                                .imageLink!),
                            fit: BoxFit.cover,
                          )
                              : const SizedBox.shrink()),
                    ),
                  ),
                  Positioned(
                    top: -10,
                    right: -10,
                    child: IconButton(
                        onPressed: () {
                          onEditRemovePressed(index);
                        },
                        icon: const Icon(
                          Icons.cancel,
                          size: 18,
                          color: Colors.red,
                        )),
                  )
                ],
              ).space(
                  width: context.screenHeight * 0.2,
                  height: context.screenHeight * 0.2);
            }).space(height: context.screenHeight * 0.2),
      ],
    );
  }
}
