import 'package:doublevpartners/db/config/app_database.dart';
import 'package:sembast/sembast.dart';

class AddressDao {
  static const String storeName = 'tbl_addresses';
  final _store = intMapStoreFactory.store(storeName);

  Future<Database> get _db async => AppDatabase.instance.database;

  Future<int> insert(Map<String, dynamic> address) async {
    return await _store.add(await _db, address);
  }

  Future<List<Map<String, dynamic>>> getByUserId(int userId) async {
    final finder = Finder(filter: Filter.equals('userId', userId));
    final snapshots = await _store.find(await _db, finder: finder);
    return snapshots.map((e) => e.value).toList();
  }
}
