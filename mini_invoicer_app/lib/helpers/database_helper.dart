import 'package:sqflite/sqflite.dart';
import "dart:io";
import "package:path/path.dart";
import "package:path_provider/path_provider.dart";

class DatabaseHelper {

//  CREATING A SINGLETON
  DatabaseHelper._instance();
  static final DatabaseHelper instance = DatabaseHelper._instance();


  static Database _db;

  String productsTable = "product_table";
  String


  Future<Database> get db async {
    if(_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "mini_invoicer.db");
    final miniInvoicerDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return miniInvoicerDb;
}

  void _onCreateDb(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE 
      '''
    );

    await db.execute(
      '''
      
      '''
    );
  }

  // foreach table, create a method to get the table

  // foreach tableresult, create a method to get the list of the rows


}