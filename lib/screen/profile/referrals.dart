import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/headerwidget.dart';

class ReferralsList extends StatefulWidget {
  const ReferralsList({super.key});

  @override
  State<ReferralsList> createState() => _ReferralsListState();
}

class _ReferralsListState extends State<ReferralsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF181818),
      body: SafeArea(
        child: Column(
          children: [
            const HeaderWidget(text: 'Referrals'),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildbox(const Color(0XFF01AA45)),
                const SizedBox(
                  width: 10,
                ),
                buildBoxText('Active'),
                const SizedBox(
                  width: 30,
                ),
                buildbox(const Color(0XFFED3237)),
                const SizedBox(
                  width: 10,
                ),
                buildBoxText('Active'),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            buildDaterow('User Name', const Color(0XFF01AA45)),
            const SizedBox(
              height: 15,
            ),
            buildDaterow('User Name', const Color(0XFF01AA45)),
            const SizedBox(
              height: 15,
            ),
            buildDaterow('User Name', const Color(0XFFED3237)),
          ],
        ),
      ),
    );
  }

  Widget buildBoxText(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0XFFFFFFFF)),
      ),
    );
  }

  Widget buildbox(Color color) {
    return Container(
      width: 17,
      height: 17,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }



  Widget buildDaterow(String text, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          text,
          style: TextStyle(
              color: color, fontWeight: FontWeight.w700, fontSize: 16),
        ),
        const Column(
          children: [
            Text(
              'EMAIL',
              style: TextStyle(
                  color: Color(0XFFFFFFFF),
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ),
            Text(
              'email@email.com',
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
              'JOINING DATE',
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
      ],
    );
  }
}
