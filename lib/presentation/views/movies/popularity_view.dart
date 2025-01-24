import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularityView extends StatelessWidget {
  const PopularityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Populares'),
      ),
      body: const Center(
        child: BodyCustomer(),
      ),
    );
  }
}

class BodyCustomer extends ConsumerStatefulWidget {
  const BodyCustomer({super.key});

  @override
  BodyCustomerState createState() => BodyCustomerState();
}

class BodyCustomerState extends ConsumerState<BodyCustomer> {
  bool isLastPage = false;
  bool isLoading = false;

  void loadNextPage() async {
    if (isLoading != false) return;
    isLoading = true;

    final populiMovie =
        await ref.read(popularMoviesProvider.notifier).loadNextPage();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final listaPopulares = ref.watch(popularMoviesProvider);

    if (listaPopulares.isEmpty) {
      return const CircularProgressIndicator();
    } else {
      return MovieMasonry(movies: listaPopulares, loadNextPage: loadNextPage);
    }
  }
}
