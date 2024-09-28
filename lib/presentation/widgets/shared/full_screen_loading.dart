import 'package:flutter/material.dart';

class FullScreenLoading extends StatelessWidget {
  const FullScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final message = <String>[
      'Estan llegando las peliculas',
      'Organizando todo',
      'barriendo el local',
      'La familia es primero',
      'Esto esta demorando demaciado 🤨'
    ];

    Stream<String> getLoadingMessage() {
      return Stream.periodic(const Duration(milliseconds: 1200), (step) {
        return message[step];
      }).take(message.length);
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere por favor'),
          const SizedBox(
            height: 20,
          ),
          const CircularProgressIndicator(
            strokeAlign: 2,
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
              stream: getLoadingMessage(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('');

                return Text(snapshot.data!);
              })
        ],
      ),
    );
  }
}
