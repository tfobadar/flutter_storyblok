import 'package:flutter/material.dart';

class ImageBanner extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final BoxFit? fit;

  const ImageBanner({
    super.key,
    required this.imageUrl,
    this.height = 200.0,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: fit ?? BoxFit.cover,
        ),
      ),
    );
  }
}
