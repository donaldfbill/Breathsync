import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rhytham/utils/assets.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  final Duration startFrom;

  const VideoPlayerView({
    Key? key,
    this.startFrom = const Duration(seconds: 0),
  }) : super(key: key);


  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    Stopwatch stopwatch = Stopwatch()..start();
    _controller = VideoPlayerController.asset(
      VideoAssets.video,
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
        allowBackgroundPlayback: true,
      ),
    );
    _controller.initialize().then((_) {
      stopwatch.stop();
      Duration seek = (widget.startFrom + stopwatch.elapsed) /*- const Duration(seconds: 1)*/;
      _controller.seekTo(seek - const Duration(seconds: 1));
      _controller.setLooping(true);
      _controller.setVolume(0);
      _controller.play();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => _controller.value.isInitialized
      ? BackdropFilter(
          blendMode: BlendMode.darken,
          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
        )
      : const SizedBox(
          height: 100.0,
          child: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
