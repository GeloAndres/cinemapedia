import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLastPage || isLoading) return;
    isLoading = true;

    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovie = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoriteMovie.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline_sharp,
              size: 60,
              color: colors.primary,
            ),
            Text(
              'Ohhh noo!!',
              style: TextStyle(fontSize: 30, color: colors.primary),
            ),
            const Text(
              'No tienes peliculas favoritas',
              style: TextStyle(fontSize: 20, color: Colors.black45),
            )
          ],
        ),
      );
    }

    return Scaffold(
        body: MovieMasonry(
      loadNextPage: loadNextPage,
      movies: favoriteMovie,
    ));
  }
}
