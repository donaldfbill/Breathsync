import 'package:flutter/material.dart';

class AppLifecycle extends StatefulWidget {
  final Widget child;
  final void Function() onResume;
  final void Function() onPause;

  const AppLifecycle({
    super.key,
    required this.child,
    required this.onResume,
    required this.onPause,
  });

  @override
  State<AppLifecycle> createState() => _AppLifecycleState();
}

class _AppLifecycleState extends State<AppLifecycle> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) widget.onResume();
    if (state == AppLifecycleState.inactive) widget.onPause();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
