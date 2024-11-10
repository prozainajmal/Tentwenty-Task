import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MovieTitle extends StatelessWidget {
  final String title;

  const MovieTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20.px,
      left: 20.px,
      right: 120.px,
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18.px),
      ),
    );
  }
}

class MovieTitleForGrid extends StatelessWidget {
  final String title;

  const MovieTitleForGrid({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20.px,
      left: 10.px,
      right: 10.px,
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14.px),
      ),
    );
  }
}
