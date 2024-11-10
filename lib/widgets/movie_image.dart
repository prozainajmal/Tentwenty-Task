import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MovieImage extends StatelessWidget {
  final String? imageUrl;

  const MovieImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(Colors.black87.withOpacity(0.1), BlendMode.darken),
        child: imageUrl != null
            ? CachedNetworkImage(
          height: 200.px,
          imageUrl: imageUrl!,
          width: double.infinity,
          errorWidget: (context, url, error) => Image.asset(
            'assets/images/placeHolder.png',
            fit: BoxFit.fill,
          ),
          fit: BoxFit.fill,
          placeholder: (context, url) => Image.asset(
            'assets/images/placeHolder.png',
            fit: BoxFit.fill,
          ),
        )
            : Image.asset(
          'assets/images/placeHolder.png',
          height: 200.px,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}