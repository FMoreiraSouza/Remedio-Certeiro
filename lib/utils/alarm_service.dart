import 'package:flutter/services.dart';

class AlarmService {
  static const MethodChannel _channel = MethodChannel('alarm_channel');

  static Future<void> playAlarm() async {
    try {
      await _channel.invokeMethod('playAlarm');
    } catch (e) {
      print("Erro ao tocar alarme: $e");
    }
  }
}
