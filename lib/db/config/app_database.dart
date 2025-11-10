// ignore: unnecessary_import
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase _singleton = AppDatabase._();
  static AppDatabase get instance => _singleton;

  Database? _database;

  AppDatabase._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    final dbPath = join(dir.path, 'doublevpartners.db');
    _database = await databaseFactoryIo.openDatabase(dbPath);
    return _database!;
  }
}
