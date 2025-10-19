import 'package:alertas_tempranas/controllers/child_controller.dart';
import 'package:alertas_tempranas/models/child_model.dart';
import 'package:alertas_tempranas/widgets/theme/app_colors.dart';
import 'package:alertas_tempranas/widgets/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Consumer<ChildController>(
        builder: (context, controller, _) {
          final List<Child> all = controller.children;
          final total = all.length;
          final desnutricion = all
              .where((c) => c.estadoNutricional == 'Desnutricion')
              .length;
          final sobrepeso = all
              .where((c) => c.estadoNutricional == 'Sobrepeso')
              .length;
          final saludable = all
              .where((c) => c.estadoNutricional == 'Saludable')
              .length;

          if (total == 0) {
            return const Center(
              child: Text(
                'No hay datos para mostrar.',
                style: TextStyle(fontSize: 18, color: AppColors.textLight),
              ),
            );
          }

          final double pDes = (desnutricion / total * 100).isNaN
              ? 0
              : desnutricion / total * 100;
          final double pSal = (saludable / total * 100).isNaN
              ? 0
              : saludable / total * 100;
          final double pSob = (sobrepeso / total * 100).isNaN
              ? 0
              : sobrepeso / total * 100;

          return SingleChildScrollView(
            child: Column(
              children: [
                // 🟦 Encabezado
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 50,
                    bottom: 20,
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
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'REPORTES Y ESTADISTICAS',
                            style: AppTextStyles.titleLarge.copyWith(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),

                // 📊 Datos generales
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                'Total de niños registrados',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textDark,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '$total',
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // 📈 Gráfico de pastel
                      SizedBox(
                        height: 250,
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 2,
                            centerSpaceRadius: 50,
                            sections: [
                              PieChartSectionData(
                                color: Colors.redAccent,
                                value: pDes,
                                title: '${pDes.toStringAsFixed(1)}%',
                                radius: 70,
                                titleStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              PieChartSectionData(
                                color: Colors.green,
                                value: pSal,
                                title: '${pSal.toStringAsFixed(1)}%',
                                radius: 70,
                                titleStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              PieChartSectionData(
                                color: Colors.orangeAccent,
                                value: pSob,
                                title: '${pSob.toStringAsFixed(1)}%',
                                radius: 70,
                                titleStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // 📋 Leyenda
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              _legendItem(
                                'Desnutrición',
                                desnutricion,
                                pDes,
                                Colors.redAccent,
                              ),
                              _legendItem(
                                'Saludable',
                                saludable,
                                pSal,
                                Colors.green,
                              ),
                              _legendItem(
                                'Sobrepeso',
                                sobrepeso,
                                pSob,
                                Colors.orangeAccent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _legendItem(String label, int value, double percent, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, color: AppColors.textDark),
            ),
          ),
          Text(
            '$value (${percent.toStringAsFixed(1)}%)',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
