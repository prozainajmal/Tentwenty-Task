
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/app_colors.dart';
import '../../../providers/movie_provider.dart';
import '../../../widgets/movie_list_widget.dart';

class WatchScreen extends StatefulWidget {
  const WatchScreen({super.key});

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MovieProvider>(context, listen: false).getMovieList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, viewModel, child) {
        // Check if getMoviesModel or results is null
        if (viewModel.getMoviesModel?.results == null || viewModel.getMoviesModel!.results!.isEmpty) {
          return const Scaffold(
            body: Center(
              child: Text("No movies available", style: TextStyle(color: Colors.white)),
            ),
          );
        }
        return Scaffold(
          body: Container(
            color: backGroundColor,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: viewModel.getMoviesModel!.results!.length,
              itemBuilder: (context, index) {
                final movie = viewModel.getMoviesModel!.results![index];
                return MovieListItem(movie: movie);
              },
            ),
          ),
        );
      },
    );
  }
}

