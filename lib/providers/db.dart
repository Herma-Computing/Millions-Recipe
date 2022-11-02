import 'package:sqflite/sqflite.dart';



const String id = 'id';
const String name = 'name';
const String description = 'description';
const String images = 'images';
const String rating = 'name';
const String name = 'name';

class DbProvider {
  late Database db;
  

  /// Open the database.
  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableTodo ( 
  $columnId integer primary key autoincrement, 
  $columnTitle text not null,
  $columnDone integer not null)
''');
    });
  }
}