import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projectuts/profile_data.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<ProfileData>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: const Color.fromARGB(255, 241, 231, 234),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  _selectProfileImage(context, profileData);
                },
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.2,
                  backgroundImage: profileData.profileImage != null
                      ? FileImage(profileData.profileImage!)
                      : const AssetImage('assets/images/profile.jpg') as ImageProvider,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                profileData.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                profileData.nim,
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _editProfile(context, profileData);
              },
              child: const Text("Edit Profile"),
            ),
          ],
        ),
      ),
    );
  }

  void _editProfile(BuildContext context, ProfileData profileData) {
    String newName = profileData.name;
    String newNim = profileData.nim;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Profile"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  onChanged: (value) {
                    newName = value;
                  },
                  controller: TextEditingController(text: profileData.name),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'NIM'),
                  onChanged: (value) {
                    newNim = value;
                  },
                  controller: TextEditingController(text: profileData.nim),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                profileData.updateProfile(newName, newNim);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _selectProfileImage(BuildContext context, ProfileData profileData) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileData.updateProfileImage(File(pickedFile.path));
    } else {
      print('No image selected.');
    }
  }
}
