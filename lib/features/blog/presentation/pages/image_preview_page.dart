import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImagePreviewPage extends StatelessWidget {
  static route({required String imageUrl}) => MaterialPageRoute(
    builder: (context) => ImagePreviewPage(imageUrl: imageUrl),
  );
  const ImagePreviewPage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      trackpadScrollCausesScale: true,
      child: Hero(
        tag: imageUrl,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          progressIndicatorBuilder: (context, url, progress) =>
              CircularProgressIndicator(value: progress.progress),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
