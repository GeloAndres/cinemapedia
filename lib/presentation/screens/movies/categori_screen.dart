import 'package:flutter/material.dart';

class CategoriScreen extends StatelessWidget {
  static const name = 'categori-screen';

  const CategoriScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
      ),
      body: const Placeholder(
        child: Text('Gelonzio'),
      ),
    );
  }
}
