import 'dart:math';
import 'package:flutter/material.dart';

class FloraFlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;

  const FloraFlipCard({
    super.key,
    required this.front,
    required this.back,
  });

  @override
  State<FloraFlipCard> createState() => _FloraFlipCardState();
}

class _FloraFlipCardState extends State<FloraFlipCard> {
  bool isFlipped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFlipped = !isFlipped;
        });
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation) {
          final rotate = Tween(begin: pi, end: 0.0).animate(animation);
          return AnimatedBuilder(
            animation: rotate,
            child: child,
            builder: (context, child) {
              final angle =
              isFlipped ? min(rotate.value, pi / 2) : rotate.value;
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(angle),
                child: child,
              );
            },
          );
        },
        child: isFlipped
            ? Container(key: const ValueKey('back'), child: widget.back)
            : Container(key: const ValueKey('front'), child: widget.front),
      ),
    );
  }
}