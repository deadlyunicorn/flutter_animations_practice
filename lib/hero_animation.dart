import 'package:animations_practise/main.dart';
import 'package:flutter/material.dart';

class HeroAnimation extends StatelessWidget {
  const HeroAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Hero(
            tag: "logo",
            child: FlutterLogo(),
          ),
          const SizedBox.square(
            dimension: 16,
          ),
          Hero(
            tag: "buttonElevated",
            child: ElevatedButton(
              style: const ButtonStyle(
                surfaceTintColor: WidgetStatePropertyAll<Color>(
                  Colors.green,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder<void>(
                    transitionsBuilder: (
                      BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child,
                    ) {
                      return SlideTransition(
                        position: animation.drive(
                          Tween<Offset>(
                            begin: const Offset(1, -1),
                            end: Offset.zero,
                          ).chain(CurveTween(curve: Curves.ease)),
                        ),
                        child: child,
                      );
                    },
                    pageBuilder: (
                      BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                    ) =>
                        MaterialPageWrapper(
                      child: Container(
                        color: Colors.yellow,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Hero(
                                tag: "logo",
                                child: Container(
                                  color: Colors.green,
                                  child: const FlutterLogo(
                                    size: 120,
                                  ),
                                ),
                              ),
                              Hero(
                                tag: "buttonElevated",
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).popUntil(
                                      (Route<void> route) => route.isFirst,
                                    );
                                  },
                                  child: const Text("hello world"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: const Text("Press me!"),
            ),
          ),
        ],
      ),
    );
  }
}
