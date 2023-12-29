

import 'package:flutter/cupertino.dart';

class ProfileModel   {
  final String firstName;
  final String email;
  final String phone;
  final String description;

  ProfileModel({
    required this.firstName,
    required this.email,
    required this.phone,
    required this.description,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      firstName: map['firstName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      description: map['description'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'email': email,
      'phone': phone,
      'description': description,
    };

  }
}
