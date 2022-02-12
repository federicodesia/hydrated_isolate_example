import 'package:flutter/material.dart';
import 'package:hydrated_isolate_example/counter/isolate/background_worker.dart';

import 'counter_view.dart';

class LifecycleWatcher extends StatefulWidget {
  const LifecycleWatcher({Key? key}) : super(key: key);

  @override
  _LifecycleWatcherState createState() => _LifecycleWatcherState();
}

class _LifecycleWatcherState extends State<LifecycleWatcher> with WidgetsBindingObserver {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.paused) BackgroundWorker.init();
  }

  @override
  Widget build(BuildContext context) => const CounterView();
}