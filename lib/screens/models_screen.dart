import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panel_forecast/widgets/navigation_drawer.dart';
import 'package:panel_forecast/models/model_parameters/model_parameters.dart';
import 'package:provider/provider.dart';

class ModelsScreen extends StatefulWidget {
  const ModelsScreen({Key? key}) : super(key: key);

  @override
  State<ModelsScreen> createState() => _ModelsScreenState();
}

class _ModelsScreenState extends State<ModelsScreen> {
  final formKey = GlobalKey<FormState>();
  static final regexParameter =
      RegExp(r'^[-]?[0-9]*[.]{0,1}[0-9]*([e][-+][0-9]*)?$');
  String _model = 'MODEL_FUZZY_NMF_EQU_2_24';

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
                for (MapEntry e in context
                    .read<ListModelParameters>()
                    .getModelParametersEntries(_model))
                  Column(
                    children: [
                      buildParameterForm(e),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                buildDropdownModelList()
              ],
            ),
          ),
        ),
      );

  Widget buildParameterForm(MapEntry entry) => TextFormField(
        initialValue: entry.value.toString(),
        decoration: InputDecoration(
          labelText: entry.key,
          border: const OutlineInputBorder(),
        ),
        keyboardType:
            const TextInputType.numberWithOptions(signed: true, decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(
              RegExp(r'^[-]?[0-9]*[.]{0,1}[0-9]*[e]{0,1}[-+]{0,1}[0-9]*$'))
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
        items: <String>[
          'MODEL_P_MAX_2_EQU_1_21',
          'MODEL_P_MAX_4_EQU_1_21',
          'MODEL_FUZZY_NMF_EQU_2_24'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
}
