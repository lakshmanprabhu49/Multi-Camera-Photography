import 'package:flutter/material.dart';

class PageTransitionSlideAnim extends PageRouteBuilder {
  final Widget child;
  final Duration transitionDuration;
  PageTransitionSlideAnim({
    required this.child,
    this.transitionDuration = const Duration(milliseconds: 200),
  }) : super(
            transitionDuration: transitionDuration,
            pageBuilder: (context, animation, secondaryAnimation) => child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween(
          begin: Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
}
