
import 'package:shared_preferences/shared_preferences.dart';

class RecoveryStopwatch {

  int _milliseconds = 0;
  int _startTimeStamp = 0;
  bool _isRunning = false;

  void start() {
    if (!_isRunning) {
      _startTimeStamp = DateTime.now().millisecondsSinceEpoch - _milliseconds;
      _isRunning = true;
      _tick();
    } else {
      stop();
    }
  }

  void stop() {
    _isRunning = false;
  }

  void refresh() {
    _startTimeStamp = DateTime.now().millisecondsSinceEpoch;
    _milliseconds = 0;
  }

  void save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("start_time_stamp", _startTimeStamp);
    await prefs.setInt("milliseconds", _milliseconds);
  }

  void restore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _startTimeStamp = prefs.getInt("start_time_stamp") ?? 0;
    _milliseconds = prefs.getInt("milliseconds") ?? 0;
  }

  void _tick() {
    Future.delayed(const Duration(milliseconds: 10), () {
      if (isRunning) {
        _milliseconds = DateTime.now().millisecondsSinceEpoch - _startTimeStamp;
        _tick();
      }
    });
  }

  int get milliseconds {
    return _milliseconds;
  }

  bool get isRunning {
    return _isRunning;
  }
}