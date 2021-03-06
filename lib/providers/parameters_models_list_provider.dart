import 'package:flutter/material.dart';
import 'package:panel_forecast/models/parameters_model.dart';

List<ParametersModel> _initialData = [
  ParametersModel({
    'n1': 0.000000001933,
    'n2': -0.00002867,
    'n3': 0.0206809486,
    'n4': 0.00000001029,
    'n5': -0.0001360213,
    'n6': -0.187036,
    'n7': -0.00000327,
    'n8': 0.122805,
    'n9': -18.545
  }, "MODEL_FUZZY_NMF_EQU_2_24"),
  ParametersModel({
    'a': -1.9855E-6,
    'b': -0.0007019475,
    'c': 0.1201476,
    'd': 0.30119871,
    'e': -17.061743
  }, "MODEL_P_MAX_2_EQU_1_21"),
  ParametersModel({
    'c1': 3.81775e-10,
    'c2': -5.1508e-6,
    'c3': -8.8529e-8,
    'c4': 0.71863,
    'c5': 0.1246,
    'c6': -14.8299,
  }, "MODEL_P_MAX_4_EQU_1_21"),
];

class ListModelParametersProvider with ChangeNotifier {
  final List<ParametersModel> _listModelParameters = _initialData;

  List<ParametersModel> get listModelParameters => _listModelParameters;

  getModelParametersEntries(String name) {
    return _listModelParameters
        .firstWhere((element) => element.name == name)
        .parameters
        .entries;
  }

  setParameterValue(MapEntry entry, String name, double newValue) {
    for (ParametersModel model in listModelParameters) {
      if (name == model.name) {
        model.parameters.update(entry.key, (value) => newValue);
      }
    }
  }
  
}
