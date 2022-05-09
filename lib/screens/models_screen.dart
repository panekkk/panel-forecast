import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panel_forecast/widgets/navigation_drawer.dart';
import 'package:panel_forecast/models/model_parameters/nmf_model_parameters.dart';

class ModelsScreen extends StatefulWidget {
  const ModelsScreen({Key? key}) : super(key: key);

  @override
  State<ModelsScreen> createState() => _ModelsScreenState();
}

class _ModelsScreenState extends State<ModelsScreen> {
  NMFModelParameters nmfModel = NMFModelParameters(1, 1, 1, 1, 1, 1, 1, 1, 1);
  final formKey = GlobalKey<FormState>();
  List modelList = ['MODEL1', 'MODEL2', 'MODEL2'];
  List lista = [1, 2, 34, 5];
  String _model = 'MODEL_P_MAX_EQU_1_21';
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Modele')),
        drawer: const NavigationDrawer(),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                for (var item in lista)
                  Column(
                    children: [buildTemperature(item), const SizedBox(height: 10,)],
                  ),
                  buildDropdownModelList()
              ],
            ),
          ),
        ),
      );

  Widget buildTemperature(int initValue) => TextFormField(
        initialValue: initValue.toString(),
        decoration: const InputDecoration(
          labelText: 'Temperatura',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*'))
        ],
        validator: (value) {
          if (double.tryParse(value.toString()) == null) {
            return 'Wprowadź poprawną wartość';
          } else {
            return null;
          }
        },
      );
  Widget buildDropdownModelList() => DropdownButton<String>(
        value: _model,
        icon: const Icon(Icons.arrow_downward),
        isExpanded: true,
        elevation: 16,
        hint: const Text('Wybierz model'),
        style: const TextStyle(color: Colors.black),
        underline: Container(
          height: 2,
          color: Colors.blue,
        ),
        onChanged: (String? newValue) {
          setState(() {
            _model = newValue!;
          });
        },
        items: <String>['MODEL_P_MAX_EQU_1_21','MODEL_P_MAX_EQU_1_24','MODEL_P_MAX_EQU_2_24']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
}
