import 'package:tentwenty_test/models/movie_details_response.dart';

import '../models/movies_model.dart';
import '../models/trailer_data_response.dart';
import '/helpers/utils.dart';
import '/services/api_services.dart';
import '/services/api_urls.dart';
import 'package:flutter/cupertino.dart';

class MovieProvider extends ChangeNotifier with AppUtils {
  /// For Movies
  MoviesResponse? getMoviesModel;
  MovieDetails? getMoviesDetails;
  TrailerData? getMovieTrailerData;

  void clearMovieDetails() {
    getMoviesDetails = null;
    getMovieTrailerData = null;
    notifyListeners();
  }

  Future<bool> getMovieList() async {
    super.showProgress();
    final result = await ApiServices.getMethod(ApiUrls.getUpcomingMovies);
    super.stopProgress();
    logger.i(result);
    if (result == null) return false;

    getMoviesModel = moviesResponseFromJson(result);

    notifyListeners();
    return true;
  }

  Future<bool> getMovieDetails({required String id}) async {
    super.showProgress();
    final result = await ApiServices.getMethod("${ApiUrls.getMovieDetails}/$id");
    super.stopProgress();
    logger.i(result);
    if (result == null) return false;

    getMoviesDetails = movieDetailsFromJson(result);

    notifyListeners();
    return true;
  }

  Future<bool> getMovieTrailer({required String id}) async {
    super.showProgress();
    final result = await ApiServices.getMethod("${ApiUrls.getMovieDetails}/$id/videos");
    super.stopProgress();
    logger.i(result);
    if (result == null) return false;

    getMovieTrailerData = trailerDataFromJson(result);

    notifyListeners();
    return true;
  }
}

