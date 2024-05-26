import 'dart:io';
import 'package:flutter/material.dart';

class ProfileData with ChangeNotifier {
  String _name = "Nama Mahasiswa";
  String _nim = "NIM Mahasiswa";
  File? _profileImage;

  String get name => _name;
  String get nim => _nim;
  File? get profileImage => _profileImage;

  void updateProfile(String name, String nim) {
    _name = name;
    _nim = nim;
    notifyListeners();
  }

  void updateProfileImage(File image) {
    _profileImage = image;
    notifyListeners();
  }
}
