import 'dart:math';
import 'package:flutter/material.dart';

class SquaresAnimation extends StatelessWidget {
  const SquaresAnimation({super.key});

  final int size = 8;
  final int countPerAnimation = 128;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Stack(
            children: <Widget>[
              ...List<AnimatedContainer>.generate(
                countPerAnimation * 4,
                (int currentCount) => AnimatedContainer(
                  maxOffset: min(
                    MediaQuery.sizeOf(context).width,
                    MediaQuery.sizeOf(context).height,
                  ),
                  size: size,
                  animationStartIndex: currentCount ~/ countPerAnimation,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedContainer extends StatefulWidget {
  const AnimatedContainer({
    super.key,
    required this.maxOffset,
    required this.animationStartIndex,
    required this.size,
  });

  final double maxOffset;
  final int size;
  final int animationStartIndex;
  final int animationDurationInSeconds = 2;

  @override
  State<AnimatedContainer> createState() => _AnimatedContainerState();
}

class _AnimatedContainerState extends State<AnimatedContainer>
    with SingleTickerProviderStateMixin {
  int animationToPlayIndex = 0;

  late double offsetX =
      (Random.secure().nextDouble() - 0.5) * 2 * widget.maxOffset;
  late double offsetY =
      (Random.secure().nextDouble() - 0.5) * 2 * widget.maxOffset;
  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: Duration(seconds: widget.animationDurationInSeconds),
  )..addListener(() {
      if (animationController.isCompleted) {
        animationToPlayIndex++;

        animationController.reset();

        Future.delayed(Durations.short4).then((_) {
          animationController.forward();
        });
        switch (animationToPlayIndex % 4) {
          case 0:
            offsetY =
                (Random.secure().nextDouble() - 0.5) * 2 * widget.maxOffset;
            offsetX =
                (Random.secure().nextDouble() - 0.5) * 2 * widget.maxOffset;
            animationToPlay = RelativeRectTween(
              begin: const RelativeRect.fromLTRB(0, 0, 0, 0),
              end: RelativeRect.fromLTRB(offsetX, 0, 0, 0),
            );
            break;
          case 1:
            animationToPlay = RelativeRectTween(
              begin: RelativeRect.fromLTRB(offsetX, 0, 0, 0),
              end: RelativeRect.fromLTRB(offsetX, offsetY, 0, 0),
            );
            break;
          case 2:
            animationToPlay = RelativeRectTween(
              begin: RelativeRect.fromLTRB(offsetX, offsetY, 0, 0),
              end: RelativeRect.fromLTRB(0, offsetY, 0, 0),
            );
            break;
          case 3:
            animationToPlay = RelativeRectTween(
              begin: RelativeRect.fromLTRB(0, offsetY, 0, 0),
              end: const RelativeRect.fromLTRB(0, 0, 0, 0),
            );
            break;
        }
      }

      setState(
        () {},
      );
    });

  late RelativeRectTween animationToPlay;

  @override
  void initState() {
    super.initState();
    animationToPlay = RelativeRectTween(
      begin: const RelativeRect.fromLTRB(0, 0, 0, 0),
      end: RelativeRect.fromLTRB(offsetX, 0, 0, 0),
    );

    Future.delayed(
      Duration(
        seconds: widget.animationStartIndex * widget.animationDurationInSeconds,
      ),
    ).then(
      (_) {
        animationController.forward();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PositionedTransition(
      rect: animationToPlay.animate(animationController),
      // left: 0,
      // right: 0,
      // top: 0,
      // bottom: 0,
      // rect: transition.animate(animationController),
      child: Center(
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          height: widget.size.toDouble(),
          width: widget.size.toDouble(),
        ),
      ),
    );
  }
}
