import 'package:cinemapedia/infrastructure/models/moviedb/video_model.dart';

class VideoMovie {
  final int id;
  final List<Video> results;

  VideoMovie({
    required this.id,
    required this.results,
  });

  factory VideoMovie.fromJson(Map<String, dynamic> json) => VideoMovie(
        id: json["id"],
        results:
            List<Video>.from(json["results"].map((x) => Video.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
