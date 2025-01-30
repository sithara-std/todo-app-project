import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final TextEditingController _controller = TextEditingController();

  // Function to save the note (you can modify this to save to a database or list)
  void _saveNote() {
    final note = _controller.text;
    if (note.isNotEmpty) {
      // Do something with the note, like saving it to a list or database
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Note Saved: $note')),
      );
      Navigator.pop(context); // Close the note page after saving
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a note')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 218, 241), // Changed background color
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 111, 13, 105),
        title: const Text('Add a Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Enter your note here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveNote,
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 251, 242, 249),
                backgroundColor: Colors.purple,
              ),
              child: const Text('Save Note'),
            ),
          ],
        ),
      ),
    );
  }
}
