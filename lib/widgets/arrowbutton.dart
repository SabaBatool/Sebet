import 'package:flutter/material.dart';

class ArrowButton extends StatelessWidget {
  const ArrowButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double containerSize = MediaQuery.of(context).size.width * 0.1;
    double paddingValue = MediaQuery.of(context).size.width * 0.01;

    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.only(left: paddingValue, top: paddingValue),
        child: Container(
          width: containerSize,
          height: containerSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [Color(0xFFED3237), Color(0xFFA01D20)],
              stops: [0.0106, 0.9883],
              transform: GradientRotation(181.31 * 3.14 / 180),
            ),
          ),
          child: const Icon(
            Icons.arrow_back,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}
