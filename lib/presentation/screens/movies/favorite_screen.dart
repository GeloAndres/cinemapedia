import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  static const name = 'favorite-screen';

  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('favorite'),
      ),
      body: const Placeholder(
        child: Text('Gelonzio'),
      ),
    );
  }
}
