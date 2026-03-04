import 'package:flutter/material.dart';
import 'package:sql_lite/Models/note_model.dart';
import 'package:sql_lite/database/db_helper.dart';

class EditScreen extends StatefulWidget {
  final Note note;
  const EditScreen({
    super.key,
    required this.note,
  });

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final DbHelper _dbHelper = DbHelper();
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    // Purana data controllers mein dalo
    _titleController = TextEditingController(
      text: widget.note.title,
    );
    _contentController = TextEditingController(
      text: widget.note.content,
    );
  }

  void _updateNote() async {
    if (_titleController.text.isEmpty) return;

    Note updatedNote = Note(
      id: widget.note.id,
      title: _titleController.text,
      content: _contentController.text,
      date: DateTime.now().toString(),
    );

    await _dbHelper.updateNote(updatedNote);

    if (mounted) {
      Navigator.pop(context);
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
      appBar: AppBar(
        title: Text(
          'Edit Note',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            SizedBox(height: 15),

            // Title Field
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

            // Content Field
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

            // Update Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _updateNote,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text('Update Note'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
