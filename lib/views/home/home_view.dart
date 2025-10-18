import 'package:alertas_tempranas/widgets/theme/app_decorations.dart';
import 'package:alertas_tempranas/widgets/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppDecorations.mainGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🧭 Encabezado
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Alertas Tempranas", style: AppTextStyles.heading),
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.white),
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/login'),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  "CDI Los Clavelitos",
                  style: AppTextStyles.subtitle.copyWith(color: Colors.white70),
                ),

                const SizedBox(height: 28),

                // 📋 Tarjetas de opciones
                Expanded(
                  child: ListView(
                    children: [
                      _buildOptionCard(
                        context,
                        icon: Icons.child_care,
                        title: "Listado de niños",
                        subtitle: "Ver y gestionar niños registrados",
                        iconColor: Colors.blueAccent,
                        route: '/childrenList',
                      ),
                      _buildOptionCard(
                        context,
                        icon: Icons.person_add_alt_1_rounded,
                        title: "Registrar niño",
                        subtitle: "Agregar un nuevo registro",
                        iconColor: Colors.green,
                        route: '/addChild',
                      ),
                      _buildOptionCard(
                        context,
                        icon: Icons.bar_chart_rounded,
                        title: "Reportes y estadísticas",
                        subtitle: "Visualizar estado nutricional",
                        iconColor: Colors.orangeAccent,
                        route: '/stats',
                      ),
                      _buildOptionCard(
                        context,
                        icon: Icons.settings,
                        title: "Configuración y usuarios",
                        subtitle: "Gestión de permisos y respaldos",
                        iconColor: Colors.purpleAccent,
                        route: null,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // 📎 Pie de página
                Center(
                  child: Text(
                    "Desarrollado por Sebastián Carrillo y Juan Badillo",
                    style: AppTextStyles.small.copyWith(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Tarjeta reutilizable
  Widget _buildOptionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    String? route,
  }) {
    return GestureDetector(
      onTap: route != null
          ? () => Navigator.pushNamed(context, route)
          : () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Opción aún no disponible")),
            ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: AppDecorations.whiteCard,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: Icon(icon, color: iconColor, size: 30),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.title),
                  const SizedBox(height: 4),
                  Text(subtitle, style: AppTextStyles.subtitle),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Colors.black45,
            ),
          ],
        ),
      ),
    );
  }
}
