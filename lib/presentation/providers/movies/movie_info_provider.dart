import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieInfoProvider, Map<String, Movie>>((ref) {
  final movieRepository = ref.watch(moviesRepositoryProvider);
  return MovieInfoProvider(getMovie: movieRepository.getMovieById);
});

typedef GetMovieCallback = Future<Movie> Function(String movieID);

class MovieInfoProvider extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;

  MovieInfoProvider({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    print('Haciendo peticion HTTP');

    final movie = await getMovie(movieId);
    state = {...state, movieId: movie};
  }
}
