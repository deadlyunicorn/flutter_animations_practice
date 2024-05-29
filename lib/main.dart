import 'package:animations_practise/page_transition.dart';
import 'package:flutter/material.dart';
// reference: https://codepen.io/mknadler/pen/oYKPpr

void main() {
  runApp(const MaterialPageWrapper(child: PageTransition()));
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
