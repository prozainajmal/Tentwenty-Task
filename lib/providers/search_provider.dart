import 'package:flutter/material.dart';
import '../helpers/utils.dart';
import '../models/movies_model.dart';
import '../services/api_services.dart';
import '../services/api_urls.dart';

class SearchProvider extends ChangeNotifier with AppUtils {
  final TextEditingController controller = TextEditingController();

  String _searchText = '';
  MoviesResponse? _moviesResponse;
  bool _isSearchSubmitted = false;

  String get searchText => _searchText;
  bool get isSearchSubmitted => _isSearchSubmitted;
  List<MovieData> get filteredMovies => _filteredMovies;

  set searchText(String value) {
    _searchText = value;
    _isSearchSubmitted = false; // Reset when search text changes
    filterMovies();
    notifyListeners();
  }

  void submitSearch() {
    _isSearchSubmitted = true;
    notifyListeners();
  }

  void clearSearch() {
    controller.clear();
    _searchText = '';
    _isSearchSubmitted = false;
    filterMovies(); // Reset search filter
    notifyListeners();
  }

  List<MovieData> _filteredMovies = [];
  int get resultCount => _filteredMovies.length;

  Future<void> getMovieList() async {
    showProgress();
    final result = await ApiServices.getMethod(ApiUrls.getUpcomingMovies);
    stopProgress();
    if (result != null) {
      _moviesResponse = moviesResponseFromJson(result);
      filterMovies();
      notifyListeners();
    }
  }

  void filterMovies() {
    _filteredMovies = (_moviesResponse?.results ?? []).where((movie) {
      return movie.title?.toLowerCase().contains(_searchText.toLowerCase()) ?? false;
    }).toList();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
