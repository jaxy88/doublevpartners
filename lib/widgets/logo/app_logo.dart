import 'package:doublevpartners/constants/constant.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: Image(
        color: colorPrimary,
        height: 150,
        width: 280,
        image: AssetImage('assets/images/logo-v-partners.png'),
      ),
    );
  }
}
