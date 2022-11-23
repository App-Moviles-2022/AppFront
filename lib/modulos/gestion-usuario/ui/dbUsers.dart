import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:appfront/modulos/gestion-usuario/user-terms-conditions/client-terms-conditions.dart';
import 'package:appfront/modulos/gestion-usuario/models/user-terms-conditions.dart';
import 'package:appfront/modulos/gestion-usuario/models/user-accept-terms.dart';

class DbUser{
  final int version = 1;
  Database? db;

  //para q solo se abra 1 instancia de la BD
    static final DbUser dbUser = DbUser.internal();
  DbUser.internal();
  factory DbUser(){
    return dbUser;
  }

  Future<Database> openDb() async{
    if (db == null){
      //no existe la BD. Se crea
      db = await openDatabase(join(await getDatabasesPath(),
          'bdusers_v5.db'),
          onCreate: (database, version){
            database.execute(
                'CREATE TABLE lists(id INTEGER PRIMARY KEY, userId INTEGER)');
          }, version: version
      );
    }

    return db!;
  }

  Future<int> insertItem(UserAcceptTermsList item) async{
    int id = await this.db!.insert(
        'items',
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace); //indispensable!!
    return id;
  }

  Future<List<UserAcceptTermsList>> getItems(int idList) async{
    final List<Map<String, dynamic>> maps =
    await db!.query('items', where: 'idList = ?', whereArgs: [idList]);

    return List.generate(maps.length, (i) {
      return UserAcceptTermsList(
        maps[i]['id'],
        maps[i]['userId'],
      );
    });
  }

  Future<int> deleteItem(UserAcceptTermsList item) async{
    int result = await db!.delete('items', where: 'id = ?', whereArgs: [item.id]);

    return result;
  }
}