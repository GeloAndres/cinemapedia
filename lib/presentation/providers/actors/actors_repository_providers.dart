import 'package:cinemapedia/infrastructure/datasources/actor_movidb_datasource.dart';
import 'package:cinemapedia/infrastructure/repository/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(datasource: ActorMovidbDatasource());
});
