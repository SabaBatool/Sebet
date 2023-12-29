import 'package:demo/screen/expense/expense_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../widgets/custombutton.dart';
import '../../widgets/customtextbutton.dart';
import '../../widgets/headerwidget.dart';
import 'addcategorydialog.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({Key? key}) : super(key: key);

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  @override
  void initState() {
    super.initState();
    context.read<ExpenseProvider>().fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExpenseProvider(),
      child: Consumer<ExpenseProvider>(
        builder: (context, expenseProvider, child) {
          return Scaffold(
            backgroundColor: const Color(0XFF181818),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const HeaderWidget(text: 'Custom Categories'),
                    const SizedBox(height: 20),
                    Container(
                      width: 320,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0XFF292929),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x26000000),
                            offset: Offset(0, 4),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextField(
                          controller: expenseProvider.categoryTitleController,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0XFFFFFFFF),
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Category Title',
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0XFFA0A0A0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder<List<String>>(
                      future: expenseProvider.fetchCategories(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Show loading indicator
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('No categories found.');
                        } else {
                          List<String> categories = snapshot.data!;
                          return Column(
                            children: categories
                                .map((category) => buildCategory(category))
                                .toList(),
                          );
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          color: Color(0XFF01AA45),
                          size: 30,
                          weight: 300,
                        ),
                        CustomTextButton(
                          label: 'add sub-category',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0XFF01AA45),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AddCategoryDialog();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 90),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: PrimaryButton(
                        text: 'ADD',
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildCategory(String category) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Text(
              category,
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
        const SizedBox(height: 20),
        builddivider(),
      ],
    );
  }

  Widget builddivider() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(20.0),
      child: Container(
        color: const Color(0xFF292929),
        height: 3.0,
      ),
    );
  }
}
