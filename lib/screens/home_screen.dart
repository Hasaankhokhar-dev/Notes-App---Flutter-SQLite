import 'package:flutter/material.dart';
import 'package:sql_lite/Models/note_model.dart';
import 'package:sql_lite/database/db_helper.dart';
import 'package:sql_lite/screens/add_screen.dart';
import 'package:sql_lite/screens/edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DbHelper _dbHelper = DbHelper();
  List<Note> _notes = [];

  void _loadNotes() async {
    final notes = await _dbHelper.getNotes();
    setState(() {
      _notes = notes;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "My Notes",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.blueGrey,
      ),

      // Notes Empty Hain?
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: ListTile(
              // Title
              title: Text(
                _notes[index].title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              // Content
              subtitle: Text(_notes[index].content),

              // Edit (Note pe click karo)
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditScreen(
                      note: _notes[index],
                    ),
                  ),
                );
                _loadNotes();
              },

              // Delete button
              trailing: IconButton(
                onPressed: () async {
                  await _dbHelper.deleteNote(_notes[index].id!);
                  _loadNotes();
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          );
        },
      ),

      // Add button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddScreen()),
          );
          _loadNotes(); // Wapis aao toh refresh karo
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}