import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tentwenty_test/helpers/assets.dart';
import 'package:tentwenty_test/helpers/sized_extention.dart';
import 'package:tentwenty_test/models/movies_model.dart';
import 'package:tentwenty_test/services/api_urls.dart';

import '../../../../../helpers/app_colors.dart';
import '../../../../../providers/movie_provider.dart';
import '../../../seat selection/movie_booking_screen.dart';
import '../../../seat selection/seat_selection_screen.dart';
import '../movie trailer /movie_trailer_screen.dart';

class WatchDetailsScreen extends StatefulWidget {
  final MovieData? movieData;

  const WatchDetailsScreen({super.key, this.movieData});

  @override
  State<WatchDetailsScreen> createState() => _WatchDetailsScreenState();
}

class _WatchDetailsScreenState extends State<WatchDetailsScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.movieData?.id != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        final movieProvider = Provider.of<MovieProvider>(context, listen: false);
        movieProvider.getMovieDetails(id: widget.movieData!.id.toString());
        movieProvider.getMovieTrailer(id: widget.movieData!.id.toString());
      });
    }
  }

  @override
  void dispose() {
    Provider.of<MovieProvider>(context, listen: false).clearMovieDetails();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, viewModel, child) {
        final movieDetails = viewModel.getMoviesDetails;

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderSection(movieDetails),
                25.height,
                _buildMovieDetails(movieDetails),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderSection(movieDetails) {
    return Stack(
      children: [
        _buildMoviePoster(movieDetails),
        Positioned(bottom: 0, top: 20.h, left: 0, right: 0, child: _buildImageShadow()),
        _buildTopBar(),
        _buildBottomBar(movieDetails),
      ],
    );
  }

  Widget _buildMoviePoster(movieDetails) {
    final imageUrl = movieDetails?.belongsToCollection?.posterPath != null
        ? ApiUrls.w500Format + movieDetails!.belongsToCollection!.posterPath!
        : '';

    return Container(
      height: 55.h,
      child: CachedNetworkImage(
        height: 200.px,
        imageUrl: imageUrl,
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
      ),
    );
  }

  Widget _buildImageShadow() {
    return Image.asset(
      ImageSrc.imageShadow,
      fit: BoxFit.fill,
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: 50.px,
      left: 20.px,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.back();
              Provider.of<MovieProvider>(context, listen: false).clearMovieDetails();
            },
            child: const Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
          ),
          10.width,
          Text(
            'Watch',
            style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(movieDetails) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 2.h,
      child: Column(
        children: [
          Text(
            movieDetails?.belongsToCollection?.name.toString() ?? widget.movieData!.originalTitle.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18.px),
          ),
          10.height,
          _buildGetTicketsButton(),
          5.height,
          _buildWatchTrailerButton(),
        ],
      ),
    );
  }

  Widget _buildGetTicketsButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(65.w, 6.h),
        maximumSize: Size(65.w, 6.h),
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.px)),
      ),
      onPressed: () {
        Get.to(MovieBookingScreen());
      },
      child: Text(
        'Get Tickets',
        style: TextStyle(fontSize: 14.px, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    );
  }

  Widget _buildWatchTrailerButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: Size(65.w, 6.h),
        maximumSize: Size(65.w, 6.h),
        side: const BorderSide(color: Colors.white),
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {
        final trailerData = Provider.of<MovieProvider>(context, listen: false).getMovieTrailerData;
        if (trailerData != null && trailerData.results?.isNotEmpty == true && trailerData.results![0].key != null) {
          Get.to(MovieTrailerScreen(videoKey: trailerData.results![0].key.toString()));
        } else {
          Get.snackbar("Error", "Trailer is not available for this movie");
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.play_arrow, color: Colors.white),
          3.width,
          Text(
            'Watch Trailer',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14.px),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieDetails(movieDetails) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGenresSection(movieDetails),
          5.height,
          Image.asset(ImageSrc.divider),
          10.height,
          _buildOverviewSection(movieDetails),
        ],
      ),
    );
  }

  Widget _buildGenresSection(movieDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Genres', style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.w500, color: textColor)),
        10.height,
        movieDetails?.genres != null
            ? _buildGenreChips(movieDetails)
            : Text('No Genres Available', style: TextStyle(color: dartGreyColor)),
      ],
    );
  }

  Widget _buildGenreChips(movieDetails) {
    return Container(
      height: 5.5.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: movieDetails.genres?.length ?? 0,
        itemBuilder: (context, index) {
          return genreChipWidget(
            text: movieDetails.genres![index].name ?? 'Unknown Genre',
            color: primaryColor,
          );
        },
      ),
    );
  }

  Widget _buildOverviewSection(movieDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Overview', style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.w500, color: textColor)),
        8.height,
        Text(
          movieDetails?.overview ?? 'No Overview Available',
          maxLines: 6,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.px, color: dartGreyColor),
        ),
      ],
    );
  }

  Widget genreChipWidget({required String text, required Color color}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.px, vertical: 5.px),
      padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 2.px),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16.px)),
      height: 24.px,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.px, color: Colors.white),
        ),
      ),
    );
  }
}
