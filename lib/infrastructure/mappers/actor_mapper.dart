import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'https://img.freepik.com/psd-gratis/icono-3d-aplicacion-redes-sociales_23-2150049569.jpg?t=st=1732384289~exp=1732387889~hmac=27b7ffdc863b49bc051110f268447110262d2cfe86cce432cf7bf72d4d9ed055&w=826',
      character: cast.character);
}
