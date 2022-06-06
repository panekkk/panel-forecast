import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panel_forecast/models/basic_parameters_model.dart';
import 'package:panel_forecast/widgets/navigation_drawer.dart';
import 'package:panel_forecast/providers/basic_parameters_provider.dart';
import 'package:provider/provider.dart';

class ParametersScreen extends StatefulWidget {
  const ParametersScreen({Key? key}) : super(key: key);

  @override
  State<ParametersScreen> createState() => _ParametersScreenState();
}

class _ParametersScreenState extends State<ParametersScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var _basicParameters =
        context.read<BasicParametersProvider>().basicParameters;
    return Scaffold(
      appBar: AppBar(title: const Text('Parametry')),
      drawer: const NavigationDrawer(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              buildInverterEfficiencyField(_basicParameters),
              const SizedBox(
                height: 10,
              ),
              buildSurfacePVField(_basicParameters),
              const SizedBox(
                height: 10,
              ),
              buildSlopePVField(_basicParameters),
              const SizedBox(
                height: 10,
              ),
              buildLatitudeField(_basicParameters),
              const SizedBox(
                height: 10,
              ),
              buildAlbedoField(_basicParameters),
              const SizedBox(
                height: 10,
              ),
              buildDropdownModelDiffusionList(_basicParameters),
              const SizedBox(
                height: 10,
              ),
              buildSubmit(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInverterEfficiencyField(BasicParameters basicParameters) =>
      TextFormField(
        initialValue: basicParameters.inverterEfficeincy.toString(),
        decoration: const InputDecoration(
          labelText: 'Sprawność falownika',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (double.tryParse(value.toString()) == null) {
            return 'Wprowadź poprawną wartość';
          }
          if (double.tryParse(value.toString())! > 1.0) {
            return 'Wprowadź poprawną wartość';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => basicParameters.inverterEfficeincy =
            double.parse(value.toString())),
      );
  Widget buildSurfacePVField(BasicParameters basicParameters) => TextFormField(
        initialValue: basicParameters.surface.toString(),
        decoration: const InputDecoration(
          labelText: 'Powierzchnia paneli [m^2]',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (double.tryParse(value.toString()) == null) {
            return 'Wprowadź poprawną wartość';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(
            () => basicParameters.surface = double.parse(value.toString())),
      );
  Widget buildSlopePVField(BasicParameters basicParameters) => TextFormField(
        initialValue: basicParameters.slope.toString(),
        decoration: const InputDecoration(
          labelText: 'Nachylenie paneli [rad]',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (double.tryParse(value.toString()) == null) {
            return 'Wprowadź poprawną wartość';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(
            () => basicParameters.slope = double.parse(value.toString())),
      );
  Widget buildLatitudeField(BasicParameters basicParameters) => TextFormField(
        initialValue: basicParameters.latitude.toString(),
        decoration: const InputDecoration(
          labelText: 'Szerokość geograficzna N [rad]',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (double.tryParse(value.toString()) == null) {
            return 'Wprowadź poprawną wartość';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(
            () => basicParameters.latitude = double.parse(value.toString())),
      );
  Widget buildAlbedoField(BasicParameters basicParameters) => TextFormField(
        initialValue: basicParameters.albedo.toString(),
        decoration: const InputDecoration(
          labelText: 'Albedo',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (double.tryParse(value.toString()) == null) {
            return 'Wprowadź poprawną wartość';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(
            () => basicParameters.albedo = double.parse(value.toString())),
      );
  Widget buildDropdownModelDiffusionList(BasicParameters basicParameters) =>
      DropdownButton<String>(
        value: basicParameters.model,
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
            basicParameters.model = newValue!;
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
                    content: const Text('Zapisano model'),
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
