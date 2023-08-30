import 'package:flutter/material.dart';
import 'dart:async';

class StopwatchTimer extends StatefulWidget {
  @override
  _StopwatchTimerState createState() => _StopwatchTimerState();
}

class _StopwatchTimerState extends State<StopwatchTimer> {
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  String _stopwatchText = '';

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _stopwatchText = _formatDuration(_stopwatch.elapsed);
      });
    });
  }

  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(_stopwatchText);
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer?.cancel();
    super.dispose();
  }
}
