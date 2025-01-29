import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/todo.dart';
import 'package:myapp/welcome_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  // ignore: library_private_types_in_public_api
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedPriority = 'Low';
  DateTime? _dueDate;
  final CollectionReference todosCollection = FirebaseFirestore.instance.collection('todos');

  Future<void> _addTodo() async {
    if (_titleController.text.isNotEmpty) {
      await todosCollection.add({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'priority': _selectedPriority,
        'dueDate': _dueDate?.toIso8601String(),
        'isCompleted': false,
      });
      _clearFields();
      _showMessage("Task added successfully!");
    } else {
      _showMessage("Title cannot be empty");
    }
  }

  void _clearFields() {
    setState(() {
      _titleController.clear();
      _descriptionController.clear();
      _selectedPriority = 'Low';
      _dueDate = null;
    });
  }

  Future<void> _editTodo(Todo todo) async {
    _titleController.text = todo.title;
    _descriptionController.text = todo.description;
    _selectedPriority = todo.priority;
    _dueDate = todo.dueDate;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 213, 161, 205),
          title: const Text(
            'Edit Task',
            style: TextStyle(
          color: Color.fromARGB(255, 111, 13, 105), // Title text color
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField('Title', _titleController),
                const SizedBox(height: 8),
                _buildTextField('Description', _descriptionController),
                const SizedBox(height: 8),
                _buildPriorityDropdown(),
                const SizedBox(height: 8),
                _buildDueDateSelector(),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 111, 13, 105),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 142, 71, 126),
                foregroundColor: const Color.fromARGB(255, 241, 236, 241),
              ),
              onPressed: () async {
                if (_titleController.text.isNotEmpty) {
                  await todosCollection.doc(todo.id).update({
                    'title': _titleController.text,
                    'description': _descriptionController.text,
                    'priority': _selectedPriority,
                    'dueDate': _dueDate?.toIso8601String(),
                  });
                  _clearFields();
                  _showMessage("Task updated successfully!");
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                } else {
                  _showMessage("Title cannot be empty");
                }
              },
              child: const Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteTodo(String id) async {
    await todosCollection.doc(id).delete();
    _showMessage("Task deleted successfully!");
  }

  Future<void> _toggleCompletion(String id, bool isCompleted) async {
    await todosCollection.doc(id).update({'isCompleted': !isCompleted});
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.greenAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 210, 201, 207),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 111, 13, 105),
        title: Text(
          'ToDo List',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildTaskInputCard(),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: todosCollection.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final tasks = snapshot.data!.docs;
                return _buildTaskList(tasks);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskInputCard() {
    return Card(
      color: const Color.fromARGB(255, 219, 185, 207),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField('Title', _titleController),
            const SizedBox(height: 8),
            _buildTextField('Description', _descriptionController),
            const SizedBox(height: 8),
            _buildPriorityDropdown(),
            const SizedBox(height: 8),
            _buildDueDateSelector(),
            const SizedBox(height: 8),
            _buildAddTaskButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPriorityDropdown() {
    return DropdownButton<String>(
      value: _selectedPriority,
      isExpanded: true,
      items: ['Low', 'Medium', 'High'].map((priority) {
        return DropdownMenuItem(value: priority, child: Text(priority));
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedPriority = value!;
        });
      },
    );
  }

  Widget _buildDueDateSelector() {
    return TextButton(
      onPressed: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        setState(() {
          _dueDate = selectedDate;
        });
      },
      child: Text(
        _dueDate == null ? 'Select Due Date' : 'Due Date: ${_dueDate!.toLocal()}'.split(' ')[0],
        style: const TextStyle(color: Color.fromARGB(255, 11, 10, 11)),
      ),
    );
  }

  Widget _buildAddTaskButton() {
    return ElevatedButton(
      onPressed: _addTodo,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 142, 71, 126),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text('Add Task', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildTaskList(List<DocumentSnapshot> tasks) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        final todo = Todo.fromMap(task.id, task.data() as Map<String, dynamic>);
        return _buildTaskCard(todo);
      },
    );
  }

  Widget _buildTaskCard(Todo todo) {
    return Card(
      color: Colors.purple.shade100,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: ListTile(
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('${todo.description}\nPriority: ${todo.priority}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              activeColor: Colors.deepPurple,
              value: todo.isCompleted,
              onChanged: (value) {
                _toggleCompletion(todo.id, todo.isCompleted);
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Color.fromARGB(255, 93, 131, 164)),
              onPressed: () => _editTodo(todo),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Color.fromARGB(255, 166, 81, 75)),
              onPressed: () => _deleteTodo(todo.id),
            ),
          ],
        ),
      ),
    );
  }
}
