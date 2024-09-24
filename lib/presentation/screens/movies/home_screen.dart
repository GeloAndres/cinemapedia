import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMovieProvier.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovie = ref.watch(nowPlayingMoviesProvider);
    final movieSliderProvider = ref.watch(moviesSlideShowProvider);
    final popularProvider = ref.watch(popularMoviesProvider);
    final upComingProvier = ref.watch(upComingMovieProvier);
    final topRatedProvider = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbard(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: [
              MoviesSlidershow(movie: movieSliderProvider),
              MovieHorizontalListview(
                movies: nowPlayingMovie,
                title: 'En Cines',
                subTitle: 'Domingo 22',
                loadNextPage:
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage,
              ),
              MovieHorizontalListview(
                movies: upComingProvier,
                title: 'Proximamente',
                subTitle: 'En este mes',
                loadNextPage:
                    ref.read(upComingMovieProvier.notifier).loadNextPage,
              ),
              MovieHorizontalListview(
                movies: popularProvider,
                title: 'Populares',
                loadNextPage:
                    ref.read(popularMoviesProvider.notifier).loadNextPage,
              ),
              MovieHorizontalListview(
                movies: topRatedProvider,
                title: 'Mejores calificadas',
                subTitle: 'Desde los inicios',
                loadNextPage:
                    ref.read(topRatedMoviesProvider.notifier).loadNextPage,
              ),
              const SizedBox(
                height: 10,
              )
            ],
          );
        }, childCount: 1)),
      ],
    );
  }
}
