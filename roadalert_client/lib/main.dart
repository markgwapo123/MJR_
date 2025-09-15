import 'package:flutter/material.dart';
import 'screens/login_screen_fixed.dart';
import 'screens/register_screen_fixed.dart';
import 'screens/dashboard_screen_new.dart';
import 'screens/profile_screen_new.dart';
import 'screens/report_screen_new.dart';

void main() {
  runApp(const RoadAlertApp());
}

class RoadAlertApp extends StatelessWidget {
  const RoadAlertApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RoadAlert Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/dashboard': (_) => const DashboardScreen(),
        '/profile': (_) => const ProfileScreen(),
        '/report': (_) => const ReportScreen(),
      },
    );
  }
}
