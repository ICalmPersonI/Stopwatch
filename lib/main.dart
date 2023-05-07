
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch_dart/stopwatch_bloc.dart';
import 'package:stopwatch_dart/ui/stopwatch_page.dart';
import 'package:stopwatch_dart/ui/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: BlocProvider(
        create: (_) => StopwatchBloc(),
        child: const StopwatchPage(title: 'Stopwatch'),
      ),
    );
  }
}
