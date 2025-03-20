import 'package:cached_network_image/cached_network_image.dart';
import 'package:excel_retrieval/presentation/app_constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../configurations/utilities.dart';

class CustomCacheImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final String? asset;
  final bool isPlaceholder;
  final BoxFit? fit;

  const CustomCacheImageWidget(
      {super.key,
        required this.imageUrl,
        this.height,
        this.width,
        this.asset,
        this.isPlaceholder = true,
        this.fit});

  @override
  Widget build(BuildContext context) {

    final utils = Utils();
    return imageUrl != null
        ? CachedNetworkImage(
      height: height,
      width: width,

      fit: fit ?? BoxFit.cover,
      imageUrl: "${utils.makeImageUrl(imageUrl)}",
      placeholder: (context, url) => isPlaceholder == true
          ? Container(
        color: context.colorScheme.outline,
      )
          .animate(onPlay: (controller) => controller.repeat())
          .shimmer(
          duration: 1200.ms, color: context.colorScheme.surface)
          : const Center(child: CircularProgressIndicator.adaptive()),
      errorWidget: (context, url, error) => Image.asset(
        asset ??'assets/background.jpg',
        fit: fit??BoxFit.cover,
        height: height,
        width: width,
      ),
    )
        : Image.asset(
      asset ?? 'assets/background.jpg',
      fit: fit?? BoxFit.cover,
      height: height,
      width: width,
    );
  }
}
