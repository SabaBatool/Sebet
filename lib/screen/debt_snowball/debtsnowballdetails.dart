import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/arrowbutton.dart';
import '../../widgets/customtextbutton.dart';


class DebtSnowballdetails extends StatefulWidget {
  const DebtSnowballdetails({super.key});

  @override
  State<DebtSnowballdetails> createState() => _DebtSnowballdetailsState();
}

class _DebtSnowballdetailsState extends State<DebtSnowballdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF181818),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: ArrowButton(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'GBMC',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color(0XFFFFFFFF),
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 150),
                      child: Image(
                          image: AssetImage('assets/images/CombinedShape.png')),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              PreferredSize(
                preferredSize: const Size.fromHeight(20.0),
                child: Container(
                  color: const Color(0xFF292929),
                  height: 3.0,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      buildText('DEBT'),
                      buildText('\$700'),
                    ],
                  ),
                  Container(
                    width: 2,
                    height: 90,
                    color: Color(0XFF292929),
                  ),
                  Column(
                    children: [
                      buildText('DEBT'),
                      buildText('\$700'),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                width: double.infinity,
                height: 15,
                child: ClipRRect(
                  child: LinearProgressIndicator(
                    value: 0.6,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    backgroundColor: Color(0XFF292929),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Column(
                children: [
                  buildRow('Your balance', '\$100'),
                  buildRow('Interest Rate', '0%'),
                  buildRow('Minimum Payment', '\$75'),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 2,
                color: Color(0XFF292929),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 200, top: 15),
                child: buildTextbutten(
                  const Icon(Icons.add),
                  'Add Payment',
                  16,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: double.maxFinite,
                child: ListView(
                  children: [
                    buildDaterow(
                      'SEP 2022',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildDaterow(
                      'AUG 2022',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildDaterow(
                      'SJUL 2022',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRow(String text, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0XFFFFFFFF)),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0XFFFFFFFF)),
            ),
          ),
        ],
      ),
    );
  }

  Text buildText(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 25,
          color: Color(0XFFFFFFFF),
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
          const Icon(
            Icons.arrow_forward_ios,
            color: Color(0XFFFFFFFF),
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
            onPressed: () {}),
      ],
    );
  }

  Widget buildDaterow(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          text,
          style: const TextStyle(
              color: Color(0XFFFFFFFF),
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
        const Column(
          children: [
            Text(
              'SEP 2022',
              style: TextStyle(
                  color: Color(0XFFFFFFFF),
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ),
            Text(
              '\$300',
              style: TextStyle(
                  color: Color(0XFF828282),
                  fontWeight: FontWeight.w300,
                  fontSize: 13),
            ),
          ],
        ),
        const Column(
          children: [
            Text(
              'DATE',
              style: TextStyle(
                  color: Color(0XFFFFFFFF),
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ),
            Text(
              '05-09-2022',
              style: TextStyle(
                  color: Color(0XFF828282),
                  fontWeight: FontWeight.w300,
                  fontSize: 13),
            ),
          ],
        ),
        const Column(
          children: [
            Text(
              'Time',
              style: TextStyle(
                  color: Color(0XFFFFFFFF),
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ),
            Text(
              '09:55 pm',
              style: TextStyle(
                  color: Color(0XFF828282),
                  fontWeight: FontWeight.w300,
                  fontSize: 13),
            ),
          ],
        )
      ],
    );
  }
}
