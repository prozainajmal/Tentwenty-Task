import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tentwenty_test/helpers/app_colors.dart';
import 'package:tentwenty_test/providers/search_provider.dart';
import 'package:tentwenty_test/views/dashboard/search/widgets/search_card.dart';
import '../../../models/movies_model.dart';
import '../../../widgets/movie_list_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    // Fetches the initial movie list once the widget has been built
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SearchProvider>(context, listen: false).getMovieList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Listens to changes in SearchProvider and updates the UI accordingly
    return Consumer<SearchProvider>(
      builder: (context, searchController, child) {
        final movies = searchController.filteredMovies;

        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: primaryColor),
            backgroundColor: Colors.white,
            elevation: 0,
            title: _buildAppBarTitle(searchController),
          ),
          body: Container(
            color: backGroundColor,
            child: _buildBodyContent(searchController, movies),
          ),
        );
      },
    );
  }

  /// Builds the title section of the AppBar
  /// Displays either the search bar or the result count based on search submission state
  Widget _buildAppBarTitle(SearchProvider searchController) {
    return searchController.isSearchSubmitted
        ? Row(
      children: [
        // Shows the count of search results
        Text(
          '${searchController.resultCount} results found',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        Spacer(),
        // Clear button to reset the search
        IconButton(
          icon: Icon(Icons.clear, color: Colors.grey),
          onPressed: () {
            searchController.clearSearch();
          },
        ),
      ],
    )
        : TextField(
      controller: searchController.controller,
      onChanged: (value) {
        searchController.searchText = value;
      },
      onSubmitted: (value) {
        searchController.submitSearch();
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        hintText: 'Search...',
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(horizontal: 20.px, vertical: 10.px),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
        suffixIcon: searchController.searchText.isNotEmpty
            ? IconButton(
          icon: const Icon(Icons.close, color: Colors.grey),
          onPressed: () {
            searchController.clearSearch();
          },
        )
            : null,
      ),
      style: TextStyle(fontSize: 14.px, color: Colors.black),
    );
  }

  /// Builds the main content of the screen based on search status
  /// Shows a grid view of movies when no search term is entered,
  /// otherwise displays search results in a list
  Widget _buildBodyContent(SearchProvider searchController, List<MovieData> movies) {
    return searchController.searchText.isEmpty && !searchController.isSearchSubmitted
        ? _buildMovieGridView(movies)
        : _buildSearchResultsListView(movies);
  }

  /// Displays movies in a grid format
  Widget _buildMovieGridView(List<MovieData> movies) {
    return GridView.builder(
      padding: EdgeInsets.all(10.px),
      itemCount: movies.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.px,
        mainAxisSpacing: 10.px,
        childAspectRatio: 1.6,
      ),
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieGridItem(movie: movie);
      },
    );
  }

  /// Displays search results in a list format
  Widget _buildSearchResultsListView(List<MovieData> movies) {
    return ListView.builder(
      padding: EdgeInsets.all(10.px),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieCard(movie: movie);
      },
    );
  }
}
