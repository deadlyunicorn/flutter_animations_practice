import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class PhysicsSpringDemo extends StatelessWidget {
  const PhysicsSpringDemo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 480,
        width: 480,
        child: DraggableCard(
          child: FlutterLogo(
            size: 128,
          ),
        ),
      ),
    );
  }
}

class DraggableCard extends StatefulWidget {
  const DraggableCard({required this.child, super.key});

  final Widget child;

  @override
  State<DraggableCard> createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 1,
    ),
  )..addListener(
      () {
        setState(() {
          _dragAlignment = animation.value;
        });
      },
    );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Alignment _dragAlignment = Alignment.center;

  late Animation<Alignment> animation;
  late final Size size = MediaQuery.sizeOf(context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (DragDownDetails details) {
        controller.stop();
      },
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          _dragAlignment += Alignment(
            details.delta.dx / (size.width / 2),
            details.delta.dy / (size.height / 2),
          );
        });
      },
      onPanEnd: _runAnimation,
      child: Align(
        alignment: _dragAlignment,
        child: Card(
          child: widget.child,
        ),
      ),
    );
  }

  void _runAnimation(DragEndDetails dragEndDetails) {
    animation = controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );
    final Offset pixelsPerSecond = dragEndDetails.velocity.pixelsPerSecond;
    final double unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final double unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final Offset unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final double unitVelocity = unitsPerSecond.distance;

    const SpringDescription spring = SpringDescription(
      mass: 5,
      stiffness: 1,
      damping: 1,
    );

    final SpringSimulation simulation = SpringSimulation(
      spring,
      0,
      1,
      -unitVelocity,
    );

    controller.reset();
    controller.animateWith(simulation);
    // controller.forward();
  }
}
