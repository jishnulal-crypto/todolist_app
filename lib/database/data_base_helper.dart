import 'package:note_keeper/database/model_class.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper{
  late Database _dataBaseHelper;

   //open and create database
   Future openNoteAppDb() async {
    _dataBaseHelper = await openDatabase(
        join(await getDatabasesPath(), "noteapp.db"),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE noteapptable(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT, description TEXT )");
    });
  }

  //save data to data base
  Future<int> insertDataToDb(Note note) async {  
    await openNoteAppDb();
    return await _dataBaseHelper.insert('noteapptable',
        note.toMap());                     
  }

  //get data from database
  Future<List<Note>> getDataFromDb() async {
    await openNoteAppDb();
    final List<Map<String, dynamic>> data =
        await _dataBaseHelper.query('noteapptable');   
    return List.generate(data.length, (index) {
      return Note(id: data[index]['id'], 
      title: data[index]['title'],
      description: data[index]['description']
      );
    });
  }

  //update data to database
  Future<int> updateNoteToDb(Note note) async {
    await openNoteAppDb();
    return await _dataBaseHelper.update(
        'noteapptable', note.toMap(),      
        where: 'id=?',
        whereArgs: [note.id]);
  }

  //delete data from data base
  Future<void> deleteData(int id) async {
    await openNoteAppDb();
    await _dataBaseHelper
        .delete("noteapptable", where: "id = ? ", whereArgs: [id]);
  }
}