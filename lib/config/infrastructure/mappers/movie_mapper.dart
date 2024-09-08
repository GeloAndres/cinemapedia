import 'package:cinemapedia/config/domain/entities/entities.dart';
import 'package:cinemapedia/config/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500/${moviedb.backdropPath}'
          : 'https://img.freepik.com/free-vector/404-error-lost-space-concept-illustration_114360-7901.jpg?t=st=1725419144~exp=1725422744~hmac=429ff39d3aecdb7e310e560ceffbae1b4810528b268fe68514ead54688594313&w=1380',
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500/${moviedb.backdropPath}'
          : 'no-poster',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount);
}
