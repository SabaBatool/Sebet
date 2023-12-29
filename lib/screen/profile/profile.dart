// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/screen/auth/login_screen.dart';
import 'package:demo/screen/profile/profilemodel.dart';
import 'package:demo/screen/profile/profile_provider.dart';
import 'package:demo/screen/profile/referrals.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../widgets/customtextbutton.dart';
import '../../widgets/headerwidget.dart';
import 'editprofiledialog.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late User users;
  late bool _isLoading;
  late StreamController<ProfileModel> profileStreamController;

  @override
  void initState() {
    super.initState();
    users = FirebaseAuth.instance.currentUser!;
    _isLoading = true;
    profileStreamController = StreamController<ProfileModel>.broadcast();
    _fetchUserData();
  }

  @override
  void dispose() {
    profileStreamController.close();
    super.dispose();
  }

  Future<void> _fetchUserData() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userData =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(users.uid)
              .get();

      final profile = ProfileModel.fromMap(userData.data() ?? {});

      profileStreamController.add(profile);

      setState(() {
        Provider.of<UserProvider>(context, listen: false).update(profile);
        _isLoading = false;
      });
    } catch (e) {}
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
  }

  Future<void> _editProfile() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final initialData = {
      'firstName': userProvider.firstName,
      'email': userProvider.email,
      'phone': userProvider.phone,
      'description': userProvider.description,
    };

    showDialog(
      context: context,
      builder: (context) => EditProfileDialog(
        user: users,
        initialData: initialData,
        onUpdate: _fetchUserData,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Provider.of<UserProvider>(context),
      child: StreamBuilder<ProfileModel>(
        stream: profileStreamController.stream,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: const Color(0XFF181818),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 290,
                      color: const Color(0XFF292929),
                      child: Column(
                        children: [
                           const HeaderWidget(text: 'Profile'),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 30,
                                  top: 18,
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 3.9,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/pick.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(height: 10),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : Consumer<UserProvider>(
                            builder: (context, userProvider, _) {
                              return Column(
                                children: [
                                  buildUserData(
                                      'firstName', userProvider.firstName),
                                  const SizedBox(height: 6),
                                  buildUserData('email', userProvider.email),
                                  const SizedBox(height: 6),
                                  buildUserData('phone', userProvider.phone),
                                  const SizedBox(height: 6),
                                  buildUserData(
                                      'description', userProvider.description),
                                ],
                              );
                            },
                          ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.green,
                            ),
                            child: const Icon(Icons.edit),
                          ),
                          CustomTextButton(
                            label: 'Edit Profile',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0XFF01AA45),
                            onPressed: () {
                              _editProfile();
                            },
                          ),
                        ],
                      ),
                    ),
                    DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(15),
                      strokeWidth: 4,
                      color: const Color(0xFF292929),
                      dashPattern: const [9, 9],
                      child: Container(
                        width: 300,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'AA34X666',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0XFFED3237),
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    buildTextbutton(context),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomTextButton(
                            label: 'Logout',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: const Color(0XFFED3237),
                            onPressed: () {
                              _signOut();
                            },
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            height: 20,
                            width: 25,
                            decoration: const BoxDecoration(
                              color: Color(0xff292929),
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/arrow.png',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildUserData(String label, String value) {
    return Text(
      '$label: $value',
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: Color(0XFFFFFFFF),
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget buildTextbutton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomTextButton(
          label: 'Referral Agreement',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: const Color(0XFF01AA45),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ReferralsList(),
              ),
            );
          },
        ),
        CustomTextButton(
          label: 'My Referrals',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: const Color(0XFF01AA45),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ReferralsList(),
              ),
            );
          },
        ),
      ],
    );
  }
}
