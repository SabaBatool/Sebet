import 'dart:async';

import 'package:demo/screen/sinking_fund/create_fund.dart';
import 'package:demo/screen/sinking_fund/provider_class.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../widgets/customtextbutton.dart';
import '../../widgets/headerwidget.dart';
import 'vacation.dart';
import 'funddata_model.dart';

class SinkingFund extends StatefulWidget {
  const SinkingFund({
    Key? key,
  }) : super(key: key);

  @override
  State<SinkingFund> createState() => _SinkingFundState();
}

class _SinkingFundState extends State<SinkingFund> {
  final FundDataProvider fundDataProvider = FundDataProvider();

  @override
  void initState() {
    super.initState();
    _loadFundData();
  }

  Future<List<FundData>> _loadFundData() async {
    await fundDataProvider.fetchFundDataFromFirestore();
    for (var fundData in fundDataProvider.fundDataList) {
      print("Document ID after loading data: ${fundData.documentId}");
    }
    return fundDataProvider.fundDataList;
  }

  @override
  Widget build(BuildContext context) {
    final double containerWidth = MediaQuery.of(context).size.width - 20;

    return Scaffold(
      backgroundColor: const Color(0XFF181818),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HeaderWidget(text: 'Sinking Funds'),
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
                    child: Image.asset('assets/images/Path.png'),
                  ),
                  CustomTextButton(
                    label: 'Add Fund',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0XFF01AA45),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateFund(
                            isEditing: false,
                            fundData: null,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 2000,
                child: StreamBuilder<List<FundData>>(
                  stream: fundDataProvider.fundDataStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<FundData>> snapshot) {
                    if (snapshot.hasData) {
                      for (var fundData in snapshot.data!) {
                        print(
                            "StreamBuilder Document ID: ${fundData.documentId}");
                        print(
                            "StreamBuilder Document ID: ${fundData.fundName}");
                        print(
                            "StreamBuilder Document ID: ${fundData.amountOfGoal}");
                        print(
                            "StreamBuilder Document ID: ${fundData.monthsToAchieveGoal}");
                      }
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error loading data'));
                    } else {
                      List<FundData> fundDataList = snapshot.data ?? [];
                      return ListView.builder(
                        itemCount: fundDataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: buildcharistmas(
                              containerWidth,
                              fundDataList,
                              () => null,
                              () => null,
                              fundDataList[index],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildcharistmas(
    double containerWidth,
    List<FundData> fundDataList,
    Function() onEditPressed,
    Function() onDeletePressed,
    FundData fundData,
  ) {
    print("....................${fundData.adddepositAmount}");
    print("....................${fundData.monthsToAchieveGoal}");
    print("....................${fundData.amountOfGoal}");
    print("....................${fundData.documentId}");
    print("....................${fundData.fundName}");
    print("/////////////////////////Document ID: ${fundData.documentId}");
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Slidable(
            actionPane: const SlidableDrawerActionPane(),
            secondaryActions: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      print(
                          "....................Documet Id ${fundData.documentId}");

                      print(
                          "Document ID before navigation: ${fundData.documentId}");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Vacation(
                            fundData: fundData,
                            documentId: fundData.documentId ?? 'default_value',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 126,
                      width: 80,
                      color: Colors.green,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'View\nDetails',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateFund(
                                    fundData:
                                        fundData, // Pass the FundData object to the CreateFund screen
                                    isEditing: true,
                                  )));
                    },
                    child: Container(
                      height: 126,
                      width: 80,
                      color: Colors.green,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Edit',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Material(
                  child: InkWell(
                    onTap: () {
                      fundDataProvider.deleteFund(fundData);
                    },
                    child: Container(
                      height: 126,
                      width: 80,
                      color: Colors.red,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Delete',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: containerWidth * 0.9,
                  height: containerWidth * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x26000000),
                        offset: Offset(0, 4),
                        blurRadius: 20,
                      ),
                    ],
                    color: const Color(0XFF292929),
                  ),
                  child: Center(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text(
                          '23',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: containerWidth * 0.7,
                      height: containerWidth * 0.4,
                      decoration: BoxDecoration(
                        color: const Color(0XFF292929),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x26000000),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                fundData.fundName,
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Color(0XFFFFFFFF),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            PreferredSize(
                              preferredSize: const Size.fromHeight(12.0),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 12, bottom: 6),
                                child: Container(
                                  color: const Color(0xFF181818),
                                  height: 2.0,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                rowData('Goals:',
                                    '\$${fundData.amountOfGoal} months'),
                                rowData('Duration:',
                                    '${fundData.monthsToAchieveGoal} months'),
                                rowData('Monthly Deposit:',
                                    '\$${fundData.monthlydepositAmount}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CircularStepProgressIndicator(
                        totalSteps: 100,
                        currentStep: 55,
                        stepSize: 3,
                        selectedColor: const Color(0XFF01AA45),
                        unselectedColor: const Color(0XFF181818),
                        width: containerWidth * 0.2,
                        height: containerWidth * 0.2,
                        selectedStepSize: 6,
                        roundedCap: (_, __) => true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget rowData(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Color(0xfffFFFFF),
              fontWeight: FontWeight.w300,
              fontSize: 15,
            ),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0XFFFFFFFF),
            ),
          ),
        ),
      ],
    );
  }
}
