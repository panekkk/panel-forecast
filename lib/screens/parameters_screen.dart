import 'package:flutter/material.dart';
import 'package:panel_forecast/widgets/navigation_drawer.dart';

class ParametersScreen extends StatefulWidget {
  const ParametersScreen({Key? key}) : super(key: key);

  @override
  State<ParametersScreen> createState() => _ParametersScreenState();
}

class _ParametersScreenState extends State<ParametersScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Parametry')),
        drawer: const NavigationDrawer(),
      );
}
