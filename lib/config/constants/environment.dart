import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enbironment {
  static String theMovieDbKey =
      dotenv.env['THE_MOVIEDB_KEY'] ?? 'No esta  configurado';
}
