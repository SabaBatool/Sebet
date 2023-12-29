import 'package:demo/screen/expense/customcategories2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/arrowbutton.dart';
import '../../widgets/customtextbutton.dart';
import '../../widgets/headerwidget.dart';


class CustomCategories extends StatefulWidget {
  const CustomCategories({super.key});

  @override
  State<CustomCategories> createState() => _CustomCategoriesState();
}

class _CustomCategoriesState extends State<CustomCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF181818),
      body: SafeArea(
        child: Column(
          children: [
            const HeaderWidget(text: 'Custom Categories'),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.green,
                    ),
                    child: const Icon(Icons.add),
                  ),
                  CustomTextButton(
                      label: 'Add Category',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0XFF01AA45),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CustomCategoriesEdit()));
                      }),
                ],
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            const Image(image: AssetImage('assets/images/opps.png')),
            const SizedBox(
              height: 10,
            ),
            Text(
              'No data Found',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Color(0XFFFFFFFF),
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLineDivider() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(20.0),
      child: Container(
        color: const Color(0XFF292929),
        height: 2.0,
      ),
    );
  }
}
