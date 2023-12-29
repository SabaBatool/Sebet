import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/customtextbutton.dart';
import '../../widgets/headerwidget.dart';
import '../debt_snowball/debtsnowball.dart';

class DebtSnowballEmpetydata extends StatefulWidget {
  const DebtSnowballEmpetydata({super.key});

  @override
  State<DebtSnowballEmpetydata> createState() => _DebtSnowballEmpetydataState();
}

class _DebtSnowballEmpetydataState extends State<DebtSnowballEmpetydata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF181818),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HeaderWidget(text: 'Debt SnowBall'),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 18, right: 18),
                child: Text(
                  'Enter your debts here.  Add something extra that you want to throw at these debts if you can and press the button to begin your debt snowball plan!',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFFFFFFFF)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              buildLineDivider(),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
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
                      child: const Icon(Icons.add),
                    ),
                    CustomTextButton(
                        label: 'Extra Income',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0XFF01AA45),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DebtSnowball()));
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              buildLineDivider(),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildtitletext('Debt \nName'),
                    buildtitletext('  Your\n balance'),
                    buildtitletext('Interest \n   rate'),
                    buildtitletext('Minimum \npayment'),
                    buildtitletext('   Your \nPayment'),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 415,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0XFF292929),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      build2ndText('Total', const Color(0XFF454545)),
                      build2ndText('\$23,855.32', const Color(0XFF454545)),
                      build2ndText('   ', const Color(0XFF454545)),
                      build2ndText('\$75.00', const Color(0XFF454545)),
                      build2ndText('\$75.00', const Color(0XFF454545)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
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
                      child: const Icon(Icons.add),
                    ),
                    CustomTextButton(
                        label: 'Add a Debt',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0XFF01AA45),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DebtSnowball()));
                        }),
                  ],
                ),
              ),
              const Image(image: AssetImage('assets/images/opps.png')),
              const SizedBox(
                height: 10,
              ),
              Text(
                'No data Found',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color(0XFFFFFFFF),
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLineDivider() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(20.0),
      child: Container(
        color: const Color(0XFF292929),
        height: 2.0,
      ),
    );
  }

  Widget buildtitletext(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          textStyle: const TextStyle(
              color: Color(0XFF4E4E4E),
              fontSize: 13,
              fontWeight: FontWeight.w500)),
    );
  }

  Text build2ndText(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              color: color, fontSize: 13, fontWeight: FontWeight.w400)),
    );
  }
}
