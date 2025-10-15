import 'package:flutter/material.dart';

class AddChildView extends StatelessWidget {
  const AddChildView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agregar Niño")),
      body: const Center(child: Text("Formulario para registrar niño")),
    );
  }
}
