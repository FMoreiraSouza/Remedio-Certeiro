import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:remedio_certeiro/core/constants/routes.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings settings = InitializationSettings(android: androidSettings);
    await _plugin.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: _onSelectNotification,
      onDidReceiveNotificationResponse: _onSelectNotification,
    );
  }

  static Future<void> showNotification(String medicineName) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'remedy_channel',
      'Remédios',
      channelDescription: 'Notificações para os medicamentos',
      importance: Importance.max,
      priority: Priority.max,
      ticker: 'ticker',
    );
    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);
    await _plugin.show(
      0,
      'Alerta de Dose',
      'Em 5 minutos tome seu $medicineName',
      platformDetails,
      payload: Routes.home,
    );
  }

  static Future<void> _onSelectNotification(NotificationResponse details) async {
    if (details.payload != null && Routes.navigatorKey.currentContext != null) {
      Navigator.of(Routes.navigatorKey.currentContext!).pushNamed(details.payload!);
    }
  }
}
