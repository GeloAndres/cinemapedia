import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moviesSlideShowProvider = Provider<List<Movie>>((ref) {
  final nowPlatingProvider = ref.watch(nowPlayingMoviesProvider);

  if (nowPlatingProvider.isEmpty) return [];

  return nowPlatingProvider.sublist(0, 6);
});
