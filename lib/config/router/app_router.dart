import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/view.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/home/0', routes: [
  GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');

        return HomeScreen(
          pageIndex: pageIndex,
        );
      },
      routes: [
        GoRoute(
            path: 'movie/:id',
            name: MovieScreen.name,
            builder: (context, state) {
              final movieID = state.pathParameters['id'] ?? 'no-id';
              return MovieScreen(
                movieID: movieID,
              );
            })
      ]),
  GoRoute(
    path: '/categoriScreen',
    builder: (context, state) => const PopularityView(),
  ),
  GoRoute(
    path: '/favoriteScreen',
    builder: (context, state) => const FavoritesView(),
  ),
  GoRoute(path: '/', redirect: (_, __) => '/home/0')
]);
