import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mocks/mock_adapter_dao.mocks.dart';

void main() {
  late MockAdapterDao mockAdapterDao;

  setUp(() {
    mockAdapterDao = MockAdapterDao();
  });

  group('AdapterDao Mock', () {
    test(
      'getByUserId retorna solo direcciones del usuario especificado',
      () async {
        when(mockAdapterDao.getByUserId(1)).thenAnswer(
          (_) async => [
            {
              'userId': 1,
              'street': 'Calle A',
              'city': 'Medellin',
              'state': 'Antioquia',
              'zip': '0001',
              'country': 'Colombia',
            },
            {
              'userId': 1,
              'street': 'Calle C',
              'city': 'Armenia',
              'state': 'Quindio',
              'zip': '0003',
              'country': 'Colombia',
            },
          ],
        );

        when(mockAdapterDao.getByUserId(2)).thenAnswer(
          (_) async => [
            {
              'userId': 2,
              'street': 'Calle B',
              'city': 'Buenaventura',
              'state': 'Valle',
              'zip': '0002',
              'country': 'Colombia',
            },
          ],
        );

        final resultUser1 = await mockAdapterDao.getByUserId(1);
        final resultUser2 = await mockAdapterDao.getByUserId(2);

        expect(resultUser1.length, 2);
        expect(resultUser1.any((r) => r['userId'] == 2), isFalse);

        expect(resultUser2.length, 1);
        expect(resultUser2.first['street'], 'Calle B');

        verify(mockAdapterDao.getByUserId(1)).called(1);
        verify(mockAdapterDao.getByUserId(2)).called(1);
      },
    );
  });
}
