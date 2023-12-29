// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, depend_on_referenced_packages

import 'package:demo/screen/sinking_fund/provider_class.dart';
import 'package:demo/screen/sinking_fund/sinking_fund.dart';
import 'package:demo/widgets/custombutton.dart';

import 'package:demo/widgets/customtextfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'funddata_model.dart';
import 'package:intl/intl.dart';

class CreateFund extends StatefulWidget {
  final bool isEditing;
  final FundData? fundData;
  const CreateFund({
    super.key,
    required this.isEditing,
    required this.fundData,
  });

  @override
  State<CreateFund> createState() => _State();
}

class _State extends State<CreateFund> {
  TextEditingController fundname = TextEditingController();
  TextEditingController amountofgoale = TextEditingController();
  TextEditingController selectDate = TextEditingController();

  DateTime selectedDateee = DateTime.now();
  DateTime selectedDate = DateTime.now();
  int monthsToAchieveGoal = 0;
  String depositAmountText = '0';
  FundData? fundData;

  @override
  void initState() {
    super.initState();
    _loadFundData();
  }

  Future<void> _loadFundData() async {
    if (widget.isEditing && widget.fundData != null) {
      fundData = await FundDataProvider()
          .getFundDataById(widget.fundData?.documentId ?? '');

      if (fundData != null) {
        fundname.text = fundData!.fundName;
        amountofgoale.text = fundData!.amountOfGoal.toString();
        selectDate.text =
            DateFormat('yyyy-MM-dd').format(fundData!.selectedDate);
        monthsToAchieveGoal = fundData!.monthsToAchieveGoal.toInt();
        depositAmountText = fundData!.monthlydepositAmount.toString();
      }
    }
  }

  int calculateMonthsDifference(DateTime selectedDate) {
    DateTime currentDate = DateTime.now();

    int years = selectedDate.year - currentDate.year;
    int months = selectedDate.month - currentDate.month;

    int totalMonths = years * 12 + months;

    return totalMonths;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateee,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != selectedDateee) {
      setState(() {
        selectedDateee = picked;
        selectDate.text = "${picked.day}/${picked.month}/${picked.year}";
        monthsToAchieveGoal = calculateMonthsDifference(selectedDateee);
      });
    }
  }

  void updateDepositAmount() {
    if (monthsToAchieveGoal > 0) {
      double amountOfGoal = double.tryParse(amountofgoale.text) ?? 0;
      double depositPerMonth = amountOfGoal / monthsToAchieveGoal;

      depositAmountText = depositPerMonth.toStringAsFixed(2);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF181818),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  'Create a fund',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Color(0XFFFFFFFF),
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  'This is for your long term spending goals, like vacation, or car repairs. '
                  'Not monthly expenses, but expenses that you know are coming! '
                  'Enter an amount for your goal, and when you need to be that goal,then'
                  'SEBET will let you know how much you need to budget each month to reach it!',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFFFFFFFF)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
                child: Column(
                  children: [
                    CustomTextFormField(
                      hintText: 'Fund name',
                      controller: fundname,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextfield(
                      hintText: 'Amount of goal',
                      controller: amountofgoale,
                      onChanged: (value) {
                        updateDepositAmount();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  'Select a date when you need this fund',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFFFFFFFF)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: TextFormField(
                      controller: selectDate,
                      onTap: () => _selectDate(context),
                      readOnly: true,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color(0XFFB7B6B6),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Due date',
                        hintStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0XFF181818),
                          ),
                        ),
                        border: InputBorder.none,
                        suffixIcon: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: const Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, right: 80),
                child: Text(
                  'Months to achieve this goal',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFFFFFFFF)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(15),
                  strokeWidth: 4,
                  color: const Color(0xFF292929),
                  dashPattern: const [9, 9],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '$monthsToAchieveGoal',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0XFFED3237),
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, right: 8),
                child: Text(
                  'Deposit per month to achieve the  goal',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFFFFFFFF)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(15),
                  strokeWidth: 4,
                  color: const Color(0xFF292929),
                  dashPattern: const [9, 9],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          depositAmountText,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0XFFED3237),
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              PrimaryButton(
                  text: widget.isEditing ? 'Update' : 'Create',
                  onPressed: () async {
                    var fundData = FundData(
                      fundName: fundname.text,
                      amountOfGoal: double.parse(amountofgoale.text),
                      selectedDate: selectedDateee,
                      monthsToAchieveGoal: monthsToAchieveGoal,
                      monthlydepositAmount: double.parse(depositAmountText),
                      adddepositAmount: 90,
                      documentId:
                          widget.isEditing ? widget.fundData!.documentId : null,
                    );

                    var fundDataProvider =
                        Provider.of<FundDataProvider>(context, listen: false);

                    fundDataProvider.fundData = fundData;

                    if (widget.isEditing) {
                      await fundDataProvider.saveOrUpdateFundDataToFirestore();
                    } else {
                      await fundDataProvider.saveFundDataToFirestore();
                    }

                    String? savedDocumentId = fundData.documentId;
                    if (savedDocumentId != null) {
                      // Data saved successfully, navigate to the SinkingFund screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SinkingFund(),
                        ),
                      );
                    }
                  })
            ]),
          ),
        ),
      ),
    );
  }

  Widget CustomTextfield({
    required TextEditingController controller,
    required String hintText,
    void Function(String)? onChanged,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF292929),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 3),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 18),
        child: TextFormField(
          onChanged: onChanged,
          controller: controller,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Color(0XFFB7B6B6),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xffB7B6B6),
              ),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
