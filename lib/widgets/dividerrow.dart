import 'dart:ffi';

import 'package:flutter/material.dart';

class DividerRow extends StatelessWidget {
  const DividerRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Color(0XFF292929),
            thickness: 2.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              _buildRectangle(10, 10),
              const SizedBox(
                width: 2.0,
              ),
              _buildRectangle(14, 14),
              const SizedBox(
                width: 2.0,
              ),
              _buildRectangle(10, 10),
            ],
          ),
        ),
        const Expanded(
          child: Divider(
            color: Color(0XFF292929),
            thickness: 1.0,
          ),
        ),
      ],
    );
  }

  Widget _buildRectangle(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.5),
        color: const Color(0XFFD9D9D9),
      ),
    );
  }
}
