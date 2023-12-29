import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class MonthlyDataProvider extends ChangeNotifier {
  bool isLoading = true;
  double? expectedIncome;

  final _dataStreamController = StreamController<void>.broadcast();

  Stream<void> get dataStream => _dataStreamController.stream;


  void setLoading(bool loading) {
    isLoading = loading;
    _dataStreamController.add(null);
  }

  void setExpectedIncome(double? income) {
    print('................Setting expected income: $income................');
    expectedIncome = income;
    _dataStreamController.add(null);
  }


  Future<void> checkData() async {
    try {
      setLoading(true);
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userUid = user.uid;

        CollectionReference expectedIncomeCollection = FirebaseFirestore
            .instance
            .collection('users')
            .doc(userUid)
            .collection('expectedIncome');

        var querySnapshot = await expectedIncomeCollection.get();

        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot<Map<String, dynamic>> document =
          querySnapshot.docs.first as DocumentSnapshot<Map<String, dynamic>>;

          var expectedIncomeValue = document.data()?['expectedIncome'] as double?;

          if (expectedIncomeValue != null) {
            print('............expected income $expectedIncome');
            setExpectedIncome(expectedIncomeValue);
          } else {
            print('expectedIncomeValue is null');
            // Handle the case where expectedIncomeValue is null
          }
        } else {
          print('No documents found');
          // Handle the case where no documents are found
        }
      } else {
        print('User is null');
        // Handle the case where the user is null
      }
    } catch (error) {
      print('Error: $error');
      // Handle any exceptions that occur during data fetching
    } finally {
      setLoading(false);
    }
  }




  @override
  void dispose() {
    _dataStreamController.close();
    super.dispose();
  }

}
