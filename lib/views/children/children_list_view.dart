import 'package:alertas_tempranas/controllers/child_controller.dart';
import 'package:alertas_tempranas/models/child_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChildrenListView extends StatelessWidget {
  const ChildrenListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de niños'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/addChild'),
          ),
        ],
      ),
      body: Consumer<ChildController>(
        builder: (context, controller, _) {
          final List<Child> children = controller.children;
          if (children.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No hay niños registrados.'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/addChild'),
                    child: const Text('Agregar primero'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: children.length,
            itemBuilder: (context, i) {
              final c = children[i];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(c.nombre.isNotEmpty ? c.nombre[0] : '?'),
                  ),
                  title: Text('${c.nombre} ${c.apellido}'),
                  subtitle: Text(
                    'Edad: ${c.edad} • Estado: ${c.estadoNutricional}',
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (v) {
                      if (v == 'edit') {
                        Navigator.pushNamed(
                          context,
                          '/childDetail',
                          arguments: c.id,
                        );
                      } else if (v == 'delete') {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Confirmar'),
                            content: const Text('Eliminar este registro?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Provider.of<ChildController>(
                                    context,
                                    listen: false,
                                  ).removeChild(c.id);
                                  Navigator.pop(context);
                                },
                                child: const Text('Eliminar'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(value: 'edit', child: Text('Ver / Editar')),
                      PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                    ],
                  ),
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/childDetail',
                    arguments: c.id,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
