import 'package:demo/screen/sinking_fund/sinking_fund.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../widgets/arrowbutton.dart';
import '../../widgets/customtextbutton.dart';

import '../../widgets/headerwidget.dart';
import '../../widgets/selectcatgories.dart';
import '../../widgets/Slidable.dart';
import 'addsbcategory.dart';
import '../sinking_fund/create_fund.dart';
import 'expense_provider.dart';

class CustomCategoriesEdit extends StatefulWidget {
  const CustomCategoriesEdit({Key? key}) : super(key: key);

  @override
  State<CustomCategoriesEdit> createState() => _CustomCategoriesEditState();
}

class _CustomCategoriesEditState extends State<CustomCategoriesEdit> {
  // Removed the fetchCategories call from initState

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      // Specify the type of the provider
      builder: (BuildContext context, expenseProvider, child) {
        return Scaffold(
          backgroundColor: const Color(0XFF181818),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const HeaderWidget(text: 'Custom Categories'),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.green,
                        ),
                        child: Image.asset('assets/images/Path.png'),
                      ),
                      CustomTextButton(
                        label: 'Add Category',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0XFF01AA45),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateCategory(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: double.maxFinite,
                    child: FutureBuilder(

                      future: expenseProvider.fetchCategories(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return const Text('No data available');
                        } else {
                          List<String> categories =
                          snapshot.data as List<String>;

                          return ListView(

                            children: categories.map((category) {
                              return Column(
                                children: [
                                  SlidableRow(
                                    text: category,
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children:  [
                        CustomSlidable(
                          onEdit: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SinkingFund(),
                              ),
                            );
                          },
                          onDelete: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
