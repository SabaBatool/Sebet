import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/arrowbutton.dart';
import '../../widgets/customtextbutton.dart';
import '../../widgets/headerwidget.dart';
import '../sinking_fund/adddebtdilog.dart';
import 'debtsnowballdetails.dart';

class DebtSnowball extends StatefulWidget {
  const DebtSnowball({super.key});

  @override
  State<DebtSnowball> createState() => _DebtSnowballState();
}

class _DebtSnowballState extends State<DebtSnowball> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF181818),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HeaderWidget(text: 'Debt Snowball'),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 18, right: 18),
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
                height: 30,
              ),
              buildLineDivider(),
              const SizedBox(
                height: 10,
              ),
              buildTextbutten(
                const Icon(Icons.edit),
                '\$25',
                25,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Text(
                    'Extra amount will automatically go  to the smallest debt',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0XFFFFFFFF)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              buildLineDivider(),
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
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 15, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    build2ndText('Citibank', const Color(0XFF828282)),
                    build2ndText('\$5,000.00', const Color(0XFF828282)),
                    build2ndText('10%', const Color(0XFF828282)),
                    build2ndText('\$75.00', const Color(0XFF828282)),
                    build2ndText('\$75.00', const Color(0XFF828282)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  top: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    build2ndText(
                        'Dollar Bank \n   card', const Color(0XFF828282)),
                    build2ndText('\$8,000.00', const Color(0XFF828282)),
                    build2ndText('10%', const Color(0XFF828282)),
                    build2ndText('\$50.00', const Color(0XFF828282)),
                    build2ndText('\$50.00', const Color(0XFF828282)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  top: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    build2ndText('GBMC', const Color(0XFF828282)),
                    build2ndText('\$4,500.00', const Color(0XFF828282)),
                    build2ndText('0%', const Color(0XFF828282)),
                    build2ndText('\$150.00', const Color(0XFF828282)),
                    build2ndText('\$225.00', const Color(0XFF828282)),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 415,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFED3237),
                        Color(0xFFA01D20),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      build2ndText('Total', const Color(0XFFFFFFFF)),
                      build2ndText('\$23,855.32', const Color(0XFFFFFFFF)),
                      build2ndText('   ', const Color(0XFFFFFFFF)),
                      build2ndText('\$75.00', const Color(0XFFFFFFFF)),
                      build2ndText('\$75.00', const Color(0XFFFFFFFF)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 200, top: 15),
                child: buildTextbutten(
                  const Icon(Icons.add),
                  'Add a Debt',
                  16,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              buildDebtRow(
                  'GBMC', '\$600', const Color(0xff01AA45), '\$700', 0.8),
              buildLineDivider(),
              const SizedBox(
                height: 10,
              ),
              buildDebtRow(
                  'Citibank', '\$2500', const Color(0xffFFB800), '\$5000', 0.5),
              const SizedBox(
                height: 10,
              ),
              buildLineDivider(),
              const SizedBox(
                height: 10,
              ),
              buildDebtRow('Car loan', '\$600', const Color(0xffED3237),
                  '\$23,855', 0.3),
              buildLineDivider(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDebtRow(String text, String amount1, Color progressBarColor,
      String amount2, double progressValue) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 8, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0XFFFFFFFF),
            ),
          ),
          const SizedBox(width: 20),
          Text(
            amount1,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0XFFFFFFFF),
            ),
          ),
          SizedBox(
            width: 115,
            height: 10,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                value: progressValue,
                valueColor: AlwaysStoppedAnimation<Color>(progressBarColor),
                backgroundColor: const Color(0xff292929),
              ),
            ),
          ),
          Text(
            amount2,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0XFFFFFFFF),
            ),
          ),
          const SizedBox(width: 15),
          GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DebtSnowballdetails()));
              },
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Color(0XFFFFFFFF),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextbutten(Icon icon, String label, double fontSize) {
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
          child: icon,
        ),
        CustomTextButton(
            label: label,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: const Color(0XFF01AA45),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AddDebtDialog(),
              );
            }),
      ],
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

  Widget buildtitletext(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          textStyle: const TextStyle(
              color: Color(0XFFFFFFFF),
              fontSize: 13,
              fontWeight: FontWeight.w500)),
    );
  }

  Widget buildLineDivider() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(20.0),
      child: Container(
        color: const Color(0xFF292929),
        height: 1.0,
      ),
    );
  }
}
