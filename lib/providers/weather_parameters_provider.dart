import 'package:flutter/material.dart';
import 'package:panel_forecast/models/weather_parameters_model.dart';

final WeatherParametersModel _initialData =
    WeatherParametersModel(293.0, 500.0,"MODEL_P_MAX_2_EQU_1_21");

class WeatherParametersModelProvider with ChangeNotifier {
  final WeatherParametersModel weatherParameters = _initialData;
}
