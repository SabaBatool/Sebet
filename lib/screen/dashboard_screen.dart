import 'package:demo/screen/sinking_fund/funddata_model.dart';
import 'package:demo/screen/sinking_fund/sinking_fund.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../widgets/customcard.dart';
import '../widgets/customcontainer.dart';
import '../widgets/linechart.dart';

import 'debt_snowball/debtsnowball.dart';
import 'drawer/drawer.dart';
import 'monthly_budget/newmonthly.dart';

class DashboardUser extends StatefulWidget {
  const DashboardUser({Key? key}) : super(key: key);

  @override
  State<DashboardUser> createState() => _DashboardUserState();
}

class _DashboardUserState extends State<DashboardUser> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedYear = DateTime.now().year;
  bool hasData = false;
  late String selectedMonth;
  late bool isShowingMainData;
  late bool _isLoading;
  bool? expectedIncome;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      appBar: appbar(),
      drawer: const DrawerScreen(),
      backgroundColor: const Color(0XFF181818),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            SizedBox(
              height: screenSize.height * 0.27,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.04,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NewMonthly()),
                          );
                        },
                        child: buildmunthlybudget(
                          context,
                          'Expected Budget for this month is .',
                          '\$5700',
                          color: Colors.white,
                          fontSize: screenSize.width * 0.08,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DebtSnowball()),
                            );
                          },
                          child: buildnodebet2container(context)),
                      SizedBox(
                        width: screenSize.width * 0.04,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SinkingFund()),
                            );
                          },
                          child: buildSinkingFund2(context)),
                      const SizedBox(
                        width: 10,
                      ),
                      buildmunthlybudget(
                        context,
                        'Create a monthly budget to keep \n track of your expenses.',
                        '+CREATE A BUDGET',
                        color: const Color(0XFFFF3D00),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      buildnodebetcontainer(context),
                      const SizedBox(
                        width: 10,
                      ),
                      buildSinkingFund(context),
                    ],
                  )
                ],
              ),
            ),
            const LineChartContainer(),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            const CustomContainer(
              imagePath: 'assets/images/swapp.png',
              text: 'Transactions',
              containerColor: Colors.green,
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xFF01AA45), Color(0xFF00702D)],
                stops: [0.0, 1.0],
                transform: GradientRotation(181.31 * 3.14159265 / 180),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            const CustomContainer(
              imagePath: 'assets/images/Swappp.png',
              text: 'REPORTS',
              containerColor: Colors.red,
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xFFED3237), Color(0xFFA01D20)],
                stops: [0.0, 1.0],
                transform: GradientRotation(181.31 * 3.14159265 / 180),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSinkingFund(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.240,
      width: MediaQuery.of(context).size.width * 0.92,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFED3237),
            Color(0xFFA01D20),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                  ),
                  child: CustomTextWidget(
                    text: '0\n% ',
                    color: Color(0XFF292929),
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                    height: 0.90,
                  ),
                ),
                Container(
                  width: 85.94,
                  height: 85.94,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 5.0,
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/Elpese.png'),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 30, bottom: 12, top: 18),
                        child: CustomTextWidget(
                          text: '  Sinking \n       Fund',
                          color: Color(0XFFFFFFFF),
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          height: 1.10,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            _buildRectangle(14, 14),
                            Container(
                              height: 1,
                              width: 3,
                              color: Colors.white,
                            ),
                            _buildRectangle(10, 10),
                            Container(
                              height: 1,
                              width: 120,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'You can do advance savings for \n   your long term spending goals         ',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0XFFFFFFFF),
                  height: 0.80,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Let’s Get started',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0XFFFF3D00),
                    height: 1.90,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildnodebet2container(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.240,
      width: MediaQuery.of(context).size.width * 0.92,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF01AA45),
            Color(0xFF00702D),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 14, top: 8),
                          child: CustomTextWidget(
                            text: 'DEBT \nSNOWBALL',
                            color: Color(0XFFFFFFFF),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 1.10,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 1,
                            width: 120,
                            color: Colors.white,
                          ),
                          _buildRectangle(10, 10),
                          Container(
                            height: 1,
                            width: 3,
                            color: Colors.white,
                          ),
                          _buildRectangle(14, 14),
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: CustomTextWidget(
                    text: '   2/10  \n  PAID',
                    color: Color(0XFF292929),
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                    height: .90,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Text(
                '40%',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0XFFFFFFFF),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              height: 20,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(10),
                  value: 0.5,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xffFFFFFF)),
                  backgroundColor: const Color(0xff292929),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 3, top: 3),
              child: Text(
                '40 % of your debts has been cleared ',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFFFFFFFF),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSinkingFund2(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.240,
      width: MediaQuery.of(context).size.width * 0.92,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFED3237),
            Color(0xFFA01D20),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 25,
                  ),
                  child: CustomTextWidget(
                    text: '61\n% ',
                    color: Color(0XFF292929),
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                    height: 0.90,
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularStepProgressIndicator(
                      totalSteps: 100,
                      currentStep: 55,
                      stepSize: 4,
                      selectedColor: Colors.white,
                      unselectedColor: const Color(0XFF292929),
                      width: 80,
                      height: 80,
                      selectedStepSize: 6,
                      roundedCap: (_, __) => true,
                    ),
                    ClipOval(
                      child: Image.asset(
                        'assets/images/Elpese.png',
                        width: 45,
                        height: 50,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 40, bottom: 18, top: 18),
                        child: CustomTextWidget(
                          text: '  Sinking \n       Fund',
                          color: Color(0XFFFFFFFF),
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          height: 1.10,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            _buildRectangle(14, 14),
                            Container(
                              height: 1,
                              width: 3,
                              color: Colors.white,
                            ),
                            _buildRectangle(10, 10),
                            Container(
                              height: 1,
                              width: 120,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Total Funds needs to be\n added this month',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0XFFFFFFFF),
                      height: 0.80,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 23,
                ),
                Text(
                  '\$5700',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Color(0XFFFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildnodebetcontainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.240,
      width: MediaQuery.of(context).size.width * 0.92,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF01AA45),
            Color(0xFF00702D),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 21,
                            bottom: 14,
                          ),
                          child: CustomTextWidget(
                            text: 'DEBT \nSNOWBALL',
                            color: Color(0XFFFFFFFF),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 1.10,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 1,
                            width: 120,
                            color: Colors.white,
                          ),
                          _buildRectangle(10, 10),
                          Container(
                            height: 1,
                            width: 3,
                            color: Colors.white,
                          ),
                          _buildRectangle(14, 14),
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: CustomTextWidget(
                    text: '      NO \n DEBT',
                    color: Color(0XFF292929),
                    fontSize: 45,
                    fontWeight: FontWeight.w700,
                    height: .90,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Enter your debts here to begin your debt           \n '
              '                         snowball plan!',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0XFFFFFFFF),
                  height: 1.40,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'TAP HERE TO BEGIN',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0XFF30DC14),
                    height: 1.00,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildmunthlybudget(
    BuildContext context,
    String text,
    String textt, {
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.240,
      width: MediaQuery.of(context).size.width * 0.92,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFED3237),
            Color(0xFFA01D20),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                  ),
                  child: CustomTextWidget(
                    text: 'JAN\n2022 ',
                    color: Color(0XFF292929),
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    height: 0.80,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 40, bottom: 10, top: 18),
                        child: CustomTextWidget(
                          text: '  MONTHLY \n      BUDGET',
                          color: Color(0XFFFFFFFF),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          height: 1.10,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            _buildRectangle(14, 14),
                            Container(
                              height: 1,
                              width: 3,
                              color: Colors.white,
                            ),
                            _buildRectangle(10, 10),
                            Container(
                              height: 1,
                              width: 120,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            buildText(text),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                textt,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: color,
                    height: 1.00,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text buildText(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0XFFFFFFFF),
          height: 1,
        ),
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      backgroundColor: const Color(0XFF181818),
      leading: GestureDetector(
        onTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        child: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Image(
            image: AssetImage(
              'assets/images/Combined-Shape.png',
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(20.0),
        child: Container(
          color: const Color(0xFF292929),
          height: 3.0,
        ),
      ),
    );
  }

  Widget _buildRectangle(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.5),
        color: const Color(0XFFFFFFFF),
      ),
    );
  }


}
