import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesProviders, List<Movie>>((ref) {
  final fetchMoreMovie = ref.watch(moviesRepositoryProvider).getNowPlaying;

  return MoviesProviders(fetchMoreMovie: fetchMoreMovie);
});

typedef MovieCallBack = Future<List<Movie>> Function({int page});

//la clase controladora de mi StateNotifier
class MoviesProviders extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallBack fetchMoreMovie;

  MoviesProviders({required this.fetchMoreMovie}) : super([]);

  Future<void> loadNextPage() async {
    currentPage++;

    final List<Movie> movies = await fetchMoreMovie(page: currentPage);
    state = [...state, ...movies];
  }
}
