import 'dart:async';
import 'package:demo/screen/profile/profilemodel.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  late ProfileModel _profile;
  late String _firstName;
  late String _email;
  late String _phone;
  late String _description;
  late StreamController<ProfileModel> _profileController;

  UserProvider() {
    _profileController = StreamController<ProfileModel>();
  }

  Stream<ProfileModel> get profileStream => _profileController.stream;

  String get firstName => _firstName;
  String get email => _email;
  String get phone => _phone;
  String get description => _description;

  void update(ProfileModel newProfile) {
    _firstName = newProfile.firstName;
    _email = newProfile.email;
    _phone = newProfile.phone;
    _description = newProfile.description;
    _profileController.add(newProfile);
    notifyListeners();
  }

  @override
  void dispose() {
    _profileController.close();
    super.dispose();
  }
}
