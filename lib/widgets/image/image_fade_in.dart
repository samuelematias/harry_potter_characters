import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageFadeIn extends StatelessWidget {
  const ImageFadeIn({
    @required this.imageURL,
    this.width = 50,
    Key key,
  }) : super(key: key);

  final String imageURL;
  final double width;

  @override
  Widget build(BuildContext context) {
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: imageURL,
      imageErrorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.image_not_supported);
      },
      fit: BoxFit.cover,
      width: width,
    );
  }
}
