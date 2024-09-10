import 'package:cinemapedia/config/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/config/infrastructure/repository/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(datasource: MoviedbDatasource());
});
