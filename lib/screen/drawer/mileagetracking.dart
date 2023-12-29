import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/arrowbutton.dart';
import '../../widgets/headerwidget.dart';

class MileageTracking extends StatefulWidget {
  const MileageTracking({super.key});

  @override
  State<MileageTracking> createState() => _MileageTrackingState();
}

class _MileageTrackingState extends State<MileageTracking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF181818),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const HeaderWidget(text: 'Mileage Tracking'),
              const SizedBox(
                height: 30,
              ),
              Text(
                'September',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFED3237)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              buildLineDivider(),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: buildTotalMileagetext('2000 m')),
                    const SizedBox(width: 15),
                    builddivider(),
                    const SizedBox(width: 20),
                    Expanded(child: buildTotalMileagetext('1200 m')),
                    const SizedBox(width: 15),
                    builddivider(),
                    const SizedBox(width: 15),
                    Expanded(child: buildTotalMileagetext('200 m')),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              buildLineDivider(),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Start your mileage tracking',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Container(
                      width: 90.0,
                      height: 90.29,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF01AA45), Color(0xFF00702D)],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.0),
                          child: Container(
                            width: 40.55,
                            height: 46.55,
                            decoration:  const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomLeft,
                                colors: [Color(0xFF01AA45), Color(0xFF00702D)],
                              ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              height: 38,
                              width: 38,
                              decoration: BoxDecoration(
                                color: const Color(0XFF181818),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              child: const Icon(Icons.play_arrow_sharp,color: Colors.green,),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ),],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 350,
                child: ListView(
                  children: [
                    buildLineDivider(),
                    const SizedBox(
                      height: 15,
                    ),
                    buildDaterow('200 m'),
                    const SizedBox(
                      height: 20,
                    ),
                    buildLineDivider(),
                    const SizedBox(
                      height: 20,
                    ),
                    buildDaterow('300 m'),
                    const SizedBox(
                      height: 20,
                    ),
                    buildLineDivider(),
                    const SizedBox(
                      height: 20,
                    ),
                    buildDaterow('300 m'),
                    const SizedBox(
                      height: 20,
                    ),
                    buildLineDivider(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IntrinsicHeight builddivider() {
    return IntrinsicHeight(
      child: Container(
        width: 3,
        height: 150,
        color: const Color(0XFF292929),
      ),
    );
  }

  Widget buildTotalMileagetext(String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Total Mileage',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFFFFFFFF)),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF01AA45), Color(0xFF00702D)],
            ).createShader(bounds);
          },
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              text,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
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

  Widget buildDaterow(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          text,
          style: const TextStyle(
              color: Color(0XFF01AA45),
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
        const Column(
          children: [
            Text(
              'Start time',
              style: TextStyle(
                  color: Color(0XFFFFFFFF),
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ),
            Text(
              '9:00 AM',
              style: TextStyle(
                  color: Color(0XFF828282),
                  fontWeight: FontWeight.w400,
                  fontSize: 13),
            ),
          ],
        ),
        const Column(
          children: [
            Text(
              'End time',
              style: TextStyle(
                  color: Color(0XFFFFFFFF),
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ),
            Text(
              '9:10 AM',
              style: TextStyle(
                  color: Color(0XFF828282),
                  fontWeight: FontWeight.w400,
                  fontSize: 13),
            ),
          ],
        ),
        const Column(
          children: [
            Text(
              'Date',
              style: TextStyle(
                  color: Color(0XFFFFFFFF),
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ),
            Text(
              'SEP 25, 2021',
              style: TextStyle(
                  color: Color(0XFF828282),
                  fontWeight: FontWeight.w400,
                  fontSize: 13),
            ),
          ],
        )
      ],
    );
  }
}
