import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../widgets/customtextbutton.dart';
import '../../widgets/headerwidget.dart';
import 'dilogscreen.dart';
import 'monthly_provider.dart';

class NewMonthly extends StatefulWidget {
  const NewMonthly({super.key});

  @override
  State<NewMonthly> createState() => _NewMonthlyState();
}

class _NewMonthlyState extends State<NewMonthly> {
  int selectedYear = DateTime.now().year;

  late String _selectedMonth;
  double? expectedIncome;

  late double incomeSpentInBudget = 40;
  double get remainingAmount =>
      expectedIncome ?? -((incomeSpentInBudget) / 100);
  final MonthlyDataProvider monthlyDataProvider = MonthlyDataProvider();

  @override
  void initState() {
    super.initState();

    int selectedMonthNumber = 9;
    _selectedMonth = _getMonthName(selectedMonthNumber);
    fetchData();
  }

  String _getMonthName(int month) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    if (month >= 1 && month <= 12) {
      return months[month - 1];
    } else {
      throw ArgumentError('Invalid month: $month');
    }
  }

  void fetchData() async {
    try {
      await monthlyDataProvider.checkData();
      setState(() {});
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return ChangeNotifierProvider<MonthlyDataProvider>(
      create: (context) => monthlyDataProvider,
      child: Scaffold(
        backgroundColor: const Color(0XFF181818),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const HeaderWidget(text: 'Monthly Budget'),
                const SizedBox(height: 20),
                dateSelection(),
                const SizedBox(height: 20),
                Consumer<MonthlyDataProvider>(
                  builder: (context, provider, child) {
                    expectedIncome = provider.expectedIncome;
                    if (provider.isLoading) {
                      print('....................Loading...');
                      return const CircularProgressIndicator();
                    } else {
                      print('Not loading...');
                      if (provider.expectedIncome != null) {
                        print('Expected Income is not null.');
                        return buildUpdateIncome(context, screenSize);
                      } else {
                        print('Expected Income is null.');
                        return buildExpectedIncome(context, screenSize);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dateSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 10),
          child: Text(
            'Year:',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color(0XFFFFFFFF),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 0),
          child: Container(
            width: 101,
            height: 34,
            margin: const EdgeInsets.only(
              top: 13,
              right: 8,
              left: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white),
              color: const Color(0XFFFFFFFF),
            ),
            child: Align(
              alignment: Alignment.center,
              child: DropdownButton<int>(
                value: selectedYear,
                onChanged: (int? value) {
                  setState(() {
                    selectedYear = value!;
                  });
                },
                items: List.generate(10, (index) {
                  return DropdownMenuItem<int>(
                    value: DateTime.now().year - index,
                    child: Text('${DateTime.now().year - index}'),
                  );
                }),
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color(0XFF181818),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                underline: const SizedBox(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 0),
          child: Text(
            'Month:',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color(0XFFFFFFFF),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, top: 15),
          child: Container(
            width: 120,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white),
              color: const Color(0XFFFFFFFF),
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: DropdownButton<String>(
                value: _selectedMonth,
                onChanged: (String? value) {
                  setState(() {
                    _selectedMonth = value!;
                  });
                },
                items: List.generate(12, (index) {
                  final monthName = _getMonthName(index + 1);
                  return DropdownMenuItem<String>(
                    value: monthName,
                    child: Text(monthName),
                  );
                }),
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                underline: const SizedBox(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildUpdateIncome(BuildContext context, Size screenSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.green,
              ),
              child: const Icon(Icons.edit),
            ),
            CustomTextButton(
                label: 'Update Income',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0XFF01AA45),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AddExpectedIncomeDialog()));
                }),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: screenSize.width * 0.9,
            height: screenSize.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0XFF292929),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text(
                          'EXPECTED INCOME \n OF THIS MONTH ',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0xfffFFFFF),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.2),
                          child: Text(
                            ' ${expectedIncome ?? 'N/A'}',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: Color(0XFF4E4E4E),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 15),
                    child: builddivider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 15),
                    child: Row(
                      children: [
                        Text(
                          'INCOME SPENT IN\nBUDGET',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0xfffFFFFF),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text(
                            '\$$incomeSpentInBudget%',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: Color(0XFFED3237),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 20,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(10),
                          value: incomeSpentInBudget / 100,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xffED3237)),
                          backgroundColor: const Color(0xff181818),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12, top: 8),
                    child: Row(
                      children: [
                        Text(
                          '  REMAINING AMOUNT',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0xfffFFFFF),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            '\$$remainingAmount',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w700,
                                color: Color(0XFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildExpectedIncome(BuildContext context, Size screenSize) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.green,
              ),
              child: const Icon(Icons.edit),
            ),
            CustomTextButton(
              label: 'Add Expected Income',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0XFF01AA45),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AddExpectedIncomeDialog();
                  },
                );
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: screenSize.width * 0.98,
            height: screenSize.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0XFF292929),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Text(
                          'EXPECTED INCOME \n OF THIS MONTH ',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0XFF4E4E4E),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 90),
                          child: Text(
                            '--',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: Color(0XFF4E4E4E),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
                    child: buildLineDivider(const Color(0XFF181818)),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 20,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(10),
                          value: 0.6,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xff4E4E4E)),
                          backgroundColor: const Color(0xff4E4E4E),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLineDivider(Color color) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(20.0),
      child: Container(
        color: color,
        height: 2.0,
      ),
    );
  }

  Widget builddivider() {
    return Container(
      width: 310,
      color: const Color(0xFF181818),
      height: 2.0,
    );
  }
}
