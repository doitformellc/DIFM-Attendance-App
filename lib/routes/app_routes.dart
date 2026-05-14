import 'package:difm_attendance_app/features/admin/admin_dashboard.dart';
import 'package:difm_attendance_app/features/auth/controllers/screens/login_screen.dart';
import 'package:difm_attendance_app/features/auth/controllers/screens/policy_screen.dart';
import 'package:difm_attendance_app/features/hr/hr_dashboard.dart';
import 'package:flutter/material.dart';


import '../features/intern/screens/intern_dashboard.dart';



class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/policy': (context) =>
    const PolicyScreen(),
    '/login': (context) => const LoginScreen(),

    '/intern-dashboard': (context) =>
        const InternDashboard(),

    '/hr-dashboard': (context) =>
        const HRDashboard(),

    '/admin-dashboard': (context) =>
        const AdminDashboard(),
  };
}