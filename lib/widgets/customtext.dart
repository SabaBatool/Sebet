import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;

  const CustomText({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: color,
              fontSize: 40.0,
              fontWeight: FontWeight.w500,
              height: 1.10,
            ),
          ),
        ),
    );
  }
}
