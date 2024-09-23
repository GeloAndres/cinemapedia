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
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovie = ref.watch(nowPlayingMoviesProvider);
    //if (nowPlayingMovie.isEmpty) return const CircularProgressIndicator();
    final movieSliderProvider = ref.watch(moviesSlideShowProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbard(),
          ),
        ),
        SliverList(delegate: SliverChildBuilderDelegate((context, index) {
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
                movies: nowPlayingMovie,
                title: 'Proximamente',
                subTitle: 'En este mes',
                loadNextPage:
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage,
              ),
              MovieHorizontalListview(
                movies: nowPlayingMovie,
                title: 'Populares',
                loadNextPage:
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage,
              ),
              MovieHorizontalListview(
                movies: nowPlayingMovie,
                title: 'Mejores calificadas',
                subTitle: 'Desde los inicios',
                loadNextPage:
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage,
              ),
              const SizedBox(
                height: 10,
              )
            ],
          );
        })),
      ],
    );
  }
}
