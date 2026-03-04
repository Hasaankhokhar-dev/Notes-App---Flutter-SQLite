import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Models/note_model.dart';
class DbHelper {
  static Database? _database;

  // create a database
  Future<Database> get database async {
    if(_database != null){
      return _database!;
    }
    _database = await _initDb();
    return _database!;
  }
  //  initilze databse
   Future<Database> _initDb() async{
    String path = join (await getDatabasesPath(), 'notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTable,
    );
   }
   // create table
  Future<void > _createTable(Database db, int version) async{
    await db.execute('''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY,
        title TEXT,
        content TEXT,
        date TEXT
      )
    ''');
  }

  Future<void> insertNote(Note note) async{
    final db = await database;
    await db.insert('notes', note.toMap());
  }

  Future<List<Note>> getNotes() async {
    // database lo
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('notes');
    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }

  Future<void> updateNote(Note note) async {
    final db = await database;
     await db.update(
      'notes',
      note.toMap(),
         where: 'id = ?',
         whereArgs: [note.id],
     );
  }
  Future<void> deleteNote(int id) async {
    final db = await database;
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
