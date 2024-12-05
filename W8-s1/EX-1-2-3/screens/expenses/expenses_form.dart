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
  String? _selectedCategory;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void onCancel() {
    Navigator.pop(context);
  }

  void onAdd() {
    if (_titleController.text.isEmpty ||
        _valueController.text.isEmpty ||
        _selectedCategory == null ||
        _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All fields are required!'))
      );
      return;
    }

    try {
      double amount = double.parse(_valueController.text);
      Expense expense = Expense(
        title: _titleController.text,
        amount: amount,
        date: _selectedDate!,
        category: Category.values.firstWhere(
              (c) => c.toString().split('.').last.toLowerCase() == _selectedCategory!.toLowerCase(),
          orElse: () => Category.food,
        ),
      );

      widget.onCreated(expense);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid amount!'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$')),
                    ],
                    controller: _valueController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      prefixText: '\$ ',
                      labelText: 'Amount',
                    ),
                  ),
                ),
                DatePickerExample(
                  onDateSelected: (date) => _selectedDate = date,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButtonExample(
                  onCategorySelected: (category) => _selectedCategory = category,
                ),
                const SizedBox(width: 20),
                ElevatedButton(onPressed: onCancel, child: const Text('Cancel')),
                const SizedBox(width: 20),
                ElevatedButton(onPressed: onAdd, child: const Text('Create')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  final Function(String) onCategorySelected;

  const DropdownButtonExample({super.key, required this.onCategorySelected});

  @override
  _DropdownButtonExampleState createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  final List<String> categories = ["food", "travel", "leisure", "work"];
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = categories[0];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      items: categories.map((value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedValue = newValue;
        });
        widget.onCategorySelected(newValue!);
      },
    );
  }
}

class DatePickerExample extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const DatePickerExample({super.key, required this.onDateSelected});

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  DateTime selectedDate = DateTime.now();
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected(picked);
    }
  }
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => _selectDate(context),
      child: const Icon(Icons.calendar_today),
    );
  }
}
