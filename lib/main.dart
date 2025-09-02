import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/core/constants/routes.dart';
import 'package:remedio_certeiro/core/utils/app_theme.dart';
import 'package:remedio_certeiro/core/utils/notifications.dart';
import 'package:remedio_certeiro/core/utils/shared_preferences_service.dart';
import 'package:remedio_certeiro/core/utils/database_helper.dart';
import 'package:remedio_certeiro/presentation/providers/app_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.init();
  await DatabaseHelper.instance.database;
  await NotificationService.initialize();
  final sessionId = SharedPreferencesService.getString('sessionId');

  runApp(
    MultiProvider(
      providers: getProviders(),
      child: MyApp(sessionId: sessionId),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? sessionId;

  const MyApp({super.key, this.sessionId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Routes.navigatorKey,
      theme: AppTheme.getTheme(),
      onGenerateTitle: (context) => 'Remédio Certeiro',
      initialRoute: sessionId != null ? Routes.home : Routes.login,
      routes: Routes.getRoutes(),
    );
  }
}
