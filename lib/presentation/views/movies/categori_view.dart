import 'package:flutter/material.dart';

class CategoriView extends StatelessWidget {
  const CategoriView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
      ),
      body: const Center(
        child: Text('Cuerpo de mi Categorias'),
      ),
    );
  }
}
