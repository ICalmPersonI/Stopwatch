import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stopwatch_dart/stopwatch.dart';

class StopwatchState {
  int milliseconds;
  bool isRunning;

  StopwatchState(this.milliseconds, this.isRunning);
}

abstract class StopwatchEvent {}

class StopwatchStart extends StopwatchEvent {}

class StopwatchUpdate extends StopwatchEvent {}

class StopwatchRefresh extends StopwatchEvent {}

class StopwatchStop extends StopwatchEvent {}

class StopwatchSaveState extends StopwatchEvent {}

class StopwatchRestoreState extends StopwatchEvent {}

class StopwatchBloc extends Bloc<StopwatchEvent, StopwatchState> {

  final RecoveryStopwatch _stopwatch = RecoveryStopwatch();
  final StopwatchState _state = StopwatchState(0, false);

  StopwatchBloc() : super(StopwatchState(0, false)) {

    on<StopwatchStart>((event, emit) {
      if (!_stopwatch.isRunning) {
        _stopwatch.start();
        add(StopwatchUpdate());
      } else {
        add(StopwatchStop());
      }
    });

    on<StopwatchUpdate>((event, emit) {
      if (_stopwatch.isRunning) {
        _state
          ..milliseconds = _stopwatch.milliseconds
          ..isRunning = true;
        emit(StopwatchState(_state.milliseconds, _state.isRunning));
        Future.delayed(const Duration(milliseconds: 10),
            () async => add(StopwatchUpdate()));
      }
    });

    on<StopwatchRefresh>((event, emit) {
      _stopwatch.refresh();
      _state
        .milliseconds = _stopwatch.milliseconds;
      emit(StopwatchState(_state.milliseconds, _state.isRunning));
    });

    on<StopwatchStop>((event, emit) {
      _stopwatch.stop();
      _state
        .isRunning = false;
      emit(StopwatchState(_state.milliseconds, _state.isRunning));
    });

    on<StopwatchSaveState>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("is_running", _stopwatch.isRunning);
      if (_stopwatch.isRunning) _stopwatch.stop();
      _stopwatch.save();
    });

    on<StopwatchRestoreState>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _stopwatch.restore();
      _state
        ..milliseconds = _stopwatch.milliseconds
        ..isRunning = prefs.getBool("is_running") ?? false;
      emit(StopwatchState(_state.milliseconds, _state.isRunning));
      if (_state.isRunning) {
        _stopwatch.start();
        add(StopwatchUpdate());
      }
    });
  }
}
