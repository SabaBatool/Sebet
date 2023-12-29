// ignore_for_file: use_build_context_synchronously

import 'package:demo/screen/expense/customcategories.dart';

import 'package:demo/widgets/custombutton.dart';
import 'package:demo/widgets/customtextbutton.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../widgets/arrowbutton.dart';
import '../../widgets/headerwidget.dart';
import 'addsbcategory.dart';

import 'emptyexpance.dart';
import 'expense_provider.dart';

class AddddExpense extends StatefulWidget {
  const AddddExpense({Key? key}) : super(key: key);

  @override
  State<AddddExpense> createState() => _AddddExpenseState();
}

class _AddddExpenseState extends State<AddddExpense> {
  final Map<String, TextEditingController> subcategoryControllers = {};
  @override
  void initState() {
    super.initState();
    ExpenseProvider expenseProvider =
        Provider.of<ExpenseProvider>(context, listen: false);

    expenseProvider.fetchCategories().then((categories) {
      print('Fetched categories: $categories');
      if (mounted) {
        setState(() {
          // Update the categories in the provider only if it's not null
          if (categories != null) {
            expenseProvider.categories = categories;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var expenseProvider = Provider.of<ExpenseProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double containerWidth = 0.5 * screenWidth;
    double containerHeight = 0.05 * screenHeight;
    print('Selected Category: ${expenseProvider.selectedCategory}');
    return Consumer<ExpenseProvider>(builder: (context, provider, child) {
      print("|Added in ");
      expenseProvider = provider;
      return Scaffold(
        backgroundColor: const Color(0XFF181818),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const HeaderWidget(text: 'Add Expense'),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomTextButton(
                    label: 'Custom-categories',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0XFF01AA45),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CustomCategories(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                buildCatrgoriesselectfield(provider),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: provider.selectedCategory != null,
                  child: Column(
                    children: [
                      buildDividerLine(),
                      const SizedBox(
                        height: 10,
                      ),
                      FutureBuilder<List<String>>(
                        future: expenseProvider
                            .fetchCategoryData(provider.selectedCategory ?? ''),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return const Text('Error loading subcategories');
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Text('No subcategories available');
                          } else {
                            List<String> subcategories = snapshot.data!;

                            return Column(
                              children: subcategories.map((subCategory1) {
                                if (!subcategoryControllers
                                    .containsKey(subCategory1)) {
                                  subcategoryControllers[subCategory1] =
                                      TextEditingController();
                                }
                                return buildCategiries(
                                  containerWidth,
                                  containerHeight,
                                  subCategory1,
                                  '\$0.00',
                                  subcategoryControllers[subCategory1]!,
                                );
                              }).toList(),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add,
                            size: 26.0,
                            color: Color(0xFF01AA45),
                          ),
                          CustomTextButton(
                            label: 'add more',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0XFF01AA45),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CreateCategory(),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: PrimaryButton(
                          text: 'Add',
                          onPressed: () async {
                            print('.................working..............');
                            Map<String, String> subcategoryValues = {};
                            subcategoryControllers
                                .forEach((subCategory, controller) {
                              print(
                                  '.................not working..............');
                              subcategoryValues[subCategory] = controller.text;
                            });

                            ExpenseProvider expenseProvider =
                                Provider.of<ExpenseProvider>(context,
                                    listen: false);
                            print(
                                '.................$subcategoryValues..............');
                            await expenseProvider
                                .updateCategoryWithSubcategoryValues(
                              provider.selectedCategory ?? '',
                              subcategoryValues,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EmpetyExpense(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildCategiries(double containerWidth, double containerHeight,
      String text, String hinttext, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.06,
                  color: Color(0XFFB7B6B6),
                ),
              )),
          Container(
            width: containerWidth,
            height: containerHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF292929),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33000000),
                  offset: Offset(0, 3),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: TextField(
                controller: controller,
                style: const TextStyle(color: Color(0xFFFFFFFF)), // Text color
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hinttext,
                  hintStyle: const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTitlebar() {
    return Row(
      children: [
        const ArrowButton(),
        const SizedBox(
          width: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Text(
            'Add Expense',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color(0XFFFFFFFF),
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCatrgoriesselectfield(ExpenseProvider provider) {
    return Container(
      width: 391,
      height: 50,
      margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFFFFFFF),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          value: provider.selectedCategory,
          icon: const Padding(
            padding: EdgeInsets.only(left: 25),
            child: Icon(
              Icons.arrow_drop_down,
              color: Color(0XFF181818),
            ),
          ),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(
            color: Color(0XFF181818),
          ),
          onChanged: (String? newValue) {
            provider.setSelectedCategory(newValue);
          },
          items:
              provider.categories.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildDividerLine() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(20.0),
      child: Container(
        color: const Color(0xFF292929),
        height: 3.0,
      ),
    );
  }
}
