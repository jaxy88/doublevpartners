import 'package:doublevpartners/db/config/app_database.dart';
import 'package:sembast/sembast.dart';

class UserDao {
  static const String storeName = 'tbl_users';
  final _store = intMapStoreFactory.store(storeName);

  Future<Database> get _db async => AppDatabase.instance.database;

  Future<int> insert(Map<String, dynamic> user) async {
    return await _store.add(await _db, user);
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    final snapshots = await _store.find(await _db);
    return snapshots.map((e) => e.value).toList();
  }
}
