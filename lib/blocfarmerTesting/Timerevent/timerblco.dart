import 'dart:async';
import 'package:bloc/bloc.dart';
part 'timerevent.dart';
part 'timerstate.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  late Timer _timer;
  int _duration = 30;

  TimerBloc() : super(Ready(30));

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is StartTimer) {
      _duration = event.duration;
      _startTimer();
      yield Running(event.duration);
    } else if (event is PauseTimer) {
      _timer.cancel();
      yield Paused(_duration);
    } else if (event is ResumeTimer) {
      yield Running(_duration);
    } else if (event is ResetTimer) {
      _timer.cancel();
      _duration = 30;
      yield Ready(30);
    }
  }

  void _startTimer() {
    try {
      _timer.cancel();
      _timer = Timer.periodic(Duration(seconds: 1), (_) => _tick());
    } catch (e) {
      print(" timer error ${e}");
      _timer = Timer.periodic(Duration(seconds: 1), (_) => _tick());
    }
    // cancel previous timer if exists
  }

  void _tick() {
    if (_duration > 0) {
      _duration--;
      add(ResumeTimer());
    } else {
      _timer.cancel();
      add(ResetTimer());
    }
  }

  @override
  Future<void> close() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
    return super.close();
  }
}
