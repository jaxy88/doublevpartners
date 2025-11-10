import 'dart:async';

import 'package:doublevpartners/constants/constant.dart';
import 'package:doublevpartners/modules/user/view/address_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../mocks/mock_user_controller.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockUserController mockUserController;

  setUp(() {
    mockUserController = MockUserController();
  });

  testWidgets('Muestra CircularProgressIndicator mientras carga', (
    tester,
  ) async {
    final completer = Completer<List<Map<String, dynamic>>>();

    when(
      mockUserController.getAddressesByUserId(1),
    ).thenAnswer((_) => completer.future);

    await tester.pumpWidget(
      MaterialApp(
        home: AddressListView(userId: 1, userController: mockUserController),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Muestra mensaje cuando no hay direcciones', (
    WidgetTester tester,
  ) async {
    when(
      mockUserController.getAddressesByUserId(1),
    ).thenAnswer((_) async => []);

    await tester.pumpWidget(
      MaterialApp(
        home: AddressListView(userId: 1, userController: mockUserController),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text(notFoundAddressText), findsOneWidget);
  });

  testWidgets('Muestra lista de direcciones correctamente', (
    WidgetTester tester,
  ) async {
    final fakeAddresses = [
      {
        'id': 1,
        'street': 'Calle 123',
        'city': 'Medellín',
        'state': 'Antioquia',
        'country': 'Colombia',
        'zip': '050001',
      },
      {
        'id': 2,
        'street': 'Av. Siempre Viva',
        'city': 'Springfield',
        'state': 'Illinois',
        'country': 'USA',
        'zip': '62701',
      },
    ];

    when(
      mockUserController.getAddressesByUserId(99),
    ).thenAnswer((_) async => fakeAddresses);

    await tester.pumpWidget(
      MaterialApp(
        home: AddressListView(userId: 99, userController: mockUserController),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text(notFoundAddressText), findsNothing);

    expect(find.textContaining('Calle 123'), findsOneWidget);
    expect(find.textContaining('Av. Siempre Viva'), findsOneWidget);

    expect(find.byType(Card), findsNWidgets(2));
  });
}
