import 'package:flutter/material.dart';
import 'package:ai_trip_planner/features/trip/presentation/screens/plan_your_adventure_screen.dart';
import 'package:ai_trip_planner/core/theme/app_theme.dart';
import 'package:ai_trip_planner/injection_container.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Trip Planner',
      theme: AppTheme.lightTheme,
      home: const PlanYourAdventureScreen(),
    );
  }
}
