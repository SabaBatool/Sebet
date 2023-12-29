import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'arrowbutton.dart';

class HeaderWidget extends StatelessWidget {
  final String text;

  const HeaderWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.03),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.04),
                child: const ArrowButton(),
              ),
              SizedBox(
                width: screenWidth * 0.1,
              ),
              Text(
                text,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: const Color(0XFFFFFFFF),
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const Gap(20),
          PreferredSize(
            preferredSize: Size.fromHeight(screenHeight * 0.02),
            child: Container(
              color: const Color(0xFF292929),
              height: screenHeight * 0.002,
            ),
          ),
        ],
      ),
    );
  }
}
