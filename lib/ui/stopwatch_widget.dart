
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprintf/sprintf.dart';
import 'package:stopwatch_dart/stopwatch_bloc.dart';

import '../constants.dart';

class StopwatchWidget extends StatefulWidget {
  const StopwatchWidget({super.key});

  @override
  State<StatefulWidget> createState() => _StopwatchWidgetState();
}


class _StopwatchWidgetState extends State<StopwatchWidget> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    StopwatchBloc bloc = BlocProvider.of<StopwatchBloc>(context);
    switch(state) {
      case AppLifecycleState.paused:
        bloc.add(StopwatchSaveState());
        break;
      case AppLifecycleState.resumed:
        bloc.add(StopwatchRestoreState());
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadius br = BorderRadius.circular(180);
    final Color runningColor = Theme.of(context).colorScheme.surface;
    final Color pausedColor = Theme.of(context).colorScheme.surfaceVariant;

    return BlocBuilder<StopwatchBloc, StopwatchState>(builder: (context, state) {

      String time = sprintf(timeTemplate, [
        (state.milliseconds ~/ 3600000) % 60,
        (state.milliseconds ~/ 60000) % 60,
        (state.milliseconds ~/ 1000) % 60,
        (state.milliseconds ~/ 10) % 100
      ]);

      return Material(
        shape: RoundedRectangleBorder(
          borderRadius: br,
        ),
        color: state.isRunning ? runningColor : pausedColor,
        elevation: 10,
        child: InkWell(
            borderRadius: br,
            onTap: () => context.read<StopwatchBloc>().add(StopwatchStart()),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                  time,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 35)
              ),
            )),
      );

    });
  }
}


