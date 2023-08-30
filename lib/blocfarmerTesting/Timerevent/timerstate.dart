part of 'timerblco.dart';
abstract class TimerState {}

class Ready extends TimerState {
  final int duration;

  Ready(this.duration);
}

class Running extends TimerState {
  final int duration;

  Running(this.duration);
}

class Paused extends TimerState {
  final int duration;

  Paused(this.duration);
}
