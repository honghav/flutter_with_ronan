import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'expense_list.dart';

class ExpenseViwe extends StatefulWidget {
  ExpenseViwe({super.key});

  @override
  State<ExpenseViwe> createState() => _ExpenseViweState();
}
class _ExpenseViweState extends State<ExpenseViwe>{
  final List<Expense> _registeredExpenses = [
    Expense(type: ExpenseType.food, title: "rice", amount: 10, date: DateTime.now()),
    Expense(type: ExpenseType.food, title: "rice", amount: 10, date: DateTime.now()),
    Expense(type: ExpenseType.food, title: "rice", amount: 10, date: DateTime.now())

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text('Ronan-The-Best Expenses App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar'))
              );
            },
          ),

        ],
      ),
      body: ExpensesList(expenses: _registeredExpenses),
    );
  }

}