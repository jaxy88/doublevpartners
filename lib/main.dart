// ignore_for_file: unused_import

import 'package:doublevpartners/constants/constant.dart';
import 'package:doublevpartners/modules/user/controller/user_getx_controller.dart';
import 'package:doublevpartners/modules/user/view/user_view.dart';
import 'package:doublevpartners/theme/themes.dart';
import 'package:doublevpartners/widgets/menu/menu_bottom_animated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<UserGetxController>(() => UserGetxController());
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('es')],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Raleway',
        appBarTheme: AppBarTheme(
          backgroundColor: colorPrimary,
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: Themes.dark,
      title: 'DOUBLE V PARTNERS NY',
      routes: {"user": (BuildContext context) => const UserView()},
      home: MenuBottomAnimated(),
    );
  }
}
