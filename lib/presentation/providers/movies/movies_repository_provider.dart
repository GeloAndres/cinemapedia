import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repository/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(datasource: MoviedbDatasource());
});
