import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottiePlayer extends StatefulWidget {
  final Duration startFrom;

  const LottiePlayer({
    Key? key,
    this.startFrom = const Duration(seconds: 0),
  }) : super(key: key);

  @override
  State<LottiePlayer> createState() => _LottiePlayerState();
}

class _LottiePlayerState extends State<LottiePlayer> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/lottie.json',
      controller: _controller,
      repeat: true,
      onLoaded: (composition) {
        _controller
          ..duration = composition.duration
          ..forward();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
