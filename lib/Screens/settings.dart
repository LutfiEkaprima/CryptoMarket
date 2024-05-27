import 'package:flutter/material.dart';
import 'package:projectuts/utils.dart';
import 'package:provider/provider.dart';
import 'package:projectuts/profile_data.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showBackgroundOptions(BuildContext context) {
    showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      final profileData = Provider.of<ProfileData>(context, listen: false);

      void _changeBackground(String imagePath) {
        profileData.updateBackgroundImage(imagePath);
        Navigator.of(context).pop(); // Close the bottom sheet after selection
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Background image changed successfully!'),
          ),
        );
      }

      return Container(
        padding: const EdgeInsets.all(16.0),
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Background Image",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Image.asset('assets/images/background/bgbitcoin.jpg', width: 50, height: 50, fit: BoxFit.cover),
                    title: const Text("Gambar 1"),
                    onTap: () => _changeBackground('assets/images/background/bgbitcoin.jpg'),
                  ),
                  ListTile(
                    leading: Image.asset('assets/images/background/bgbitcoin2.jpg', width: 50, height: 50, fit: BoxFit.cover),
                    title: const Text("Gambar 2"),
                    onTap: () => _changeBackground('assets/images/background/bgbitcoin2.jpg'),
                  ),
                  ListTile(
                    leading: Image.asset('assets/images/background/bgbitcoin3.jpg', width: 50, height: 50, fit: BoxFit.cover),
                    title: const Text("Gambar 3"),
                    onTap: () => _changeBackground('assets/images/background/bgbitcoin3.jpg'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 231, 234),
      appBar: AppBar(
        title: Text(
          "Settings",
          style: textStyle(screenWidth * 0.040, Colors.black, FontWeight.w400),
        ),
        backgroundColor: const Color.fromARGB(255, 241, 231, 234),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text("Ganti Gambar Latar Belakang"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              _showBackgroundOptions(context);
            },

          ),
        ],
      ),
    );
  }
}
