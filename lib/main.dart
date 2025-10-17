import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app_routes.dart';
import 'controllers/child_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChildController()..loadSampleData(),
        ),
      ],
      child: const AlertasTempranasApp(),
    ),
  );
}

class AlertasTempranasApp extends StatelessWidget {
  const AlertasTempranasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alertas Tempranas - CDI Los Clavelitos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/welcome',
      routes: AppRoutes.routes,
    );
  }
}
