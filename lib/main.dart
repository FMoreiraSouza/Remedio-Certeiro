import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remedio_certeiro/providers.dart';
import 'package:remedio_certeiro/screens_routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: getProviders(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow)),
      onGenerateTitle: (context) {
        return 'Remédio Certeiro';
      },
      initialRoute: ScreensRoutes.login,
      routes: getRoutes(),
    );
  }
}
