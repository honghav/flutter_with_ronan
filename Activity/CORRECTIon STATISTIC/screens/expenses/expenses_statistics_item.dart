import 'package:flutter/material.dart';

import '../../models/expense.dart';

class ExpensesStatistics extends StatelessWidget {
  const ExpensesStatistics({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...Category.values.map((category) => CategoryCard(
                  category: category,
                  expenses: expenses,
                )),
          ],
        ),
      )),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key, required this.category, required this.expenses});

  final Category category;

  final List<Expense> expenses;

  String get totalAmount {
    double result = 0;

    for (final expense in expenses) {
      if (expense.category == category) {
        result += expense.amount;
      }
    }

    return result.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          totalAmount,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 8),
        Icon(category.icon),
      ],
    );
  }
}
