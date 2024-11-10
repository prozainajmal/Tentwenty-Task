import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tentwenty_test/widgets/shadow_widget.dart';

import '../services/api_urls.dart';
import '../views/dashboard/watch section/components/watch details /watch_details_screen.dart';
import 'movie_image.dart';
import 'movie_title_widget.dart';

class MovieListItem extends StatelessWidget {
  final dynamic movie;

  const MovieListItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backdropPath = movie.backdropPath;
    final imageUrl = backdropPath != null ? ApiUrls.imageUrl + backdropPath : null;

    return InkWell(
      onTap: () {
        Get.to(WatchDetailsScreen(movieData: movie));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.px, vertical: 10.px),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.px),
        ),
        child: Stack(
          children: [
            MovieImage(imageUrl: imageUrl),
            const PositionedShadow(),
            MovieTitle(title: movie.originalTitle ?? "Unknown Title"),
          ],
        ),
      ),
    );
  }
}

class MovieGridItem extends StatelessWidget {
  final dynamic movie;

  const MovieGridItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backdropPath = movie.backdropPath;
    final imageUrl = backdropPath != null ? ApiUrls.imageUrl + backdropPath : null;

    return InkWell(
      onTap: () {
        Get.to(WatchDetailsScreen(movieData: movie));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.px),
        ),
        child: Stack(
          children: [
            MovieImage(imageUrl: imageUrl),
            const PositionedShadow(),
            MovieTitleForGrid(title: movie.originalTitle ?? "Unknown Title"),
          ],
        ),
      ),
    );
  }
}
