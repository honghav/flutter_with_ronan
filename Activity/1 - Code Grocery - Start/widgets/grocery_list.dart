import 'package:flutter/material.dart';
import 'package:flutterwithronan/Activity/1%20-%20Code%20Grocery%20-%20Start/data/dummy_items.dart';
import '../models/grocery_item.dart';
import 'new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = dummyGroceryItems;
  Mode _mode = Mode.normal;
  Future<void> _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem != null) {
      setState(() {
        _groceryItems.add(newItem);
      });
    }
  }
  Future<void> _editItem(GroceryItem item) async {
    final updatedItem = await Navigator.push<GroceryItem>(
      context,
      MaterialPageRoute(
        builder: (ctx) => NewItem(item: item, mode: Mode.editing),
      ),
    );

    if (updatedItem != null) {
      setState(() {
        _groceryItems[_groceryItems.indexWhere((g) => g.id == item.id)] =
            updatedItem;
      });
    }
  }

  void _toggleMode() {
    setState(() {
      if (_mode == Mode.selection) {
        _mode = Mode.normal; // Switch back to normal mode
        for (final item in _groceryItems) {
          item.isSelected = false; // Clear selections
        }
      } else {
        _mode = Mode.selection; // Enter selection mode
      }
    });
  }

  // Handles long-press to enter selection mode and select an item
  void _onLongPress(GroceryItem item) {
    if (_mode == Mode.normal) {
      _toggleMode();
      _toggleSelection(item);
    }
  }

  // Toggles selection of an item
  void _toggleSelection(GroceryItem item) {
    setState(() {
      item.isSelected = !item.isSelected;
    });
  }

  // Removes all selected items from the list
  void _removeSelectedItems() {
    setState(() {
      _groceryItems.removeWhere((item) => item.isSelected);
      _mode = Mode.normal; // Switch back to normal mode
    });
  }

  void _reorderItems(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _groceryItems.removeAt(oldIndex);
      _groceryItems.insert(newIndex, item);
    });
  }
  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));
    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
          itemCount: _groceryItems.length,
          itemBuilder: (ctx, index) => GroceryTile(
            _groceryItems[index],onTap: () => _editItem(_groceryItems[index]) ,
            onCheckBox: (value) => _toggleSelection(_groceryItems[index]),
            onLongPress: () => _onLongPress(_groceryItems[index]),
            mode: _mode, )
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: _mode == Mode.selection
        ? IconButton(
            onPressed: (){
              setState(() {
                _mode = Mode.normal;
                for (final item in _groceryItems){
                  item.isSelected = false;
                }
              }
              );
            },
            icon: const Icon(Icons.arrow_back)
        )
      : null,
        title: const Text('Your Groceries'),
        actions: [
          if (_mode == Mode.normal)
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
          if (_mode == Mode.selection)
            IconButton(
              onPressed: _removeSelectedItems,
              icon: const Icon(Icons.delete),
            ),
        ],
      ),
      body: content,
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile(this.groceryItem, {super.key, required this.onTap, required this.onLongPress, required this.onCheckBox, required this.mode});

  final GroceryItem groceryItem;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final ValueChanged<bool?> onCheckBox;
  final Mode mode;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      title: Text(groceryItem.name),
      leading: mode == Mode.selection
      ? Checkbox(
          value: groceryItem.isSelected
          , onChanged: onCheckBox)
      : Container(
        width: 24,
        height: 24,
        color: groceryItem.category.color,
      ),
      trailing: Text(
        groceryItem.quantity.toString(),
      ),
    );
  }
}