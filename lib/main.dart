import 'package:flutter/material.dart';
import 'package:panel_forecast/screens/forecast_screen.dart';
import 'package:provider/provider.dart';
import 'package:panel_forecast/models/model_parameters/model_parameters.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ListModelParameters())
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
