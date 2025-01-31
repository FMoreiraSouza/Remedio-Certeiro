import 'package:flutter/services.dart';

class AlarmService {
  static const MethodChannel _channel = MethodChannel('alarm_channel');

  static Future<void> playAlarm() async {
    try {
      await _channel.invokeMethod('playAlarm');
    } catch (e) {
      throw ("Erro ao tocar alarme: $e");
    }
  }

  static Future<void> stopAlarm() async {
    try {
      await _channel.invokeMethod('stopAlarm');
    } catch (e) {
      throw ("Erro ao parar alarme: $e");
    }
  }
}
