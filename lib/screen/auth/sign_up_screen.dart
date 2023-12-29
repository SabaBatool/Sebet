// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/screen/auth/signup2_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';

import '../../widgets/arrowbutton.dart';
import '../../widgets/custombutton.dart';
import '../../widgets/customtext.dart';
import '../../widgets/customtextfield.dart';
import '../../widgets/logosection.dart';
import '../auth_model/signup_model.dart';




class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late double padding;
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastName = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  Future _signUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        EasyLoading.show(status: 'Signing up...');
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        String uid = userCredential.user?.uid ?? '';
        UserModel newUser = UserModel(
          uid: uid,
          firstName: firstname.text,
          lastName: lastName.text,
          email: email.text,
          phone: phone.text,
        );


        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set(newUser.toMap());

        EasyLoading.dismiss();


        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Signup2Screen(uid: uid),
          ),
        );
      } on FirebaseAuthException catch (e) {
        EasyLoading.dismiss();

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    padding = MediaQuery.of(context).size.width * 0.10;

    return Scaffold(
      backgroundColor: const Color(0XFF181818),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: ArrowButton(),
                ),
                const Gap(60),
                Padding(
                  padding: EdgeInsets.only(left: padding - 10),
                  child: const LogoSection(),
                ),
              const Gap(20),
                Padding(
                  padding: EdgeInsets.only(
                    left: padding,
                    right: padding,
                    bottom: padding,
                  ),
                  child: Column(
                    children: [
                      const CustomText(
                        text: 'Hello, ',
                        color: Color(0XFFED3237),
                      ),
                      const CustomText(
                        text: 'Signup to\nget started!',
                        color: Color(0XFFFFFFFF),
                      ),
                     const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              hintText: ' First name',
                              controller: firstname,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ('Enter Name');
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 28,
                          ),
                          Expanded(
                            child: CustomTextFormField(
                              hintText: 'Last Name',
                              controller: lastName,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return ('Enter name');
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                        hintText: 'Email',
                        controller: email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Email';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                        hintText: 'Phone',
                        controller: phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return ('Enter your Phone number');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                        hintText: 'Enter your password',
                        controller: password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                        hintText: 'Confirm password',
                        controller: confirmPassword,
                        validator: (value) {
                          if (value != password.text) {
                            return ('Password dont match');
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      PrimaryButton(
                        text: 'Sign Up',
                        onPressed: () => _signUp(context),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
