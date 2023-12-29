import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({

    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
  });
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF292929),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 3),
              blurRadius: 10,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: TextFormField(
            controller: controller,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color(0XFFB7B6B6),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0XFFB7B6B6),
                ),
              ),
              border: InputBorder.none,
            ),
            validator: validator,
          ),
        ),
      );
  }
}
