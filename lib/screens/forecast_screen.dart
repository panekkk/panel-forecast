import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panel_forecast/models/basic_parameters_model.dart';
import 'package:panel_forecast/models/weather_parameters_model.dart';
import 'package:panel_forecast/providers/basic_parameters_provider.dart';
import 'package:panel_forecast/widgets/navigation_drawer.dart';
import 'package:panel_forecast/providers/weather_parameters_provider.dart';
import 'package:panel_forecast/providers/parameters_models_list_provider.dart';
import 'package:panel_forecast/services/panel_forecast_service.dart';
import 'package:panel_forecast/models/parameters_model.dart';
import 'package:provider/provider.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({Key? key}) : super(key: key);

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var _weatherParameters =
        context.read<WeatherParametersModelProvider>().weatherParameters;
    var _basicParameters =
        context.read<BasicParametersProvider>().basicParameters;
    var _listModelParameters =
        context.read<ListModelParametersProvider>().listModelParameters;
    return Scaffold(
      appBar: AppBar(title: const Text('Prognoza')),
      drawer: const NavigationDrawer(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              buildTemperature(_weatherParameters),
              const SizedBox(
                height: 10,
              ),
              buildIrradiation(_weatherParameters),
              const SizedBox(
                height: 10,
              ),
              buildDateField(_weatherParameters),
              const SizedBox(
                height: 10,
              ),
              buildDropdownModelList(_weatherParameters),
              const SizedBox(
                height: 10,
              ),
              buildSubmit(
                  _basicParameters, _listModelParameters, _weatherParameters),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTemperature(WeatherParametersModel weatherParameters) =>
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Temperatura [K]',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        initialValue: weatherParameters.temperature.toString(),
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
        onSaved: (value) => setState(() =>
            weatherParameters.temperature = double.parse(value.toString())),
      );
  Widget buildIrradiation(WeatherParametersModel weatherParameters) =>
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Nasłonecznienie [Ws/m^2]',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        initialValue: weatherParameters.irradiation.toString(),
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
        onSaved: (value) => setState(() =>
            weatherParameters.irradiation = double.parse(value.toString())),
      );
  Widget buildDropdownModelList(WeatherParametersModel weatherParameters) =>
      DropdownButton<String>(
        value: weatherParameters.model,
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
            weatherParameters.model = newValue!;
          });
        },
        items: <String>[
          'MODEL_FUZZY_NMF_EQU_2_24',
          'MODEL_P_MAX_2_EQU_1_21',
          'MODEL_P_MAX_4_EQU_1_21'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );

  Widget buildSubmit(
          BasicParametersModel basicParameters,
          List<ParametersModel> listParametersModel,
          WeatherParametersModel weatherParametersModel) =>
      ElevatedButton(
          onPressed: () {
            final isValid = formKey.currentState?.validate();
            if (isValid == true) {
              formKey.currentState?.save(); //if valid save state of inputs
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Prognoza'),
                        content: Text('Prognozowana energia wynosi: ' +
                            PanelForecastService.forecastPowerProduction(
                                    basicParameters,
                                    listParametersModel,
                                    weatherParametersModel)
                                .toString() +
                            ' Wh'),
                        actions: [
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      ));
            }
          },
          child: const Text('Oblicz'));
  Widget buildDateField(WeatherParametersModel weatherParameters) => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Data [yyyy-mm-dd]',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        initialValue: weatherParameters.dateTime,
        validator: (value) {
          try {
          DateTime.parse(value.toString());
          } catch (e) {
            return 'Wprowadź poprawną wartość';
          }
        },
        onSaved: (value) => setState(() =>
            weatherParameters.dateTime = value.toString()),
    );
}
