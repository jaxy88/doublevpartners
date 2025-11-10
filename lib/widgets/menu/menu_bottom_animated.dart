import 'package:doublevpartners/constants/constant.dart';
import 'package:doublevpartners/modules/user/view/user_list_view.dart';
import 'package:doublevpartners/modules/user/view/user_view.dart';
import 'package:doublevpartners/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:ionicons/ionicons.dart';

class MenuBottomAnimated extends StatefulWidget {
  const MenuBottomAnimated({super.key});

  @override
  State<MenuBottomAnimated> createState() => _MenuBottomAnimatedState();
}

class _MenuBottomAnimatedState extends State<MenuBottomAnimated> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [HomeScreen(), UserListView(), UserView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (Widget child, Animation<double> animation) {
          // Animación de desvanecido + desplazamiento lateral
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.1, 0.0), // empieza levemente a la derecha
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: colorPrimary,
        activeColor: Colors.white,
        color: Colors.white70,
        items: const [
          TabItem(icon: Ionicons.home_outline, title: startText),
          TabItem(icon: Ionicons.search_outline, title: searchText),
          TabItem(icon: Ionicons.person_outline, title: creaUserText),
        ],
        initialActiveIndex: _selectedIndex,
        onTap: (int index) {
          if (index != _selectedIndex) {
            setState(() => _selectedIndex = index);
          }
        },
      ),
    );
  }
}
