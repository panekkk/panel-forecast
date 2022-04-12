import 'package:flutter/material.dart';
import 'package:panel_forecast/screens/forecast_screen.dart';

void main() {
  runApp(const MyApp());
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
      home:  const ForecastScreen(),
      
      
    );
  }
}

