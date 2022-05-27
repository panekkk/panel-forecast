import 'package:flutter/material.dart';
import 'package:panel_forecast/screens/forecast_screen.dart';
import 'package:provider/provider.dart';
import 'package:panel_forecast/providers/models_list_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ListModelParametersProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prognoza',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ForecastScreen(),
    );
  }
}
