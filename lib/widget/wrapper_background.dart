import 'package:flutter/material.dart';

class WrapperBackGround extends StatelessWidget {
  const WrapperBackGround({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.scale(
          scale: 2,
          child: Container(
            color: Colors.white,
            child: Image.asset(
              'assets/icon/background_9.jpeg',
              alignment: Alignment.center,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.0),
          ),
        ),
        child,
      ],
    );
  }
}
