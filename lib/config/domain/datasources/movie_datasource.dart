import 'package:cinemapedia/config/domain/entities/entities.dart';

abstract class MovieDatasource {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
