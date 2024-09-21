import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:flutter/material.dart';

class MoviesSlidershow extends StatelessWidget {
  final List<Movie> movie;

  const MoviesSlidershow({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
          viewportFraction: 0.8,
          scale: 0.9,
          autoplay: true,
          itemCount: movie.length,
          itemBuilder: (context, index) => _Slide(movie: movie[index])),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
