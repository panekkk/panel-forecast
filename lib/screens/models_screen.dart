import 'package:flutter/material.dart';
import 'package:panel_forecast/widgets/navigation_drawer.dart';
import 'package:panel_forecast/models/model_parameters/nmf_model_parameters.dart';
class ModelsScreen extends StatefulWidget {
  const ModelsScreen({Key? key}) : super(key: key);

  @override
  State<ModelsScreen> createState() => _ModelsScreenState();
}

class _ModelsScreenState extends State<ModelsScreen> {
  NMFModelParameters nmfModel = NMFModelParameters(1, 1, 1, 1, 1, 1, 1, 1, 1);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Modele')),
        drawer: const NavigationDrawer(),
      );
}
