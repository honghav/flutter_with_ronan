import 'package:flutter/material.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {

  TextEditingController _titleController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  void onPressed(){
    String title = _titleController.text;
    String Amount = _amountController.text;
    print("Title= $title || Amount = $Amount\$");
  }

  @override
  void dispose(){
    // Dispose the controler
    _titleController.dispose();
    _amountController.dispose();

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          TextField(
            controller: _amountController,
            maxLength: 50,
            decoration: const InputDecoration(
              prefixText: ('\$'),
              label: Text('Amount'),
            ),
          ),

          ElevatedButton(onPressed: onPressed, child: const Text("PRINT VALUES"))

        ],
      ),
    );
  }
}