import 'package:flutter/material.dart';

class ChildDetailView extends StatelessWidget {
  const ChildDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalle del Niño")),
      body: const Center(
        child: Text("Aquí se mostrarán los datos del niño"),
      ),
    );
  }
}
