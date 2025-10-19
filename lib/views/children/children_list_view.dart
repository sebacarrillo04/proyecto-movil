import 'package:alertas_tempranas/controllers/child_controller.dart';
import 'package:alertas_tempranas/models/child_model.dart';
import 'package:alertas_tempranas/widgets/theme/app_colors.dart';
import 'package:alertas_tempranas/widgets/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChildrenListView extends StatefulWidget {
  const ChildrenListView({super.key});

  @override
  State<ChildrenListView> createState() => _ChildrenListViewState();
}

class _ChildrenListViewState extends State<ChildrenListView> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // 🧭 Encabezado con gradiente y título institucional
          // 🧭 Encabezado compacto con botón de volver
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 35,
              bottom: 15,
              left: 10,
              right: 10,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryLight, AppColors.primary],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // 🔙 Botón de volver
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),

                // 🏷️ Título centrado (ajustado visualmente)
                Expanded(
                  child: Center(
                    child: Text(
                      'LISTADO DE NIÑOS',
                      style: AppTextStyles.titleLarge.copyWith(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 48,
                ), // espacio para equilibrar el icono a la derecha
              ],
            ),
          ),

          // 🔍 Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar niño...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),

          // 📋 Listado
          Expanded(
            child: Consumer<ChildController>(
              builder: (context, controller, _) {
                final List<Child> children = controller.children
                    .where(
                      (c) =>
                          c.nombre.toLowerCase().contains(_searchQuery) ||
                          c.apellido.toLowerCase().contains(_searchQuery),
                    )
                    .toList();

                if (children.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.child_care_outlined,
                          size: 80,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _searchQuery.isEmpty
                              ? 'No hay niños registrados.'
                              : 'No se encontraron coincidencias.',
                          style: AppTextStyles.subtitle,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () =>
                              Navigator.pushNamed(context, '/addChild'),
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: const Text(
                            'Agregar niño',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: children.length,
                  itemBuilder: (context, i) {
                    final c = children[i];
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 8,
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: CircleAvatar(
                          radius: 26,
                          backgroundColor: AppColors.primary.withOpacity(0.2),
                          child: Text(
                            c.nombre.isNotEmpty
                                ? c.nombre[0].toUpperCase()
                                : '?',
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        title: Text(
                          '${c.nombre} ${c.apellido}',
                          style: AppTextStyles.title.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        // 🧩 Edad y Estado uno debajo del otro
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            'Edad: ${c.edad} años \nEstado: ${c.estadoNutricional}',
                            style: AppTextStyles.subtitle.copyWith(
                              fontSize: 13,
                            ),
                          ),
                        ),
                        // Menú contextual
                        trailing: PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert, color: Colors.grey),
                          onSelected: (v) {
                            if (v == 'edit') {
                              Navigator.pushNamed(
                                context,
                                '/childDetail',
                                arguments: c.id,
                              );
                            } else if (v == 'delete') {
                              // 🧩 Diálogo rediseñado
                              showDialog(
                                context: context,
                                builder: (_) => Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.warning_amber_rounded,
                                          color: AppColors.danger,
                                          size: 60,
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          '¿Eliminar este registro?',
                                          style: AppTextStyles.title.copyWith(
                                            color: AppColors.textDark,
                                            fontSize: 18,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Esta acción no se puede deshacer.',
                                          style: AppTextStyles.subtitle
                                              .copyWith(fontSize: 13),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 24),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide(
                                                  color: Colors.grey.shade400,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 12,
                                                    ),
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text(
                                                'Cancelar',
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.danger,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 24,
                                                      vertical: 12,
                                                    ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              onPressed: () {
                                                Provider.of<ChildController>(
                                                  context,
                                                  listen: false,
                                                ).removeChild(c.id);
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Eliminar',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          itemBuilder: (_) => const [
                            PopupMenuItem(
                              value: 'edit',
                              child: Text('Ver / Editar'),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Text('Eliminar'),
                            ),
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
          ),
        ],
      ),
    );
  }
}
