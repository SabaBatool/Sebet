// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/arrowbutton.dart';
import '../../widgets/custombutton.dart';
import '../../widgets/customtext.dart';
import '../../widgets/customtextfield.dart';
import '../../widgets/dividerrow.dart';
import '../../widgets/logosection.dart';
import '../auth_model/signup2_model.dart';

class Signup2Screen extends StatefulWidget {
  final String uid;
  const Signup2Screen({Key? key, required this.uid}) : super(key: key);

  @override
  State<Signup2Screen> createState() => _Signup2ScreenState();
}

class _Signup2ScreenState extends State<Signup2Screen> {
  bool isLoading = false;
  late double padding;
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController referralcode = TextEditingController();
  TextEditingController description = TextEditingController();

  final formKey = GlobalKey<FormState>();
  Signup2Data getSignupData() {
    return Signup2Data(
      uid: widget.uid,
      city: city.text,
      state: state.text,
      zipcode: zipcode.text,
      referralCode: referralcode.text,
      description: description.text,
    );
  }

  Future saveDataToFirestore() async {
    try {
      EasyLoading.show(status: 'Saving data...');

      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(widget.uid);

      await userDoc.update(getSignupData().toMap());

      EasyLoading.dismiss();
    } catch (error) {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    padding = MediaQuery.of(context).size.width * 0.09;

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
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: padding,
                    right: padding,
                    bottom: padding,
                  ),
                  child: Column(
                    children: [
                      const CustomText(
                        text: 'A Few more  ',
                        color: Color(0XFFED3237),
                      ),
                      const CustomText(
                        text: 'details to \nbegin',
                        color: Color(0XFFFFFFFF),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      buildTextFieldRow(),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                        hintText: 'City',
                        controller: city,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the city';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      buildDiscriptionBox(),
                      const SizedBox(
                        height: 35,
                      ),
                      const DividerRow(),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomTextFormField(
                        hintText: 'Referral code (Optional)',
                        controller: referralcode,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      PrimaryButton(
                        text: 'Start',
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });

                            await saveDataToFirestore();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DashboardUser(),
                              ),
                            );
                          }
                        },
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

  Widget buildDiscriptionBox() {
    return Container(
      height: 114,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF292929),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 10,
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: TextField(
            controller: description,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color(0XFFB7B6B6),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            decoration: InputDecoration(
              hintText: 'Street address',
              hintStyle: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Color(0XFFB7B6B6),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF292929),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 18),
              child: TextFormField(
                controller: state,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: 'State',
                  hintStyle: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0XFF01AA45),
                    ),
                  ),
                  border: InputBorder.none,
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0XFF01AA45),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a state';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 18,
        ),
        Expanded(
          child: CustomTextFormField(
            hintText: 'Zip Code',
            controller: zipcode,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the zip code';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
