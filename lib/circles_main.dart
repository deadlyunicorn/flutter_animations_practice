import 'dart:math';
import 'dart:ui';

//TODO: https://codepen.io/mknadler/pen/VajOdo

import 'package:flutter/material.dart';

void main() => runApp(const CoolAnimation());

class CoolAnimation extends StatefulWidget {
  const CoolAnimation({super.key});

  @override
  State<CoolAnimation> createState() => _CoolAnimationState();
}

class _CoolAnimationState extends State<CoolAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..addListener(() {
          setState(() {});
        })
        ..repeat();

  late final Tween<double> rotationTween = Tween(begin: 0, end: 360 * pi / 180);

  final widgets = List.generate(
    3,
    (index) => index,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 8,
                sigmaY: 8,
              ),
              child: Transform.rotate(
                angle: rotationTween.evaluate(animationController),
                child: Stack(children: [
                  Transform.translate(
                    offset: const Offset(64, 0),
                    child: const RotatingCircleCross(
                      index: 0,
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(-64, 0),
                    child: const RotatingCircleCross(
                      index: 1,
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, 64),
                    child: const RotatingCircleCross(
                      index: 2,
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -64),
                    child: const RotatingCircleCross(
                      index: 3,
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RotatingCircleCross extends StatefulWidget {
  const RotatingCircleCross({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<RotatingCircleCross> createState() => _RotatingCircleCrossState();
}

class _RotatingCircleCrossState extends State<RotatingCircleCross>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController = AnimationController(
      vsync: this, duration: Duration(seconds: widget.index))
    ..addListener(() {
      if (animationController.isDismissed) {
        animationController.forward();
      } else if (animationController.isCompleted) {
        animationController.reverse();
      }
    });

  late final scaleTween = Tween<double>(begin: 1, end: 0.3);
  late final Tween<double> rotationTween = Tween(begin: 0, end: 360 * pi / 180);
  late final ColorTween colorTween =
      ColorTween(begin: Colors.black, end: Colors.purple);

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: widget.index + 1)).then((_) {
      animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: scaleTween.evaluate(animationController) * 2,
        sigmaY: scaleTween.evaluate(animationController) * 2,
      ),
      child: Transform.rotate(
          angle: rotationTween.evaluate(animationController),
          child: ScaleTransition(
              scale: scaleTween.animate(animationController),
              child: CircleCross(
                offset: scaleTween.evaluate(animationController) *
                    (widget.index + 1) *
                    10,
                color: colorTween.evaluate(animationController)!,
              ))),
    );
  }
}

class CircleCross extends StatelessWidget {
  const CircleCross({
    super.key,
    required this.color,
    required this.offset,
  });

  final Color color;
  final double offset;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.translate(
            offset: Offset(offset, 0),
            child: Circle(
              color: color,
            )),
        Transform.translate(
            offset: Offset(0, offset),
            child: Circle(
              color: color,
            )),
        Transform.translate(
            offset: Offset(0, -offset),
            child: Circle(
              color: color,
            )),
        Transform.translate(
            offset: Offset(-offset, 0),
            child: Circle(
              color: color,
            ))
      ],
    );
  }
}

class Circle extends StatelessWidget {
  const Circle({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color.withOpacity(0.4),
          borderRadius: BorderRadius.circular(256),
          border: Border.all(
            width: 8,
            color: Colors.white,
          )),
      height: 128,
      width: 128,
    );
  }
}
