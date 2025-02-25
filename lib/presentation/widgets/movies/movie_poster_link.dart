import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/movie.dart';

class MoviePosterLink extends StatelessWidget {
  final Movie movie;
  const MoviePosterLink({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 186,
      child: FadeInUp(
        child: GestureDetector(
          onTap: () => context.push('/home/0/movie/${movie.id}'),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: Image.network(movie.posterPath),
          ),
        ),
      ),
    );
  }
}
