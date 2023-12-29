import 'package:cloud_firestore/cloud_firestore.dart';

class DepositData {
  final DateTime date;
  final double amount;

  DepositData({
    required this.date,
    required this.amount,
  });


}
