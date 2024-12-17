import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//provider 1
final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesProviders, List<Movie>>((ref) {
  final fetchMoreMovie = ref.watch(moviesRepositoryProvider).getNowPlaying;

  return MoviesProviders(fetchMoreMovie: fetchMoreMovie);
});

//provider 2
final popularMoviesProvider =
    StateNotifierProvider<MoviesProviders, List<Movie>>((ref) {
  final fetchMoreMovie = ref.watch(moviesRepositoryProvider).getPopular;

  return MoviesProviders(fetchMoreMovie: fetchMoreMovie);
});

//provider 3
final upComingMovieProvier =
    StateNotifierProvider<MoviesProviders, List<Movie>>((ref) {
  final fetchMoreMovie = ref.watch(moviesRepositoryProvider).getUpComing;

  return MoviesProviders(fetchMoreMovie: fetchMoreMovie);
});

//provider 4
final topRatedMoviesProvider =
    StateNotifierProvider<MoviesProviders, List<Movie>>((ref) {
  final fetchMoreMovie = ref.watch(moviesRepositoryProvider).getTopRated;

  return MoviesProviders(fetchMoreMovie: fetchMoreMovie);
});

typedef MovieCallBack = Future<List<Movie>> Function({int page});

//la clase controladora de mi StateNotifier
class MoviesProviders extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallBack fetchMoreMovie;
  bool isLoading = false;

  MoviesProviders({required this.fetchMoreMovie}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovie(page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
  }
}
