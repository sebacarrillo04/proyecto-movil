import 'package:alertas_tempranas/controllers/child_controller.dart';
import 'package:alertas_tempranas/models/child_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estadísticas')),
      body: Consumer<ChildController>(
        builder: (context, controller, _) {
          final List<Child> all = controller.children;
          final total = all.length;
          final desnutricion = all
              .where((c) => c.estadoNutricional == 'desnutricion')
              .length;
          final sobrepeso = all
              .where((c) => c.estadoNutricional == 'sobrepeso')
              .length;
          final saludable = all
              .where((c) => c.estadoNutricional == 'saludable')
              .length;

          if (total == 0) {
            return const Center(child: Text('No hay datos para mostrar.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Total niños: $total',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 12),
                Card(
                  child: ListTile(
                    title: const Text('Desnutrición'),
                    trailing: Text('$desnutricion'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text('Saludable'),
                    trailing: Text('$saludable'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text('Sobrepeso'),
                    trailing: Text('$sobrepeso'),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Porcentajes:',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Desnutrición: ${(desnutricion / total * 100).toStringAsFixed(1)} %',
                ),
                Text(
                  'Saludable: ${(saludable / total * 100).toStringAsFixed(1)} %',
                ),
                Text(
                  'Sobrepeso: ${(sobrepeso / total * 100).toStringAsFixed(1)} %',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
