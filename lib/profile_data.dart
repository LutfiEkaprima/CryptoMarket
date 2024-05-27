import 'dart:io';
import 'package:flutter/material.dart';

class ProfileData with ChangeNotifier {
  String _name = "Lutfi Ekaprima Jannata";
  String _nim = "1152200006";
  File? _profileImage;
  String _backgroundImage = "assets/images/background/bgbitcoin.jpg"; // Default background image

  String get name => _name;
  String get nim => _nim;
  File? get profileImage => _profileImage;
  String get backgroundImage => _backgroundImage;

  void updateProfile(String name, String nim) {
    _name = name;
    _nim = nim;
    notifyListeners();
  }

  void updateProfileImage(File image) {
    _profileImage = image;
    notifyListeners();
  }

  void updateBackgroundImage(String imagePath) {
    _backgroundImage = imagePath;
    notifyListeners();
  }
}
