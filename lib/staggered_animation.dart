import 'package:flutter/material.dart';

class StaggeredAnimation extends StatelessWidget {
  const StaggeredAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Center(
              child: Container(
                height: 640,
                width: 640,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  border: Border.all(
                    color: Colors.grey.shade700,
                    width: 2,
                  ),
                ),
              ),
            ),
            const AnimatedObject(),
          ],
        ),
      ),
    );
  }
}

class AnimatedObject extends StatefulWidget {
  const AnimatedObject({
    super.key,
  });

  final int durationInSeconds = 2;

  @override
  State<AnimatedObject> createState() => _AnimatedObjectState();
}

class _AnimatedObjectState extends State<AnimatedObject>
    with SingleTickerProviderStateMixin {
  late final Map<String, Interval> intervals = <String, Interval>{
    "fadeInterval": const Interval(0, 0.32),
    "widthInterval": const Interval(0.48, 0.56),
    "heightPosYInterval": const Interval(0.64, 0.88),
    "radiusInterval": const Interval(0.88, 1.04),
    "colorInterval": const Interval(1.12, 1.54),
  }.map(
    (String key, Interval interval) => MapEntry<String, Interval>(
      key,
      Interval(
        interval.begin / widget.durationInSeconds,
        interval.end / widget.durationInSeconds,
      ),
    ),
  );

  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: Duration(
      seconds: widget.durationInSeconds,
    ),
  )
    ..addListener(
      () {
        setState(() {});
        if (animationController.isCompleted) {
          animationController.reverse();
        } else if (animationController.isDismissed) {
          animationController.forward();
        }
      },
    )
    ..forward();

  // ignore: non_constant_identifier_names
  late final Animation<Color?> tween5_colors = ColorTween(
    begin: Colors.blue.shade700.withOpacity(0.2),
    end: Colors.orange,
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: intervals["colorInterval"]!,
    ),
  );
  // ignore: non_constant_identifier_names
  late final Animation<double> tween1_fadeIn = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: intervals["fadeInterval"]!,
    ),
  );

  // ignore: non_constant_identifier_names
  late final Animation<double> tween2_width = Tween<double>(
    begin: 64,
    end: 304,
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: intervals["widthInterval"]!,
    ),
  );

  // ignore: non_constant_identifier_names
  late final Animation<double> tween3_height = Tween<double>(
    begin: 64,
    end: 304,
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: intervals["heightPosYInterval"]!,
    ),
  );

  // ignore: non_constant_identifier_names
  late final Animation<double> tween3_posY = Tween<double>(
    begin: 64,
    end: 304,
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: intervals["heightPosYInterval"]!,
    ),
  );

  // ignore: non_constant_identifier_names
  late final Animation<double> tween4_radius = Tween<double>(
    begin: 8,
    end: 256,
  ).animate(
    CurvedAnimation(
      parent: animationController,
      curve: intervals["radiusInterval"]!,
    ),
  );

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: tween3_posY.value,
      left: 0,
      right: 0,
      child: Center(
        child: Opacity(
          opacity: tween1_fadeIn.value,
          child: Container(
            width: tween2_width.value,
            height: tween3_height.value,
            decoration: BoxDecoration(
              color: tween5_colors.value,
              borderRadius: BorderRadius.circular(tween4_radius.value),
              border: Border.all(
                color: Colors.blue.shade800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
