// ignore_for_file: depend_on_referenced_packages

import 'package:demo/screen/sinking_fund/provider_class.dart';
import 'package:flutter/material.dart';

import '../../widgets/headerwidget.dart';
import 'package:intl/intl.dart';
import 'DepositData.dart';
import 'funddata_model.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({Key? key}) : super(key: key);

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  late FundData fundData;

  late Future<List<DepositData>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      List<DepositData> depositDataList =
          await FundDataProvider().fetchDepositData(fundData);

      if (depositDataList.isNotEmpty) {
        fundData = depositDataList[0] as FundData;
      } else {
        print('Deposit data is empty.');
      }

      setState(() {});
    } catch (error) {
      print('Error initializing data: $error');
      // Handle the error as needed
    }

    _dataFuture = fetchData();
  }

  Future<List<DepositData>> fetchData() async {
    return FundDataProvider().fetchDepositData(fundData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF181818),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const HeaderWidget(text: 'Transaction'),
          const SizedBox(height: 20),
          FutureBuilder<List<DepositData>>(
            future: _dataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available'));
              } else {
                return buildRentalData(snapshot.data![0]);
              }
            },
          ),
        ],
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

  Widget buildRentalData(DepositData depositData) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Text(
                'Amount',
                style: TextStyle(
                    color: Color(0XFFFFFFFF),
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
              ),
              Text(
                '\$${depositData.amount}',
                style: const TextStyle(
                    color: Color(0XFF828282),
                    fontWeight: FontWeight.w300,
                    fontSize: 13),
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
                    fontSize: 13),
              ),
              Text(
                DateFormat('MM-dd-yyyy hh:mm').format(depositData.date),
                style: const TextStyle(
                    color: Color(0XFF828282),
                    fontWeight: FontWeight.w300,
                    fontSize: 13),
              ),
            ],
          ),
          Container(
            width: 130,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white),
              color: const Color(0XFFFFFFFF),
            ),
          ),
        ],
      ),
    );
  }
}
