import 'package:doublevpartners/dao/adapter_dao.dart';
import 'package:doublevpartners/db/entities/user_entity.dart';
import 'package:logger/logger.dart';

class UserController {
  final userDao = UserDao();
  final adapterDao = AdapterDao();
  final Logger _logger = Logger();

  Future<int> insertUser({
    required String name,
    required String lastName,
    required String birthdate,
  }) async {
    try {
      final newUserId = DateTime.now().millisecondsSinceEpoch;
      await userDao.insert({
        'id': newUserId,
        'name': name,
        'lastName': lastName,
        'birthdate': birthdate,
      });

      _logger.i('Usuario insertado correctamente con ID: $newUserId');
      return newUserId;
    } catch (e, stack) {
      _logger.e('Error insertando usuario', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<int> insertAddress({
    required int userId,
    required String street,
    required String city,
  }) async {
    try {
      final addressId = await adapterDao.insert({
        'userId': userId,
        'street': street,
        'city': city,
      });

      _logger.i(
        'Dirección insertada correctamente (ID: $addressId) para usuario $userId',
      );
      return addressId;
    } catch (e, stack) {
      _logger.e('Error insertando dirección', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<void> insertMultipleAddresses({
    required int userId,
    required List<Map<String, String>> addresses,
  }) async {
    try {
      for (final address in addresses) {
        await adapterDao.insert({
          'userId': userId,
          'street': address['street'] ?? '',
          'city': address['city'] ?? '',
          'state': address['state'] ?? '',
          'zip': address['zip'] ?? '',
          'country': address['country'] ?? '',
        });
      }

      _logger.i(
        '${addresses.length} direcciones insertadas para usuario $userId',
      );
    } catch (e, stack) {
      _logger.e(
        'Error insertando direcciones múltiples',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAddressesByUserId(int userId) async {
    try {
      final addresses = await adapterDao.getByUserId(userId);

      _logger.i(
        'Se consultaron ${addresses.length} direcciones para el usuario $userId',
      );
      return addresses;
    } catch (e, stack) {
      _logger.e('Error consultando direcciones', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final users = await userDao.getAll();

      _logger.i('Se encontraron ${users.length} usuarios en la base de datos.');
      return users;
    } catch (e, stack) {
      _logger.e(
        'Error obteniendo lista de usuarios',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }
}
