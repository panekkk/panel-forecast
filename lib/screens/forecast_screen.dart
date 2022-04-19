import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panel_forecast/widgets/navigation_drawer.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({Key? key}) : super(key: key);

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  final formKey = GlobalKey<FormState>();
  double temperature = 0;
  double insolation = 0;
  String model = 'Two';
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Prognoza')),
        drawer: const NavigationDrawer(),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                buildTemperature(),
                const SizedBox(
                  height: 10,
                ),
                buildInsolation(),
                const SizedBox(
                  height: 10,
                ),
                buildDropdownModelList(),
                const SizedBox(
                  height: 10,
                ),
                buildSubmit(),
              ],
            ),
          ),
        ),
      );
  Widget buildTemperature() => TextFormField(
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
        onSaved: (value) =>
            setState(() => temperature = double.parse(value.toString())),
      );
  Widget buildInsolation() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Nasłonecznienie',
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
            setState(() => insolation = double.parse(value.toString())),
      );
  Widget buildDropdownModelList() => DropdownButton<String>(
        value: model,
        icon: const Icon(Icons.arrow_downward),
        isExpanded: true,
        elevation: 16,
        hint: const Text('Wybierz model'),
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.blue,
        ),
        onChanged: (String? newValue) {
          setState(() {
            model = newValue!;
          });
        },
        items: <String>['One', 'Two', 'Free', 'Four']
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
          formKey.currentState?.save();
        }
      },
      child: const Text('Oblicz'));
}
