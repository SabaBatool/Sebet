import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../widgets/customtextbutton.dart';
import '../../widgets/headerwidget.dart';
import 'expense.dart';
import 'expense_add.dart';
import 'expense_provider.dart';

class EmpetyExpense extends StatefulWidget {
  const EmpetyExpense({Key? key}) : super(key: key);

  @override
  State<EmpetyExpense> createState() => _EmpetyExpenseState();
}

class _EmpetyExpenseState extends State<EmpetyExpense> {
  double totalExpense = 0.0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF181818),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HeaderWidget(text: 'Expense'),
              const SizedBox(height: 10),
              Container(
                width: 391,
                height: 50,
                margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF292929),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0XFF656565),
                    ),
                    child: const Icon(Icons.add),
                  ),
                  CustomTextButton(
                    label: 'Add Expense',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0XFF656565),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Expense(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Text(
                    'YOU CANT ADD EXPENSE AS YOU HAVE ALREADY USED 100% OF YOUR EXPECTED INCOME',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0XFFED3237),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 70),
              SizedBox(
                height: 900,
                child: Consumer<ExpenseProvider>(
                  builder: (context, provider, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListView.builder(
                        itemCount: provider.categories.length,
                        itemBuilder: (context, index) {
                          String selectedCategory = provider.categories[index];
                          return FutureBuilder(
                              future: provider.fetchCategoryDataAndPrevious(
                                  selectedCategory),
                              builder: (context, categorySnapshot) {
                                if (categorySnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (categorySnapshot.hasError) {
                                  return Text(
                                      'Error: ${categorySnapshot.error}');
                                } else if (!categorySnapshot.hasData ||
                                    categorySnapshot.data == null) {
                                  return const Text('No data available');
                                } else {
                                  Map<String, dynamic>? categoryData =
                                      categorySnapshot.data;

                                  if (categoryData == null) {
                                    return const Text('Category data is null');
                                  }

                                  String subcategoryKey = '\$subcategory3'; // replace with the actual subcategory key you want to use
                                  // totalExpense = provider.calculateTotalExpense(subcategoryKey, categoryData);


                                  print('\$$totalExpense');

                                  return Column(
                                    children: [
                                      Slidable(
                                        actionPane:
                                            const SlidableDrawerActionPane(),
                                        secondaryActions: <Widget>[
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const AddddExpense(),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: 400,
                                                  width: 80,
                                                  color: Colors.green,
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'Edit',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        textStyle:
                                                            const TextStyle(
                                                          color:
                                                              Color(0XFFFFFFFF),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            child: Material(
                                              child: InkWell(
                                                onTap: () {
                                                  Provider.of<ExpenseProvider>(
                                                          context,
                                                          listen: false)
                                                      .deleteExpense(
                                                          selectedCategory);
                                                },
                                                child: Container(
                                                  height: 400,
                                                  width: 80,
                                                  color: Colors.red,
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'Delete',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        textStyle:
                                                            const TextStyle(
                                                          color:
                                                              Color(0XFFFFFFFF),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                        child: SizedBox(
                                          height: 250,
                                          child: Container(
                                            width: 420,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: const Color(0XFF292929),
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 15,
                                                  height: 250,
                                                  child: IntrinsicHeight(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        bottom: 30,
                                                        top: 20,
                                                      ),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: const Color(
                                                              0xFFFFB800),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            categoryData[
                                                                        'category']
                                                                    ?.toString() ??
                                                                '',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              textStyle:
                                                                  const TextStyle(
                                                                color: Color(
                                                                    0xfffFFFFF),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 25,
                                                              ),
                                                            ),
                                                          ),
                                                          const Gap(50),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              '\$$totalExpense',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                textStyle:
                                                                    const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0XFFFFFFFF),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Gap(20),
                                                    buildConvenienceRow(
                                                      categoryData[
                                                                  'subcategory1']
                                                              ?.toString() ??
                                                          '',
                                                      categoryData[
                                                                  'subcategory1']
                                                              ?.toString() ??
                                                          '',
                                                      categoryData,
                                                    ),
                                                    const SizedBox(height: 10),
                                                    buildDivider(),
                                                    const SizedBox(height: 10),
                                                    buildConvenienceRow(
                                                      categoryData[
                                                                  'subcategory2']
                                                              ?.toString() ??
                                                          '',
                                                      categoryData[
                                                                  'subcategory2']
                                                              ?.toString() ??
                                                          '',
                                                      categoryData,
                                                    ),
                                                    const SizedBox(height: 10),
                                                    buildDivider(),
                                                    const SizedBox(height: 10),
                                                    buildConvenienceRow(
                                                      categoryData[
                                                                  'subcategory3']
                                                              ?.toString() ??
                                                          '',
                                                      categoryData[
                                                                  'subcategory3']
                                                              ?.toString() ??
                                                          '',
                                                      categoryData,
                                                    ),
                                                    const SizedBox(height: 10),
                                                    buildDivider(),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                    ],
                                  );
                                }
                              });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildConvenienceRow(String subcategory, String subcategoryKey,
      Map<String, dynamic> categoryData) {
    return Row(
      children: [
        Text(
          subcategory,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Color(0xfffFFFFF),
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
        const Gap(120),
        Text(
          '${categoryData[subcategoryKey] ?? ''}',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Color(0xfffFFFFF),
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDivider() {
    return Container(
      width: 320,
      height: 2,
      color: const Color(0XFF181818),
    );
  }


}
