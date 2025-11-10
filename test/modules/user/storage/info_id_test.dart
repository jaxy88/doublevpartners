import 'package:doublevpartners/modules/user/storage/info_id.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('InfoId', () {
    late InfoId infoId;

    setUp(() {
      infoId = InfoId();
    });

    test('saveUserI guarda correctamente el userId', () async {
      SharedPreferences.setMockInitialValues({});
      await infoId.saveUserI('12345');

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('userId'), equals('12345'));
    });

    test('getUserId retorna el valor guardado correctamente', () async {
      SharedPreferences.setMockInitialValues({'userId': '98765'});

      final result = await infoId.getUserId();
      expect(result, equals('98765'));
    });

    test('getUserId retorna null si no existe valor', () async {
      SharedPreferences.setMockInitialValues({});

      final result = await infoId.getUserId();
      expect(result, isNull);
    });
  });
}
