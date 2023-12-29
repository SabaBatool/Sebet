import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Image(width: 209, image: AssetImage('assets/images/logo.png')),
    );
  }
}
