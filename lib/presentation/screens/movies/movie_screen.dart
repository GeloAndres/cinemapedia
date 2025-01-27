import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:cinemapedia/domain/entities/movie.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';
  final String movieID;
  const MovieScreen({super.key, required this.movieID});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieID);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieID);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieID];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _CustomerMovieSlver(movie: movie),
                  childCount: 1))
        ],
      ),
    );
  }
}

final isFavoriteProvider = FutureProvider.family.autoDispose(
  (ref, int movieId) {
    final localStorageDatasource = ref.watch(localStorageRepositoryProvider);
    return localStorageDatasource.isMovieFavorite(movieId);
  },
);

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, ref) {
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      actions: [
        IconButton(
            onPressed: () async {
              await ref
                  .read(favoriteMoviesProvider.notifier)
                  .toggleFavorite(movie);
              ref.invalidate(isFavoriteProvider(movie.id));
            },
            icon: isFavoriteFuture.when(
                data: (isfavorite) => isfavorite
                    ? const Icon(
                        Icons.favorite_rounded,
                        color: Colors.red,
                      )
                    : const Icon(Icons.favorite_border),
                error: (_, __) => throw UnimplementedError(),
                loading: () => const CircularProgressIndicator()))
      ],
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();

                  return FadeIn(child: child);
                },
              ),
            ),
            //gradiente 1
            const _CustomerGRadiente(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stop: [0.8, 1.0],
              colors: [Colors.transparent, Colors.black87],
            ),
            //gradiente 2
            const _CustomerGRadiente(
                begin: Alignment.topLeft,
                stop: [0.0, 0.3],
                colors: [Colors.black87, Colors.transparent]),
            // gradiente 3
            const _CustomerGRadiente(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stop: [0.0, 0.4],
                colors: [Colors.black54, Colors.transparent]),
          ],
        ),
      ),
    );
  }
}

class _CustomerMovieSlver extends StatelessWidget {
  final Movie movie;

  const _CustomerMovieSlver({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textstyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              //Descripcion
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textstyle.titleLarge,
                    ),
                    Text(
                      movie.overview,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Fecha de estreno: ${movie.releaseDate.day.toString()}/${movie.releaseDate.month}/${movie.releaseDate.year}',
                      style:
                          const TextStyle(fontSize: 15, color: Colors.black54),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                ...movie.genreIds.map((gender) => Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Chip(
                        label: Text(gender),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ))
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        _ActorsByMovie(
          movieID: movie.id.toString(),
        ),
        const VideoCustomer(),
        const SizedBox(
          height: 30,
        ),
        const Text(
          'Recomendaciones',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 5,
        ),
        ListRecommendation(
          movieId: movie.id,
        ),
        const SizedBox(
          height: 100,
        )
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieID;

  const _ActorsByMovie({required this.movieID});
  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieID] == null) {
      return Center(
        child: Container(
            margin: const EdgeInsets.only(bottom: 200, top: 150),
            height: 100,
            width: 100,
            child: const CircularProgressIndicator(
              strokeAlign: 2,
            )),
      );
    }

    final actors = actorsByMovie[movieID]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: actors.length,
          itemBuilder: (context, index) {
            final actor = actors[index];

            return Container(
              padding: const EdgeInsets.all(8.0),
              width: 135,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInRight(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        actor.profilePath,
                        height: 180,
                        width: 135,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(actor.name),
                  Text(actor.character ?? '',
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis)),
                ],
              ),
            );
          }),
    );
  }
}

//optimizacion imagen y gradiente
class _CustomerGRadiente extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stop;
  final List<Color> colors;

  const _CustomerGRadiente(
      {this.begin = Alignment.centerLeft,
      this.end = Alignment.centerRight,
      required this.stop,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: begin, end: end, stops: stop, colors: colors))),
    );
  }
}

class VideoCustomer extends StatefulWidget {
  const VideoCustomer({super.key});

  @override
  State<StatefulWidget> createState() => _VideoCustomerState();
}

class _VideoCustomerState extends State<VideoCustomer> {
  late YoutubePlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController(
      initialVideoId: 'iWFkXUVeKFM',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void deactivate() {
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        key: UniqueKey(),
        controller: controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        onReady: () {
          print('Reproductor listo.');
        },
      ),
      builder: (context, player) {
        return Column(
          children: [
            const Text(
              "Video",
              style: TextStyle(fontSize: 18),
            ),
            player,
          ],
        );
      },
    );
  }
}

class ListRecommendation extends ConsumerWidget {
  final int movieId;
  const ListRecommendation({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    {
      final movieFuture = ref
          .watch(moviesRepositoryProvider)
          .getMovieRecommendation(movieId.toString());

      return FutureBuilder<List<Movie>>(
        future: movieFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return MovieHorizontalListview(movies: snapshot.data!);
          } else {
            return const Center(child: Text('No movies found.'));
          }
        },
      );
    }
  }
}
