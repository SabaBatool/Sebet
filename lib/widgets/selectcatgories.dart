import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../screen/expense/expense_add.dart';
import '../screen/expense/expense_provider.dart';

class SlidableRow extends StatelessWidget {
  final String text;

  const SlidableRow({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      secondaryActions: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
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
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0XFFFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Delete action
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Material(
            child: InkWell(
              onTap: () {
                Provider.of<ExpenseProvider>(context, listen: false).deleteExpense(text);
              },

              child: Container(
                height: 400,
                width: 80,
                color: Colors.red,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Delete',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0XFFFFFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 30),
        child: Container(
          width: 310,
          height: 66,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color(0x26000000),
                offset: Offset(0, 4),
                blurRadius: 20,
              ),
            ],
            color: const Color(0XFF292929),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color(0XFFFFFFFF),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Example usage:
// SlidableRow(text: 'Your Text Here');
