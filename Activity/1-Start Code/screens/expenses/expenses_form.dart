import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key, required this.onCreated});

  final Function(Expense) onCreated;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();

  String get title => _titleController.text;

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void onCancel() {
    
    // Close modal
    Navigator.pop(context);
  }

  // void onAdd() {
  //   // 1- Get the values from inputs
  //   String title = _titleController.text;
  //
  //   double amount = double.parse(_valueController.text);
  //
  //   // 2- Create the expense
  //   Expense expense = Expense(
  //       title: title,
  //       amount: amount,
  //       date: DateTime.now(),     //  TODO :  For now it s a fake data
  //       category: Category.food); //  TODO :  For now it s a fake data
  //
  //   // 3- Ask the parent to add the expense
  //   widget.onCreated(expense);
  //   // if (_titleController == null){
  //   //
  //   //
  //   // }
  //   // 4- Close modal
  //   Navigator.pop(context);
  // }

//   void onAdd() {
//     // 1- Get the values from inputs
//     String title = _titleController.text;
//     double? amount;
//
//     // Validate the amount input
//     try {
//       amount = double.parse(_valueController.text);
//     } catch (e) {
//       _showErrorDialog('Invalid amount. Please enter a valid number.');
//       return;
//     }
//
//     if (title.isEmpty || amount <= 0) {
//       _showErrorDialog('Please enter a valid title and amount.');
//       return;
//     }
//
//     // 2- Create the expense
//     Expense expense = Expense(
//       title: title,
//       amount: amount,
//       date: DateTime.now(),     //  TODO :  For now it's a fake data
//       category: Category.food,  //  TODO :  For now it's a fake data
//     );
//
//     // 3- Ask the parent to add the expense
//     widget.onCreated(expense);
//
//     // 4- Close modal
//     Navigator.pop(context);
//   }
//
// // Function to show an error dialog
//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Error'),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: _valueController,
            maxLength: 50,
            decoration: const InputDecoration(
              prefix: Text('\$ '),
              label: Text('Amount'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: onCancel, child: const Text('Cancel')),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(onPressed: onAdd, child: const Text('Create')),
            ],
          )
        ],
      ),
    );
  }
}
