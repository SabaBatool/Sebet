import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomContainer extends StatelessWidget {
  final String imagePath;
  final String text;
  final Color containerColor;
  final LinearGradient gradient;

  const CustomContainer({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.containerColor,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightContain = MediaQuery.of(context).size.height * 0.12;
    double imageSize = 80;

    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Container(
        width: double.infinity,
        height: heightContain,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Container(
                height: imageSize,
                width: imageSize,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(imageSize / 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      offset: Offset(0, 4),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(imageSize / 2),
                  child: Image.asset(imagePath),
                ),
              ),
            ),
            const SizedBox(width:20),
            Text(
              text,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
