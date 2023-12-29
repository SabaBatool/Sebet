// ignore_for_file: use_build_context_synchronously

import 'package:demo/screen/auth/sign_up_screen.dart';
import 'package:demo/widgets/customtext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../widgets/custombutton.dart';
import '../../widgets/customtextbutton.dart';
import '../../widgets/customtextfield.dart';
import '../../widgets/logosection.dart';
import '../dashboard_screen.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login(BuildContext context) async {
    if (auth.currentUser != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardUser()),
      );
      return;
    }

    if (formKey.currentState!.validate()) {
      try {
        await auth.signInWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardUser()),
        );
        EasyLoading.dismiss();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
        } else if (e.code == 'wrong-password') {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0XFF181818),
      body: Form(
        key: formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.10,
                  vertical: screenSize.height * 0.20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LogoSection(),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  const CustomText(
                    text: 'Hello again,',
                    color: Color(0XFFED3237),
                  ),
                  const CustomText(
                    text: 'Welcome back!',
                    color: Color(0XFFFFFFFF),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                  CustomTextFormField(
                    hintText: 'Email',
                    controller: email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ('Email not found');
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  CustomTextFormField(
                    hintText: 'Password',
                    controller: password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ('phone number not found');
                      }
                    },
                  ),
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                  PrimaryButton(
                    text: 'Sign In',
                    onPressed: () {
                      login(context);
                    },
                  ),
                  buildTextbutton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextbutton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextButton(
          label: 'Forgot Password?',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: const Color(0XFFED3237),
          onPressed: () {},
        ),
        CustomTextButton(
          label: 'Signup',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: const Color(0XFF01AA45),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Signup(),
              ),
            );
          },
        ),
      ],
    );
  }
}
