import 'package:flutter/material.dart';

class PixelWidget extends StatelessWidget {
  final Color? innerColor;
  final Color? outerColor;
  final child;

  const PixelWidget(
      {required this.innerColor, required this.outerColor, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: EdgeInsets.all(4),
            color: outerColor,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.all(4),
                color: innerColor,
                child: Center(
                  child: child,
                ),
              ),
            ),
          ),
        ));
  }
}
