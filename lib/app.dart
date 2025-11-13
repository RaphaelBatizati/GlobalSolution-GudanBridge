import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/checkin/presentation/pages/checkin_page.dart';
import 'features/habits/presentation/pages/habits_page.dart';
import 'features/goals/presentation/pages/goals_page.dart';
import 'features/habits/presentation/pages/profile_page.dart';
import 'features/insights/presentation/pages/insights_page.dart';

class GudanBridgeApp extends StatefulWidget {
  const GudanBridgeApp({super.key});

  @override
  State<GudanBridgeApp> createState() => _GudanBridgeAppState();
}

class _GudanBridgeAppState extends State<GudanBridgeApp> {
  int _index = 0;

  final _pages = const [
    CheckInPage(),
    HabitsPage(),
    GoalsPage(),
    InsightsPage(),
    ProfilePage(), // 🚀 nova aba
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GudanBridge Care',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: Scaffold(
        body: _pages[_index],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (value) {
            setState(() => _index = value);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.favorite_outline),
              selectedIcon: Icon(Icons.favorite),
              label: 'Check-in',
            ),
            NavigationDestination(
              icon: Icon(Icons.self_improvement_outlined),
              selectedIcon: Icon(Icons.self_improvement),
              label: 'Jornadas',
            ),
            NavigationDestination(
              icon: Icon(Icons.flag_outlined),
              selectedIcon: Icon(Icons.flag),
              label: 'Metas',
            ),
            NavigationDestination(
              icon: Icon(Icons.insights_outlined),
              selectedIcon: Icon(Icons.insights),
              label: 'Insights',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
