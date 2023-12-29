// ignore_for_file: use_build_context_synchronously, empty_catches, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddExpectedIncomeDialog extends StatefulWidget {
  const AddExpectedIncomeDialog({Key? key}) : super(key: key);

  @override
  _AddExpectedIncomeDialogState createState() =>
      _AddExpectedIncomeDialogState();
}

class _AddExpectedIncomeDialogState extends State<AddExpectedIncomeDialog> {
  late int selectedYear;
  late String selectedMonth;
  late double expectedIncome;
  final CollectionReference incomeCollection =
      FirebaseFirestore.instance.collection('expectedIncome');

  @override
  void initState() {
    super.initState();
    selectedYear = DateTime.now().year;
    selectedMonth = _getMonthName(DateTime.now().month);
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Expected Income'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Year:'),
            DropdownButton<int>(
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
            ),
            const SizedBox(height: 10),
            const Text('Month:'),
            DropdownButton<String>(
              value: selectedMonth,
              onChanged: (String? value) {
                setState(() {
                  selectedMonth = value!;
                });
              },
              items: List.generate(12, (index) {
                final monthName = _getMonthName(index + 1);
                return DropdownMenuItem<String>(
                  value: monthName,
                  child: Text(monthName),
                );
              }),
            ),
            const Text('Expected Income:'),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                expectedIncome = double.parse(value);
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await saveToFirestore();
            Navigator.pop(context);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  Future<void> saveToFirestore() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        CollectionReference userIncomeCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('expectedIncome');

        QuerySnapshot<Object?> existingDocs = await userIncomeCollection
            .where('year', isEqualTo: selectedYear)
            .where('month', isEqualTo: selectedMonth)
            .get();

        if (existingDocs.docs.isNotEmpty) {
          // Data exists, switch to update mode
          String existingDocId = existingDocs.docs.first.id;
          await userIncomeCollection.doc(existingDocId).update({
            'expectedIncome': expectedIncome,
            'timestamp': FieldValue.serverTimestamp(),
          });
        } else {
          await userIncomeCollection.add({
            'year': selectedYear,
            'month': selectedMonth,
            'expectedIncome': expectedIncome,
            'timestamp': FieldValue.serverTimestamp(),
          });
        }
      } else {}
    } catch (e) {}
  }
}
