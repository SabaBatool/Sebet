import 'package:demo/screen/dashboard_screen.dart';
import 'package:demo/widgets/custombutton.dart';
import 'package:demo/widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/arrowbutton.dart';
import '../../widgets/headerwidget.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  TextEditingController emailAddress = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF181818),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HeaderWidget(text: 'Monthly Budget'),
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
                child: Text(
                  'Enter an email address where you want automated reports to go. '
                  'Yours, or your accountant’s; it’s your choice. ',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Color(0XFFFFFFFF),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Image.asset('assets/images/pic.png'),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: CustomTextFormField(
                    hintText: 'Email Address', controller: emailAddress),
              ),
              const SizedBox(
                height: 30,
              ),
              buildLineDivider(),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Text(
                  'Enter an email address where you want automated reports to go. '
                  'Yours, or your accountant’s; it’s your choice. ',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Color(0XFFFFFFFF),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              buildCheckbox('QUARTELY'),
              const SizedBox(
                height: 20,
              ),
              buildCheckbox('ANNUALLY'),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
                child: PrimaryButton(
                    text: 'Save',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DashboardUser()));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildCheckbox(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.green,
          ),
          child: const Icon(Icons.check),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(text,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  color: Color(0XFFFFFFFF),
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            )),
      ],
    );
  }

  PreferredSize buildLineDivider() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(20.0),
      child: Container(
        color: const Color(0xFF292929),
        height: 2.0,
      ),
    );
  }
}
