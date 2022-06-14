import 'package:flutter/material.dart';
import 'package:panel_forecast/models/basic_parameters_model.dart';

final BasicParametersModel _initialData = BasicParametersModel(
    0.9, 10.0, 0.5235987755982988, 0.8726646259971648, 0.2, 'TIAN');

class BasicParametersProvider with ChangeNotifier {
  final BasicParametersModel basicParameters = _initialData;
}
