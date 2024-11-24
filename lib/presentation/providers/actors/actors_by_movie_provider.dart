import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieProvider, Map<String, List<Actor>>>(
        (ref) {
  final actorsRepository = ref.watch(actorRepositoryProvider);
  return ActorsByMovieProvider(getActors: actorsRepository.getActorsByMovie);
});

typedef GetActorsCallback = Future<List<Actor>> Function(String movieID);

class ActorsByMovieProvider extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieProvider({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;
    print('Haciendo peticion HTTP');

    final movie = await getActors(movieId);
    state = {...state, movieId: movie};
  }
}
