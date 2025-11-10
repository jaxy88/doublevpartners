import 'package:doublevpartners/modules/user/controller/user_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:doublevpartners/dao/adapter_dao.dart';
import 'package:doublevpartners/db/entities/user_entity.dart';
import '../../../mocks/mock_adapter_dao.mocks.dart';
import '../../../mocks/mock_user_dao.mocks.dart';

void main() {
  late UserController controller;
  late MockUserDao mockUserDao;

  late MockAdapterDao mockAdapterDao;

  setUp(() {
    mockUserDao = MockUserDao();
    mockAdapterDao = MockAdapterDao();

    controller = UserControllerTestable(
      userDao: mockUserDao,
      adapterDao: mockAdapterDao,
    );
  });

  group('UserController', () {
    test('insertUser inserta usuario y retorna un ID', () async {
      when(mockUserDao.insert(any)).thenAnswer((_) async => 1);

      final id = await controller.insertUser(
        name: 'Jhon',
        lastName: 'Renteria',
        birthdate: '1995-10-25',
      );

      expect(id, isNotNull);
      verify(mockUserDao.insert(any)).called(1);
    });

    test('insertAddress inserta dirección correctamente', () async {
      when(mockAdapterDao.insert(any)).thenAnswer((_) async => 10);

      final result = await controller.insertAddress(
        userId: 1,
        street: 'Calle 50',
        city: 'Armenia',
      );

      expect(result, 10);
      verify(mockAdapterDao.insert(any)).called(1);
    });

    test('insertMultipleAddresses inserta todas las direcciones', () async {
      when(mockAdapterDao.insert(any)).thenAnswer((_) async => 1);

      final addresses = [
        {'street': 'Calle 1', 'city': 'Medellín'},
        {'street': 'Calle 2', 'city': 'Bogotá'},
      ];

      await controller.insertMultipleAddresses(
        userId: 99,
        addresses: addresses,
      );

      verify(mockAdapterDao.insert(any)).called(2);
    });

    test('getAddressesByUserId retorna lista de direcciones', () async {
      when(mockAdapterDao.getByUserId(1)).thenAnswer(
        (_) async => [
          {'street': 'Calle 1', 'city': 'Cali'},
          {'street': 'Calle 2', 'city': 'Bogotá'},
        ],
      );

      final result = await controller.getAddressesByUserId(1);

      // Assert
      expect(result.length, 2);
      expect(result.first['city'], 'Cali');
      verify(mockAdapterDao.getByUserId(1)).called(1);
    });

    test('getAllUsers retorna lista de usuarios', () async {
      // Arrange
      when(mockUserDao.getAll()).thenAnswer(
        (_) async => [
          {'id': 1, 'name': 'Jhon'},
          {'id': 2, 'name': 'Ana'},
        ],
      );

      // Act
      final result = await controller.getAllUsers();

      // Assert
      expect(result.length, 2);
      expect(result[1]['name'], 'Ana');
      verify(mockUserDao.getAll()).called(1);
    });
  });
}

/// Clase de apoyo para inyectar mocks al controlador original
class UserControllerTestable extends UserController {
  final UserDao userDao;
  final AdapterDao adapterDao;

  UserControllerTestable({required this.userDao, required this.adapterDao})
    : super();
}
