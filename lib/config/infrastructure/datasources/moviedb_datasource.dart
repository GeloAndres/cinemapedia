import 'package:dio/dio.dart';
import 'package:cinemapedia/config/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/config/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/config/domain/entities/entities.dart';
import 'package:cinemapedia/config/infrastructure/models/moviedb/moviedb_responsed.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/',
      queryParameters: {
        'api_key': Enbironment.theMovieDbKey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('movie/now_playing');
    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movie = movieDbResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();

    return movie;
  }
}
