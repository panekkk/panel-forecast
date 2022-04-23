import 'package:flutter/material.dart';
import 'package:panel_forecast/screens/forecast_screen.dart';
import 'package:panel_forecast/screens/parameters_screen.dart';
import 'package:panel_forecast/screens/models_screen.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildMenuHeader(context),
              buildMenuContext(context)
            ],
          ),
        ),
      );
  Widget buildMenuHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
      );
  Widget buildMenuContext(BuildContext context) => Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(children: [
        ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Prognoza energii'),
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => const ForecastScreen()))),
        ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Parametry'),
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => const ParametersScreen()))),
        ListTile(
            leading: const Icon(Icons.source),
            title: const Text('Modele'),
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const ModelsScreen()))),
      ]));
}
