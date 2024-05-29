import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';

class PhysicsCardDemo extends StatelessWidget {
  const PhysicsCardDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Draggable(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.blue.shade300,
            ),
            borderRadius: BorderRadius.circular(8),
            color: Colors.blue.shade300.withOpacity(0.1),
          ),
          child: SizedBox(
            height: 128,
            width: 128,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.memory(
                base64Decode(
                  "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JkQRsElZGK16oqFhdSECgbvFdOPEHyM3zKD+4p/0ialjaIZbHiDcEaEHqDNryQWw9LW/sLr10ioToiJAREQEREBERAREQEREBERAREQEREDxVqBVLHQAXPlNNervuz8N4k28TeXu1tdkwdV1UtuhSQPy767x8hc+U1yg+kmD3WOkv9k1th79Xcn1t9pzvaPapcNXWkylg6MRui7FwQFW3fedG2UpVFwlPtV3KjAsyfl3iWC+IBAiifjz+6qf0N/lM03DnSbriqW8jL+ZSPUWnKhtTRXcW/ttWFFkOjU2vZt4crH1vpEGxVTpNsydgaFKx4Io8wLH5ianUfSXOyFYtTqA8FqWXzRSfmYov4iJAREQEREBERAREQEREBERAREQERED4RNQzrYJKpvRxWIw3Vabgp5KwO74A27puEQNR2a/DzCYSp23t163HtazbzA9QOAPfNuiICaftZ+HeFxr9td6FfQ9tSsCxXgWU6MR14983CIHNqX4fY/eAbNiad9bUFFQjpvX4983/LcClCktNL2XmTck82J5kmSogIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgf/Z",
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Draggable extends StatefulWidget {
  const Draggable({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<Draggable> createState() => _DraggableState();
}

class _DraggableState extends State<Draggable>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 600,
    ),
  )..addListener(
      () {
        if (controller.isCompleted) {
          offset = Offset.zero;
        } else {
          offset = resetPositionTween.evaluate(controller);
        }
        setState(() {});
      },
    );

  Offset initialOffset = const Offset(0, 0);
  Offset offset = const Offset(0, 0);
  late Tween<Offset> resetPositionTween = Tween<Offset>(
    begin: Offset.zero,
    end: Offset.zero,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: controller.isAnimating
          ? resetPositionTween.evaluate(
              CurvedAnimation(
                parent: controller,
                curve: Curves.elasticOut,
              ),
            )
          : offset,
      child: GestureDetector(
        onPanDown: (DragDownDetails details) {
          controller.stop();
          setState(() {
            initialOffset = details.globalPosition;
          });
        },
        onPanUpdate: (DragUpdateDetails details) {
          offset += Offset(
            details.delta.dx / pow((offset.dx.abs() * 0.01 + 1), 2),
            details.delta.dy / pow((offset.dy.abs() * 0.01 + 1), 2),
          );
          setState(() {});
        },
        onPanEnd: (DragEndDetails details) {
          _runAnimation();
        },
        child: widget.child,
      ),
    );
  }

  void _runAnimation() {
    resetPositionTween = Tween<Offset>(
      begin: offset,
      end: Offset.zero,
    );
    controller.reset();
    controller.forward();
  }
}
