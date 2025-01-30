import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // Importando o pacote de notificações
import 'package:remedio_certeiro/database/database_helper.dart';
import 'package:remedio_certeiro/providers.dart';
import 'package:remedio_certeiro/screens_routes.dart';
import 'package:remedio_certeiro/utils/app_theme.dart';
import 'package:remedio_certeiro/utils/shared_preferences_service.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

// Inicializando o plugin de notificações
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialize as preferências e o banco de dados
  await SharedPreferencesService.init();

  final sessionId = SharedPreferencesService.getString('sessionId');

  await DatabaseHelper.instance.database;

  // Inicialize as configurações de notificações
  await _initializeNotifications();

  runApp(
    MultiProvider(
      providers: getProviders(),
      child: MyApp(sessionId: sessionId),
    ),
  );
}

// Função para inicializar o Flutter Local Notifications
Future<void> _initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher'); // Ícone da notificação

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

class MyApp extends StatelessWidget {
  final String? sessionId;

  const MyApp({super.key, this.sessionId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey, // Usando o ScaffoldMessenger global
      theme: AppTheme.getTheme(),
      onGenerateTitle: (context) {
        return 'Remédio Certeiro';
      },
      initialRoute: sessionId != null ? ScreensRoutes.home : ScreensRoutes.login,
      routes: getRoutes(),
    );
  }
}
