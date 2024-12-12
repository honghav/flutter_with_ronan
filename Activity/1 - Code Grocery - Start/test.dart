import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Editable To-Do List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: EditableTodoList(),
    );
  }
}

class EditableTodoList extends StatefulWidget {
  @override
  _EditableTodoListState createState() => _EditableTodoListState();
}

class _EditableTodoListState extends State<EditableTodoList> {
  final List<Map<String, String>> _tasks = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _addTask(String title, String description) {
    if (title.isNotEmpty && description.isNotEmpty) {
      setState(() {
        _tasks.add({'title': title, 'description': description});
      });
      _titleController.clear();
      _descriptionController.clear();
    }
  }

  void _editTask(int index, String newTitle, String newDescription) {
    if (newTitle.isNotEmpty && newDescription.isNotEmpty) {
      setState(() {
        _tasks[index] = {'title': newTitle, 'description': newDescription};
      });
    }
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editable To-Do List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () =>
                      _addTask(_titleController.text, _descriptionController.text),
                  child: Text('Add Task'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return TodoItem(
                  title: _tasks[index]['title']!,
                  description: _tasks[index]['description']!,
                  onEdit: (newTitle, newDescription) =>
                      _editTask(index, newTitle, newDescription),
                  onDelete: () => _deleteTask(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  final String title;
  final String description;
  final Function(String, String) onEdit;
  final VoidCallback onDelete;

  const TodoItem({
    Key? key,
    required this.title,
    required this.description,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool _isEditingTitle = false;
  bool _isEditingDescription = false;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _descriptionController = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: _isEditingTitle
          ? TextField(
        controller: _titleController,
        onSubmitted: (newValue) {
          setState(() {
            _isEditingTitle = false;
            widget.onEdit(newValue, widget.description);
          });
        },
        decoration: InputDecoration(labelText: 'Title'),
      )
          : GestureDetector(
        onTap: () {
          setState(() => _isEditingTitle = true);
        },
        child: Text(widget.title),
      ),
      subtitle: _isEditingDescription
          ? TextField(
        controller: _descriptionController,
        onSubmitted: (newValue) {
          setState(() {
            _isEditingDescription = false;
            widget.onEdit(widget.title, newValue);
          });
        },
        decoration: InputDecoration(labelText: 'Description'),
      )
          : GestureDetector(
        onTap: () {
          setState(() => _isEditingDescription = true);
        },
        child: Text(widget.description),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: widget.onDelete,
      ),
    );
  }
}
