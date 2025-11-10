import 'package:doublevpartners/modules/user/view/user_view.dart';
import 'package:doublevpartners/widgets/button/primary_button.dart';
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

  Future<void> pumpUserView(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: UserView()));
    await tester.pumpAndSettle();
  }

  testWidgets(
    'Valida que al presionar guardar con campos vacíos no se llame insertUser',
    (WidgetTester tester) async {
      await pumpUserView(tester);

      final button = find.byType(PrimaryButton);
      expect(button, findsOneWidget);

      await tester.tap(button);
      await tester.pump();

      verifyNever(
        mockUserController.insertUser(
          name: anyNamed('name'),
          lastName: anyNamed('lastName'),
          birthdate: anyNamed('birthdate'),
        ),
      );
    },
  );
}
