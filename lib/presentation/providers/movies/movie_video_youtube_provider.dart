import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final videoProvider = Provider.family.autoDispose(
  (ref, String id) async {
    final responseProvider = ref.watch(moviesRepositoryProvider);
    final String idVideo = await responseProvider.fetchVideo(id);
    return idVideo;
  },
);
