part of 'timerblco.dart';
abstract class TimerEvent {}


class StartTimer extends TimerEvent {
  final int duration;

  StartTimer(this.duration);
}

class PauseTimer extends TimerEvent {}

class ResumeTimer extends TimerEvent {}

class ResetTimer extends TimerEvent {}