import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});
  Future<List<Movie>> getUpComing({int page = 1});
  Future<Movie> getMovieById(String id);
  Future<List<Movie>> getMovieRecommendation(String movieId);
  Future<List<Movie>> searchMovies(String query);
  Future<String> fetchVideo(String id);
}
