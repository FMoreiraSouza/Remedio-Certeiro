import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:remedio_certeiro/database/database_helper.dart';
import 'package:remedio_certeiro/providers.dart';
import 'package:remedio_certeiro/screens_routes.dart';
import 'package:remedio_certeiro/utils/app_theme.dart';
import 'package:remedio_certeiro/utils/shared_preferences_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesService.init();

  final sessionId = SharedPreferencesService.getString('sessionId');

  await DatabaseHelper.instance.database;

  await _initializeNotifications();

  runApp(
    MultiProvider(
      providers: getProviders(),
      child: MyApp(sessionId: sessionId),
    ),
  );
}

Future<void> _initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveBackgroundNotificationResponse: _onSelectNotification,
    onDidReceiveNotificationResponse: _onSelectNotification,
  );
}

Future<void> _onSelectNotification(NotificationResponse details) async {
  if (details.payload != null) {
    Navigator.of(navigatorKey.currentContext!).pushNamed(details.payload ?? "");
  }
}

class MyApp extends StatelessWidget {
  final String? sessionId;

  const MyApp({super.key, this.sessionId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: AppTheme.getTheme(),
      onGenerateTitle: (context) {
        return 'Remédio Certeiro';
      },
      initialRoute: sessionId != null ? ScreensRoutes.home : ScreensRoutes.login,
      routes: getRoutes(),
    );
  }
}
