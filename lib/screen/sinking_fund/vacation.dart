// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../widgets/customtextbutton.dart';
import '../../widgets/headerwidget.dart';

import 'DepositData.dart';
import 'funddata_model.dart';
import 'provider_class.dart';

class Vacation extends StatefulWidget {
  final FundData fundData;
  final String documentId;

  Vacation({super.key, required this.fundData, required this.documentId}) {
    }

  @override
  State<Vacation> createState() => _VacationState();
}

class _VacationState extends State<Vacation> {
  FundDataProvider fundDataProvider = FundDataProvider();
  TextEditingController depositController = TextEditingController();
  late final FundData fundData;
  List<DepositData> depositDataList = [];

  @override
  void initState() {
    super.initState();
    fetchDepositData();
    fundData = widget.fundData;
  }

  Future<void> fetchDepositData() async {
    depositDataList = await fundDataProvider.fetchDepositData(widget.fundData);
    setState(() {});
  }
  double calculateTotalDeposit() {
    double totalDeposit = 0.0;
    double remaningAmount = 0.0;

    for (DepositData depositData in depositDataList) {
      totalDeposit += depositData.amount;
    }
     remaningAmount=  totalDeposit - fundData.monthlydepositAmount;

    return remaningAmount;
  }


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Consumer(
      builder: (BuildContext context, fundDataProvider, child) {
        return Scaffold(
          backgroundColor: const Color(0XFF181818),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(children: [
                HeaderWidget(text: widget.fundData.fundName),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: screenSize.width * 0.98,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'GOAL',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: const Color(0xfffFFFFF),
                                      fontWeight: FontWeight.w500,
                                      fontSize: screenSize.width * 0.05,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Text(
                                    '\$${widget.fundData.amountOfGoal}',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: screenSize.width * 0.05,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0XFFFFFFFF),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 0),
                            child: buildDivider(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25, left: 15),
                            child: Row(
                              children: [
                                Text(
                                  'TOTAL MONTH\nMONTHLY DEPOSIT',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: const Color(0xfffFFFFF),
                                      fontWeight: FontWeight.w500,
                                      fontSize: screenSize.width * 0.035,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: screenSize.width * 0.40,
                                  ),
                                  child: Text(
                                    '${widget.fundData
                                        .monthsToAchieveGoal}\n\$${widget
                                        .fundData.monthlydepositAmount}',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: screenSize.width * 0.035,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0XFFFFFFFF),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 15),
                            child: SizedBox(
                              width: screenSize.width * 0.9,
                              height: 20,
                              child: ClipRRect(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                                child: LinearProgressIndicator(
                                  borderRadius: BorderRadius.circular(10),
                                  value: 0.6,
                                  valueColor: const AlwaysStoppedAnimation<
                                      Color>(
                                      Color(0xff01AA45)),
                                  backgroundColor: const Color(0xff181818),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding:
                            const EdgeInsets.only(right: 12, left: 10, top: 8),
                            child: Row(
                              children: [
                                Text(
                                  'REMAINING AMOUNT\nRemaining Months',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: const Color(0xfffFFFFF),
                                      fontWeight: FontWeight.w500,
                                      fontSize: screenSize.width * 0.035,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: screenSize.width * 0.18,
                                  ),
                                  child: Text(
                                    '\$${calculateTotalDeposit()}\n ${widget.fundData.monthsToAchieveGoal}',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: screenSize.width * 0.035,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0XFFFFFFFF),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: screenSize.width * 0.03,
                      height: screenSize.width * 0.03,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.green,
                      ),
                      child: Image.asset('assets/images/Path.png'),
                    ),
                    CustomTextButton(
                        label: 'Add Deposit',
                        fontSize: screenSize.width * 0.03,
                        fontWeight: FontWeight.w600,
                        color: const Color(0XFF01AA45),
                        onPressed: () {
                          _showDepositDialog(context);
                        }),
                  ],
                ),
                const SizedBox(height: 20),
                buildDividerLine(),
                const Gap(10),
                SizedBox(
                  height: double.maxFinite,
                  child: ListView.separated(
                    itemCount: depositDataList.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: buildDividerLine(),
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      DepositData depositData = depositDataList[index];
                      return buildDateRow(depositData, screenSize);
                    },
                  ),
                ),
                const Gap(10),
                buildDividerLine(),
              ]),
            ),
          ),
        );

      } );
  }

  Widget buildDateRow(DepositData depositData, Size screenSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          DateFormat('MMM yyyy').format(depositData.date),
          style: const TextStyle(
            color: Color(0XFFFFFFFF),
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        Column(
          children: [
            const Text(
              'Amount',
              style: TextStyle(
                color: Color(0XFFFFFFFF),
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            Text(
              '\$${depositData.amount}',
              style: const TextStyle(
                color: Color(0XFF828282),
                fontWeight: FontWeight.w300,
                fontSize: 13,
              ),
            ),
          ],
        ),
        Column(
          children: [
            const Text(
              'DATE',
              style: TextStyle(
                color: Color(0XFFFFFFFF),
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            Text(
              DateFormat.yMd().format(depositData.date),
              style: const TextStyle(
                color: Color(0XFFFFFFFF),
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
        Column(
          children: [
            const Text(
              'Time',
              style: TextStyle(
                color: Color(0XFFFFFFFF),
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            Text(
              DateFormat('h:mm a').format(depositData.date),
              style: const TextStyle(
                color: Color(0XFF828282),
                fontWeight: FontWeight.w300,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDividerLine() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(20.0),
      child: Container(
        color: const Color(0xFF292929),
        height: 2.0,
      ),
    );
  }

  Widget buildDivider() {
    return Container(
      color: const Color(0xFF181818),
      height: 2.0,
    );
  }

  void _showDepositDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Enter Deposit Amount'),
            content: TextField(
              controller: depositController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Deposit Amount'),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  saveDepositData();
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ]);
      },
    );
  }

  void saveDepositData() async {
    try {
      await fundDataProvider.saveDepositData(
          fundData, double.parse(depositController.text));
      depositController.clear();
    } catch (error) {
    }
  }
}
