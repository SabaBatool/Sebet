import 'package:flutter/material.dart';

class CustomVector extends StatelessWidget {
  const CustomVector({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 285,
        // height: 20, // Assuming you want a square vector
        decoration: BoxDecoration(
          color: const Color(0xFF292929),
          border: Border.all(color: const Color(0xFF292929), width: 1),
        ),
        transform: Matrix4.identity()..rotateZ(-0.0174533 * 0), // Convert degrees to radians
      ),
    );
  }
}
