import 'package:flutter/material.dart';
import 'package:sql_lite/Models/note_model.dart';
import 'package:sql_lite/database/db_helper.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final DbHelper _dbHelper = DbHelper();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _saveNote() async {
    try {
      Note note = Note(
        title: _titleController.text,
        content: _contentController.text,
        date: DateTime.now().toString(),
      );
      await _dbHelper.insertNote(note);
      print("Inserted Successfully");
      Navigator.pop(context);
    } catch (e) {
      print("Error: $e");
    }
  }
   @override
   void dispose() {
     _titleController.dispose();
     _contentController.dispose();
     super.dispose();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            SizedBox(height: 15),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),

            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _saveNote, child: Text('Save Note')),
          ],
        ),
      ),
    );
  }
}
