import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final movieSliderProvider = ref.watch(moviesSlideShowProvider).isEmpty;
  final popularProvider = ref.watch(popularMoviesProvider).isEmpty;
  final upComingProvier = ref.watch(upComingMovieProvier).isEmpty;
  final topRatedProvider = ref.watch(topRatedMoviesProvider).isEmpty;

  if (movieSliderProvider ||
      popularProvider ||
      upComingProvier ||
      topRatedProvider) return true;
  return false;
});
