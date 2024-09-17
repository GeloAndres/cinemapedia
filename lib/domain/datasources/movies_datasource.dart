import 'package:cinemapedia/domain/entities/entities.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
