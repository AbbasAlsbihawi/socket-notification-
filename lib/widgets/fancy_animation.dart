import 'package:flutter/material.dart';

// For custom animations, just use the existing Flutter [Page] and [Route] objects
class FancyAnimationPage extends Page {
  final Widget child;
  const FancyAnimationPage({required this.child});
  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, animation2) {
        final tween = Tween(begin: 0.0, end: 1.0);
        final curveTween = CurveTween(curve: Curves.easeInOut);
        return FadeTransition(
          opacity: animation.drive(curveTween).drive(tween),
          child: child,
        );
      },
    );
  }
}
