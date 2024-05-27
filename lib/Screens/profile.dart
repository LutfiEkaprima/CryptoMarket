import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projectuts/profile_data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectuts/utils.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<ProfileData>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 231, 234),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 231, 234),
        title: Text(
          "Profile",
          style: textStyle(screenWidth * 0.040, Colors.black, FontWeight.w400),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    _selectProfileImage(context, profileData);
                  },
                  child: CircleAvatar(
                    radius: screenWidth * 0.2,
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
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  profileData.nim,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _editProfile(context, profileData);
                },
                child: Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: screenWidth * 0.04),
                ),
              ),
            ],
          ),
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
    }
  }
}
