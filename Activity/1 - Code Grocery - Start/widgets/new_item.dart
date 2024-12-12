import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/grocery_category.dart';
import '../models/grocery_item.dart';
enum Mode {creting , editing , selection , normal}
class NewItem extends StatefulWidget {
  final Mode mode;
  final GroceryItem? item;
  const NewItem({super.key , this.mode = Mode.creting , this.item});

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}
class _NewItemState extends State<NewItem> {

  final _formkey = GlobalKey<FormState>();

  String _enteredName = '';
  int _enteredQuantity = 1;
  GroceryCategory _selectedCategory = GroceryCategory.fruit;

  void _saveItem(){
    if (_formkey.currentState!.validate()){
      _formkey.currentState!.save();
      const uuid =Uuid();
      final newId = uuid.v4();
      Navigator.pop(
        context,
        GroceryItem(
          id: newId,
          name: _enteredName,
          quantity: _enteredQuantity,
          category: _selectedCategory,
        ),
      );
    }
  }
  @override
  void initState() {
    super.initState();
    if(widget.mode == Mode.editing){
      _enteredName = widget.item!.name;
      _enteredQuantity = widget.item!.quantity;
      _selectedCategory = widget.item!.category;
    }
  }
  void _resetForm() {
    _formkey.currentState!.reset();
  }
  String? validateTitle(String? value) {
    if (value == null || value.isEmpty || value.trim().length > 50) {
      return 'Must be between 1 and 50 characters.';
    }
    return null;
  }

  String? validateQuantity(String? value) {
    if (value == null ||
        value.isEmpty ||
        int.tryParse(value) == null ||
        int.tryParse(value)! <= 0) {
      return 'Must be a valid positive number.';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _enteredName,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                validator: validateTitle,
                onSaved: (value) {
                  _enteredName = value!;
                },


              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: '1',
                      validator: validateQuantity,
                      onSaved: (value) {
                        _enteredQuantity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<GroceryCategory>(
                      value: _selectedCategory,
                      items: [
                        for (final category in GroceryCategory.values)
                          DropdownMenuItem<GroceryCategory>(
                            value: category,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.color,
                                ),
                                const SizedBox(width: 6),
                                Text(category.label),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _resetForm,
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: const Text('Add Item'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
