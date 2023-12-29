import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/screen/dashboard_screen.dart';
import 'package:demo/screen/monthly_budget/newmonthly.dart';
import 'package:demo/screen/profile/profile.dart';
import 'package:demo/screen/drawer/mileagetracking.dart';
import 'package:demo/screen/drawer/reports.dart';
import 'package:demo/screen/sinking_fund/funddata_model.dart';
import 'package:demo/screen/sinking_fund/sinking_fund.dart';
import 'package:demo/screen/sinking_fund/transaction.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/customvector.dart';
import '../sinking_fund/DebtSnowballnodata.dart';

import '../expense/expense_add.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  late User users;
  late bool _isLoading;

  late DocumentSnapshot<Map<String, dynamic>> _userData;

  @override
  void initState() {
    super.initState();
    users = FirebaseAuth.instance.currentUser!;
    _isLoading = true;
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userData =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(users.uid)
              .get();

      setState(() {
        _userData = userData;
        _isLoading = false;
      });
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: const Color(0XFF181818),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.width * 0.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFf43d42),
                          Color(0xFF9e0f13),
                        ],
                        stops: [0.0, 1.0],
                        transform: GradientRotation(106.27 * 3.14159265 / 180),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello!',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Color(0XFFFFFFFF),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: buildUserData('firstName'),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Profile()));
                                    },
                                    child: Text(
                                      'View Profile',
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          color: Color(0XFF01AA45),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 25),
              const CustomVector(),
              const SizedBox(height: 15),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      title: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DashboardUser()));
                        },
                        child: Text(
                          'Dashboard',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      leading: Image.asset(
                        'assets/images/Category.png',
                        width: MediaQuery.of(context).size.width * 0.04,
                        height: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const CustomVector(),
                    const SizedBox(height: 30),
                    ListTile(
                      title: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NewMonthly()));
                        },
                        child: Text(
                          'Monthly Budget',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      leading: Image.asset(
                        'assets/images/Wallet.png',
                        width: MediaQuery.of(context).size.width * 0.04,
                        height: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    ListTile(
                      title: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SinkingFund()));
                        },
                        child: Text(
                          'Sinking Funds',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      leading: Image.asset(
                        'assets/images/Chart.png',
                        width: MediaQuery.of(context).size.width * 0.04,
                        height: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    ListTile(
                      title: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const DebtSnowballEmpetydata()),
                          );
                        },
                        child: Text(
                          'Debt Snowball',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      leading: Image.asset(
                        'assets/images/Group.png',
                        width: MediaQuery.of(context).size.width * 0.04,
                        height: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    ListTile(
                      title: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddddExpense()));
                        },
                        child: Text(
                          'Expense',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      leading: Image.asset(
                        'assets/images/Swap.png',
                        width: MediaQuery.of(context).size.width * 0.04,
                        height: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const CustomVector(),
                    const SizedBox(height: 30),
                    ListTile(
                      title: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserTransaction(),
                            ),
                          );
                        },
                        child: Text(
                          'Transactions',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      leading: Image.asset(
                        'assets/images/Swap.png',
                        width: MediaQuery.of(context).size.width * 0.04,
                        height: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    ListTile(
                      title: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MileageTracking()));
                        },
                        child: Text(
                          'Mileage Tracking',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      leading: Image.asset(
                        'assets/images/Swap.png',
                        width: MediaQuery.of(context).size.width * 0.04,
                        height: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    ListTile(
                      title: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Weekly Schedule',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      leading: Image.asset(
                        'assets/images/Chart.png',
                        width: MediaQuery.of(context).size.width * 0.04,
                        height: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    ListTile(
                      title: GestureDetector(
                        child: Text(
                          'Reports',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Reports()),
                          );
                        },
                      ),
                      leading: Image.asset(
                        'assets/images/Paper.png',
                        width: MediaQuery.of(context).size.width * 0.04,
                        height: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const CustomVector(),
                    const SizedBox(height: 25),
                    DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(15),
                      strokeWidth: 4,
                      color: const Color(0xFF292929),
                      dashPattern: const [9, 9],
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width * 0.30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {},
                                splashColor: Colors.transparent,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF01AA45),
                                        Color(0xFF00702D),
                                      ],
                                    ),
                                  ),
                                  child: Image.asset('assets/images/Path.png'),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '          Upload CSV File \n of your bank transactions',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0XFF8F8F8F),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserData(String label) {
    final userData = _userData.data();
    final fieldValue = userData != null && userData.containsKey(label)
        ? userData[label]
        : 'opps';

    return Text(
      '$fieldValue',
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: Color(0XFFFFFFFF),
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
    );
  }
}
