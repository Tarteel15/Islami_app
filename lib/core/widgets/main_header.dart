import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Image.asset(
          'assets/images/Islami.png',
          height: 50,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}