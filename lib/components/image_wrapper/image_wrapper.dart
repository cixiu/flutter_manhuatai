import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageWrapper extends StatelessWidget {
  final double width;
  final double height;
  final AlignmentGeometry alignment;
  final String url;
  final BoxFit fit;
  final Duration fadeInDuration;

  ImageWrapper({
    this.width,
    this.height,
    this.alignment = Alignment.center,
    @required this.url,
    this.fit = BoxFit.cover,
    this.fadeInDuration = const Duration(milliseconds: 500),
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      alignment: alignment,
      placeholder: (context, url) => Image.memory(
            kTransparentImage,
            width: width,
            height: height,
          ),
      imageUrl: url,
      errorWidget: (context, url, error) => Image.asset(
            'lib/images/pic_cache.png',
            width: width,
            height: height,
          ),
      width: width,
      height: height,
      fit: fit,
      fadeInDuration: fadeInDuration,
    );
  }
}
