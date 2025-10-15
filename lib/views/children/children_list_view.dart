import 'package:flutter/material.dart';

class ChildrenListView extends StatelessWidget {
  const ChildrenListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Niños")),
      body: const Center(child: Text("Listado de todos los niños")),
    );
  }
}
