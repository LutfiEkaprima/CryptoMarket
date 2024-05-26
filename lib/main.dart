import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:projectuts/Screens/home_screen.dart';
import 'package:projectuts/Screens/profile.dart';
import 'package:projectuts/Screens/settings.dart';
import 'package:provider/provider.dart';
import 'package:projectuts/controllers/drawer_controller.dart';
import 'package:projectuts/profile_data.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProfileData(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
      routes: {
        '/home': (context) =>  HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _advancedDrawerController = AdvancedDrawerController();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    _advancedDrawerController.hideDrawer();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _selectedIndex = index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DrawerControllerApp(
      advancedDrawerController: _advancedDrawerController,
      selectedIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
    );
  }
}
