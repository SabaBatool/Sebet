import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'DepositData.dart';
import 'funddata_model.dart';

class FundDataProvider with ChangeNotifier {
  List<FundData> _fundDataList = [];
  final StreamController<List<FundData>> fundDataController =
      StreamController<List<FundData>>.broadcast();

  Stream<List<FundData>> get fundDataStream => fundDataController.stream;

  bool _isLoading = false;

  List<FundData> get fundDataList => _fundDataList;

  bool get isLoading => _isLoading;
  FundData? _fundData;

  FundData? get fundData => _fundData;

  set fundData(FundData? data) {
    _fundData = data;
    notifyListeners();
  }

  Future<void> saveFundDataToFirestore() async {
    try {
      if (_fundData == null) {
        return;
      }

      User? users = FirebaseAuth.instance.currentUser;

      if (users != null) {
        String documentId = users.uid;
        var doc = FirebaseFirestore.instance
            .collection('users')
            .doc(documentId)
            .collection('CreateFund')
            .doc();
        fundData!.documentId = doc.id;
        var fundDataMap = _fundData!.toMap();
        await doc.set(fundDataMap);
      }
    } catch (error) {
      print('Error saving data to Firestore: $error');
    }
  }

  Future<void> fetchFundDataFromFirestore() async {
    _isLoading = true;
    notifyListeners();

    try {
      User? users = FirebaseAuth.instance.currentUser;

      if (users != null) {
        String collectionName = users.uid;

        var querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(collectionName)
            .collection('CreateFund')
            .get();

        print(querySnapshot);

        _fundDataList = querySnapshot.docs.map((doc) {
          final data = doc.data();
          data['documentId'] = doc.id;
          print('..............Firestore Document Data: $data');
          print("........................Document ID: ${doc.id}");
          return FundData.fromMap(
            data ?? {},
          );
        }).toList();

        fundDataController.add(_fundDataList);
      }
    } catch (error) {
      print('Error fetching data from Firestore: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteFund(FundData fundData) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userUid = user.uid;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userUid)
            .collection('CreateFund')
            .doc(fundData.documentId)
            .delete();

        print('Deleted fund with ID: ${fundData.documentId}');
      }
    } catch (error) {
      print('Error deleting fund: $error');
      // Handle errors
    }
  }

  void dispose() {
    fundDataController.close();
  }

  Future<void> saveDepositData(FundData fundData, double depositAmount) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userUid = user.uid;

        var newDoc = FirebaseFirestore.instance
            .collection('users')
            .doc(userUid)
            .collection('CreateFund')
            .doc(fundData.documentId)
            .collection('AddFund')
            .doc();

        await newDoc.set({
          'date': DateTime.now(),
          'amount': depositAmount,
        });

        print('Deposit Date: ${DateTime.now()}');
        print('Deposit Amount: $depositAmount');

        notifyListeners();
      }
    } catch (error) {
      print('Error saving deposit data to Firestore: $error');
    }
  }

  Future<List<DepositData>> fetchDepositData(FundData fundData) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userUid = user.uid;

        var depositDataSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userUid)
            .collection('CreateFund')
            .doc(fundData.documentId)
            .collection('AddFund')
            .get();

        List<DepositData> depositDataList = depositDataSnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data();
          DateTime date;

          // Check if the 'date' field is a Timestamp
          if (data['date'] is Timestamp) {
            date = (data['date'] as Timestamp).toDate();
          } else {
            date = DateTime.now();
          }

          return DepositData(
            date: date,
            amount: data['amount'] as double,
          );
        }).toList();

        depositDataList.forEach((depositData) {
          print('Deposit Date: ${depositData.date}');
          print('Deposit Amount: ${depositData.amount}');
        });

        return depositDataList;
      }

      return [];
    } catch (error) {
      print('Error fetching deposit data from Firestore: $error');
      return [];
    }
  }
  Future<FundData?> getFundDataById(String documentId) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userUid = user.uid;

        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userUid)
            .collection('CreateFund')
            .doc(documentId)
            .get();

        if (documentSnapshot.exists) {
          return FundData.fromMap(documentSnapshot.data()!);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (error) {
      print('Error getting fund data by ID: $error');
      return null;
    }
  }
  Future<void> saveOrUpdateFundDataToFirestore() async {
    try {
      if (_fundData == null) {
        return;
      }

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String documentId = user.uid;
        var collectionReference = FirebaseFirestore.instance
            .collection('users')
            .doc(documentId)
            .collection('CreateFund');

        if (_fundData!.documentId == null) {
          // Creating new data
          var doc = await collectionReference.add(_fundData!.toMap());
          fundData!.documentId = doc.id;
        } else {
          // Updating existing data
          var doc = collectionReference.doc(_fundData!.documentId);
          await doc.update(_fundData!.toMap());
        }
      }
    } catch (error) {
      print('Error saving or updating data to Firestore: $error');
    }
  }

}
