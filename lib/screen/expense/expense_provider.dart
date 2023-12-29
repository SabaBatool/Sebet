import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ExpenseProvider extends ChangeNotifier {
  String? selectedCategory;
  final TextEditingController _categoryTitleController =
      TextEditingController();
  List<String> categories = [];

  TextEditingController get categoryTitleController => _categoryTitleController;

  void setSelectedCategory(String? category) {
    selectedCategory = category;
    notifyListeners();
  }

  Future<void> deleteExpense(String category) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userUid = user.uid;

        CollectionReference expensesCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(userUid)
            .collection('expenses');

        DocumentReference documentReference = expensesCollection.doc(category);

        await documentReference.delete();

        // Optionally, notify listeners if this method changes the internal state
        notifyListeners();
      }
    } catch (error) {
      // Handle errors
    }
  }

  Future<void> addCategoryWithSubcategories(String categoryName,
      String subcategory1, String subcategory2, String subcategory3) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userUid = user.uid;

        CollectionReference expensesCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(userUid)
            .collection('expenses');

        DocumentReference documentReference =
            expensesCollection.doc(categoryName);

        Map<String, dynamic> data = {
          'category': categoryName,
          'subcategory1': subcategory1,
          'subcategory2': subcategory2,
          'subcategory3': subcategory3,
        };

        await documentReference.set(data);

        // Notify listeners if needed
        notifyListeners();
      }
    } catch (error) {
      // Handle errors
    }
  }

  Future<List<String>> fetchCategories() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userUid = user.uid;

        CollectionReference expensesCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(userUid)
            .collection('expenses');

        QuerySnapshot querySnapshot = await expensesCollection.get();

        List<String> categories = [];

        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          categories.add(documentSnapshot.id);
        }

        print('Fetched categories: $categories'); // Add this line for debugging

        return categories;
      } else {
        return [];
      }
    } catch (error) {
      print('Error fetching categories: $error');
      return [];
    }
  }

  Future<List<String>> fetchCategoryData(String categoryName) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userUid = user.uid;

        DocumentSnapshot document = await FirebaseFirestore.instance
            .collection('users')
            .doc(userUid)
            .collection('expenses')
            .doc(categoryName)
            .get();

        if (document.exists) {
          String subcategory1 = document.get('subcategory1');
          String subcategory2 = document.get('subcategory2');
          String subcategory3 = document.get('subcategory3');
          return [subcategory1, subcategory2, subcategory3];
        }
      }

      // Return an empty list if no data is found
      return [];
    } catch (error) {
      // Handle errors
      return [];
    }
  }

  Future<void> updateCategoryWithSubcategoryValues(
    String selectedCategory,
    Map<String, String> subcategoryValues,
  ) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userUid = user.uid;

        DocumentReference documentReference = FirebaseFirestore.instance
            .collection('users')
            .doc(userUid)
            .collection('expenses')
            .doc(selectedCategory);
        DocumentSnapshot documentSnapshot = await documentReference.get();
        Map<String, dynamic> existingData = documentSnapshot.exists
            ? (documentSnapshot.data() as Map<String, dynamic>)
            : {};
        Map<String, dynamic> updatedData = {
          ...existingData,
          ...subcategoryValues
        };

        updatedData.removeWhere((key, value) => value == null || value.isEmpty);

        await documentReference.set(updatedData);
        notifyListeners();
      }
    } catch (error) {
      print('Error updating category: $error');
    }
  }

  Future<Map<String, dynamic>> updateCategoryWithSubcategoryValuesFatch(
    String selectedCategory,
    Map<String, String> subcategoryValues,
  ) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userUid = user.uid;

        DocumentReference documentReference = FirebaseFirestore.instance
            .collection('users')
            .doc(userUid)
            .collection('expenses')
            .doc(selectedCategory);

        // Update the document with subcategoryValues
        await documentReference.update(subcategoryValues);

        // Fetch the updated data
        DocumentSnapshot documentSnapshot = await documentReference.get();
        Map<String, dynamic> updatedData =
            documentSnapshot.data() as Map<String, dynamic>;

        // Notify listeners and return the updated data
        notifyListeners();
        return updatedData;
      }
      return {};
    } catch (error) {
      print('Error updating category: $error');
      return {};
    }
  }

  Future<Map<String, dynamic>> fetchCategory() async {
    try {
      User? users = FirebaseAuth.instance.currentUser;

      if (users != null) {
        String userUid = users.uid;

        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userUid)
            .collection('expenses')
            .doc(selectedCategory)
            .get();

        print('..............................................');

        if (documentSnapshot.exists) {
          print('Document exists');
          print('Selected category: $selectedCategory');
          Map<String, dynamic> categoryData =
              documentSnapshot.data() as Map<String, dynamic>;
          print('Category data: $categoryData');
          return categoryData;
        } else {
          print('Document does not exist for category: $selectedCategory');
        }
      } else {
        print('User is null');
      }

      // Return an empty map if no data is found
      return {};
    } catch (error) {
      print('Error fetching category data: $error');
      // Return an empty map in case of an error
      return {};
    }
  }

  Future<Map<String, dynamic>?> fetchCategoryDataAndPrevious(String selectedCategory) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null && selectedCategory != null) {
        String userUid = user.uid;

        DocumentReference documentReference = FirebaseFirestore.instance
            .collection('users')
            .doc(userUid)
            .collection('expenses')
            .doc(selectedCategory);

        DocumentSnapshot documentSnapshot = await documentReference.get();

        if (documentSnapshot.exists) {
          Map<String, dynamic> categoryData = documentSnapshot.data() as Map<String, dynamic>;

          QuerySnapshot previousDataSnapshot = await FirebaseFirestore.instance
              .collection('users')
              .doc(userUid)
              .collection('expenses')
              .where('category', isEqualTo: selectedCategory)
              .limit(1)
              .get();

          if (previousDataSnapshot.docs.isNotEmpty) {
            Map<String, dynamic> previousData = previousDataSnapshot.docs.first.data() as Map<String, dynamic>;

            // Merge the data
            Map<String, dynamic> resultData = {...categoryData, 'previousData': previousData};
            return resultData;
          } else {
            // If no previous data, return just the category data
            return categoryData;
          }
        } else {
          print('Document does not exist');
          return null;
        }
      }

      return null;
    } catch (error) {
      print('Error fetching category data: $error');
      return null;
    }
  }
  Future<double> getSumOfValues (String selectedCategory)  async {
    double totalSum = 0;

    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userUid = user.uid;

        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userUid)
            .collection('expenses')
            .doc(selectedCategory)
            .get();

        Map<String, dynamic> categoryData =
        documentSnapshot.data() as Map<String, dynamic>;

        if (categoryData != null) {
          categoryData.forEach((key, value) {
            if (key.startsWith('subcategory')) {
              if (value != null && value is String) {
                double parsedValue = double.tryParse(value) ?? 0;
                totalSum += parsedValue;
              }
            }
          });
        }
      }
    } catch (error) {
      print('Error getting sum of values: $error');
    }

    return totalSum;
  }
}
