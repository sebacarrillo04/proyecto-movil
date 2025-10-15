import 'package:flutter/material.dart';
import 'core/app_routes.dart';

void main() {
  runApp(const AlertasTempranasApp());
}

class AlertasTempranasApp extends StatelessWidget {
  const AlertasTempranasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alertas Tempranas - CDI Los Clavelitos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',        // 👈 Aquí definimos la pantalla inicial
      routes: AppRoutes.routes, // 👈 Esto llama al archivo app_routes.dart
    );
  }
}
