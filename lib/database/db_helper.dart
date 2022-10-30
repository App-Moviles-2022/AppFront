import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DBHelper{
  final int version = 1;
  Database? db;

  Future<Database> openDb() async{
    // ignore: prefer_conditional_assignment
    if(db == null) {
      db = await openDatabase(join(await getDatabasesPath(),
      'bdcompras.db'),
        onCreate: (database, version) {
          database.execute(
              'CREATE TABLE lists(id INTEGER PRIMARY KEY, name TEXT, priority INTEGER)');
          database.execute(
              'CREATE TABLE items(id INTEGER PRIMARY KEY, idList INTEGER),'
                  'name TEXT, quantity TEXT, note TEXT, FOREIGN KEY(idList) REFERENCES lists(id)');
        }, version: version
          );
    }
    return db!;
  }

  Future testDB() async {
    db = await openDb();
    await db!.execute('INSERT INTO lists VALUES (0, "Memorias", 1)');
    await db!.execute('INSERT INTO items VALUES (0, 0, "Memorias DDR 3", "20 unds.", "Marca Kignstone")');

    List list = await db!.rawQuery('SELECT * FROM lists');
    List items = await db!.rawQuery('SELECT * FROM items');

    print(list[0]);
    print(items[0]);
  }
}