import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:projectuts/utils.dart';
import 'package:provider/provider.dart';
import 'package:projectuts/Screens/home_screen.dart';
import 'package:projectuts/Screens/profile.dart';
import 'package:projectuts/Screens/settings.dart';
import 'package:projectuts/profile_data.dart';

class DrawerControllerApp extends StatefulWidget {
  final AdvancedDrawerController advancedDrawerController;
  final int selectedIndex;
  final Function(int) onItemTapped;

  const DrawerControllerApp({super.key, 
    required this.advancedDrawerController,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  _DrawerControllerAppState createState() => _DrawerControllerAppState();
}

class _DrawerControllerAppState extends State<DrawerControllerApp> {
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: const Color.fromARGB(255, 31, 30, 30),
      controller: widget.advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 500),
      animateChildDecoration: true,
      rtlOpening: false,
      openScale: 1.0,
      openRatio: 0.75,
      childDecoration: BoxDecoration(
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0xffffeae3),
            blurRadius: 12.0,
          ),
        ],
        borderRadius: BorderRadius.circular(16),
      ),
      drawer: SafeArea(
        child: SizedBox(
          width: 250,
          child: Consumer<ProfileData>(
            builder: (context, profileData, child) {
              return ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(profileData.backgroundImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    accountName: Text(
                      profileData.name,
                      style: textStyle(18, Color.fromARGB(255, 255, 255, 255), FontWeight.w600),
                    ),
                    accountEmail: Text(
                      profileData.nim,
                      style: textStyle(15, Color.fromARGB(255, 255, 255, 255), FontWeight.w500),
                    ),
                    currentAccountPicture: CircleAvatar(
                      radius: 50,
                      backgroundImage: profileData.profileImage != null
                          ? FileImage(profileData.profileImage!)
                          : const AssetImage('assets/images/profile.jpg') as ImageProvider,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home, color: Colors.white,),
                    title: Text(
                      "Home",
                      style: textStyle(18, const Color.fromARGB(255, 255, 255, 255), FontWeight.w600),
                    ),
                    onTap: () {
                      widget.onItemTapped(0);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person,color: Colors.white,),
                    title: Text(
                      "Profile",
                      style: textStyle(18, const Color.fromARGB(255, 255, 255, 255), FontWeight.w600),
                    ),
                    onTap: () {
                      widget.onItemTapped(1);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings,color: Colors.white,),
                    title: Text(
                      "Settings",
                      style: textStyle(18, const Color.fromARGB(255, 255, 255, 255), FontWeight.w600),
                    ),
                    onTap: () {
                      widget.onItemTapped(2);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Crypto Market', style: TextStyle(color: Colors.black)),
          backgroundColor: const Color.fromARGB(255, 241, 231, 234),
          leading: IconButton(
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: widget.advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
            onPressed: widget.advancedDrawerController.showDrawer,
          ),
        ),
        body: IndexedStack(
          index: widget.selectedIndex,
          children: [
            HomeScreen(),
            const ProfileScreen(),
            const SettingsScreen(),
          ],
        ),
      ),
    );
  }
}
