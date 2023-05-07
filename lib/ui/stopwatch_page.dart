import 'package:flutter/material.dart';
import 'package:stopwatch_dart/ui/refresh_button.dart';
import 'package:stopwatch_dart/ui/stopwatch_widget.dart';

class StopwatchPage extends StatelessWidget {
  const StopwatchPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 200,
              width: 200,
              child: StopwatchWidget(),
            ),
            RefreshButton(100.0)
          ],
        ),
      ),
    );
  }
}