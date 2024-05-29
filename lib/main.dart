import 'package:animations_practise/hero_animation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialPageWrapper(child: HeroAnimation()));
}

class MaterialPageWrapper extends StatelessWidget {
  const MaterialPageWrapper({
    required this.child,
    super.key,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: child,
        ),
      ),
    );
  }
}
