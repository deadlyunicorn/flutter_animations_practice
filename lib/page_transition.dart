import 'package:animations_practise/main.dart';
import 'package:flutter/material.dart';

class PageTransition extends StatelessWidget {
  const PageTransition({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder<void>(
              transitionsBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child,
              ) {
                final Tween<Offset> tween = Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                );

                return SlideTransition(
                  position: tween
                      .chain(
                        CurveTween(
                          curve: Curves.ease,
                        ),
                      )
                      .animate(animation),
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
                  color: Colors.green,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).popUntil(
                          (Route<void> route) => route.isFirst,
                        );
                      },
                      child: const Text("Back"),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        child: const Text("Press me!"),
      ),
    );
  }
}
