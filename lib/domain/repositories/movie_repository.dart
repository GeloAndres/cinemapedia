import 'package:cinemapedia/domain/entities/entities.dart';

abstract class MovieRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
