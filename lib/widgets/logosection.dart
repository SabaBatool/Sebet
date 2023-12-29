import 'package:flutter/material.dart';

class LogoSection extends StatelessWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left:8, right: 100),
      child: Image(
        width: 113,
        image: AssetImage('assets/images/logo.png'),
      ),
    );
  }
}
