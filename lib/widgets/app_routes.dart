import 'package:alertas_tempranas/views/auth/login_view.dart';
import 'package:alertas_tempranas/views/auth/register_view.dart';
import 'package:alertas_tempranas/views/children/add_child_view.dart';
import 'package:alertas_tempranas/views/children/child_detail_view.dart';
import 'package:alertas_tempranas/views/children/children_list_view.dart';
import 'package:alertas_tempranas/views/children/stats_view.dart';
import 'package:alertas_tempranas/views/home/home_view.dart';
import 'package:alertas_tempranas/views/home/welcome_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    '/welcome': (context) => const WelcomeView(),
    '/': (context) => const HomeView(),
    '/login': (context) => const LoginView(),
    '/register': (context) => const RegisterView(),
    '/childrenList': (context) => const ChildrenListView(),
    '/addChild': (context) => const AddChildView(),
    '/childDetail': (context) => const ChildDetailView(),
    '/stats': (context) => const StatsView(),
  };
}
