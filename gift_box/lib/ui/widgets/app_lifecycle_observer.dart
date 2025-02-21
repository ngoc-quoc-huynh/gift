import 'package:flutter/material.dart';

class AppLifecycleObserver extends StatefulWidget {
  const AppLifecycleObserver({
    required this.child,
    this.onResume,
    super.key,
  });

  final VoidCallback? onResume;
  final Widget child;

  @override
  State<AppLifecycleObserver> createState() => _AppLifecycleObserverState();
}

class _AppLifecycleObserverState extends State<AppLifecycleObserver> {
  late AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onResume: widget.onResume,
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
