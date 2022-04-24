import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panel_forecast/widgets/navigation_drawer.dart';

class ParametersScreen extends StatefulWidget {
  const ParametersScreen({Key? key}) : super(key: key);

  @override
  State<ParametersScreen> createState() => _ParametersScreenState();
}

class _ParametersScreenState extends State<ParametersScreen> {
  final formKey = GlobalKey<FormState>();
  //TODO: Create proper data model
  double _inverterEfficeincy = 0;
  double _surface = 0;
  double _slope = 0;
  double _latitude = 0;
  double _albedo = 0;
  String _model = 'TIAN';
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Parametry')),
        drawer: const NavigationDrawer(),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                buildInverterEfficiencyField(),
                const SizedBox(
                  height: 10,
                ),
                buildSurfacePVField(),
                const SizedBox(
                  height: 10,
                ),
                buildSlopePVField(),
                const SizedBox(
                  height: 10,
                ),
                buildLatitudeField(),
                const SizedBox(
                  height: 10,
                ),
                buildAlbedoField(),
                const SizedBox(
                  height: 10,
                ),
                buildDropdownModelDiffusionList(),
                const SizedBox(
                  height: 10,
                ),
                buildSubmit(),
              ],
            ),
          ),
        ),
      );
      Widget buildInverterEfficiencyField() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Sprawność falownika',
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
        onSaved: (value) =>
            setState(() => _inverterEfficeincy = double.parse(value.toString())),
      );
      Widget buildSurfacePVField() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Powierzchnia paneli [m^2]',
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
        onSaved: (value) =>
            setState(() => _surface = double.parse(value.toString())),
      );
      Widget buildSlopePVField() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Nachylenie paneli [rad]',
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
        onSaved: (value) =>
            setState(() => _slope = double.parse(value.toString())),
      );
      Widget buildLatitudeField() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Szerokość geograficzna N [rad]',
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
        onSaved: (value) =>
            setState(() => _latitude = double.parse(value.toString())),
      );
      Widget buildAlbedoField() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Albedo',
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
        onSaved: (value) =>
            setState(() => _albedo = double.parse(value.toString())),
      );
      Widget buildDropdownModelDiffusionList() => DropdownButton<String>(
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
        items: <String>['TIAN', 'SRAN', 'KRAN', 'Four']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
      Widget buildSubmit() => ElevatedButton(
      onPressed: () {
        final isValid = formKey.currentState?.validate();
        if (isValid == true) {
          formKey.currentState?.save(); //if valid save state of inputs
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Sukces'),
                    content:
                        const Text('Zapisano model'),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ));
        }
      },
      child: const Text('Zapisz'));
}
