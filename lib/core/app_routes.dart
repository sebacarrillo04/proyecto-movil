import 'package:flutter/material.dart';
import '../views/home/home_view.dart';
import '../views/auth/login_view.dart';
import '../views/children/add_child_view.dart';
import '../views/children/children_list_view.dart';
import '../views/children/child_detail_view.dart';
import '../views/children/stats_view.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const HomeView(),
    '/login': (context) => const LoginView(),
    '/addChild': (context) => const AddChildView(),
    '/childrenList': (context) => const ChildrenListView(),
    '/childDetail': (context) => const ChildDetailView(),
    '/stats': (context) => const StatsView(),
  };
}
