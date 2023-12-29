import 'package:flutter/material.dart';


class AddDebtDialog extends StatefulWidget {
  const AddDebtDialog({Key? key}) : super(key: key);

  @override
  _AddDebtDialogState createState() => _AddDebtDialogState();
}

class _AddDebtDialogState extends State<AddDebtDialog> {
  late TextEditingController debtNameController;
  late TextEditingController debtAmountController;
  late TextEditingController paidAmountController;

  @override
  void initState() {
    super.initState();
    debtNameController = TextEditingController();
    debtAmountController = TextEditingController();
    paidAmountController = TextEditingController();
  }

  @override
  void dispose() {
    debtNameController.dispose();
    debtAmountController.dispose();
    paidAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Debt'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: debtNameController,
            decoration: const InputDecoration(labelText: 'Debt Name'),
          ),
          TextField(
            controller: debtAmountController,
            decoration: const InputDecoration(labelText: 'Debt Amount (\$)'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: paidAmountController,
            decoration: const InputDecoration(labelText: 'Paid Amount (\$)'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
