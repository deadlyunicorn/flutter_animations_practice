import 'package:animations_practise/physics_spring_demo.dart';
import 'package:flutter/material.dart';
// reference: https://codepen.io/mknadler/pen/oYKPpr

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: PhysicsSpringDemo(),
        ),
      ),
      title: "Ok World",
    ),
  );
}
