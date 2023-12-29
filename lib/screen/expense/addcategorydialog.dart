// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'expense_provider.dart';

class AddCategoryDialog extends StatelessWidget {
  final TextEditingController categoryNameController = TextEditingController();
  final TextEditingController subcategory1Controller = TextEditingController();
  final TextEditingController subcategory2Controller = TextEditingController();
  final TextEditingController subcategory3Controller = TextEditingController();

  AddCategoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Subcategory'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: categoryNameController,
            decoration: const InputDecoration(labelText: 'Category Name'),
          ),
          TextField(
            controller: subcategory1Controller,
            decoration: const InputDecoration(labelText: 'Subcategory 1'),
          ),
          TextField(
            controller: subcategory2Controller,
            decoration: const InputDecoration(labelText: 'Subcategory 2'),
          ),
          TextField(
            controller: subcategory3Controller,
            decoration: const InputDecoration(labelText: 'Subcategory 3'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            String categoryName = categoryNameController.text;
            String subcategory1 = subcategory1Controller.text;
            String subcategory2 = subcategory2Controller.text;
            String subcategory3 = subcategory3Controller.text;

            await Provider.of<ExpenseProvider>(context, listen: false)
                .addCategoryWithSubcategories(
                    categoryName, subcategory1, subcategory2, subcategory3);

            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
