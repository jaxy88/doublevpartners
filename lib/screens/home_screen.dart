import 'package:doublevpartners/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    setOpacity();
  }

  void setOpacity() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animación Lottie con fade incluido
              SizedBox(
                width: 180,
                height: 180,
                child: Lottie.asset('assets/animations/analysis.json'),
              ),

              const SizedBox(height: 20),

              const Text(
                introTitle,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
