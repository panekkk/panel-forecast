import 'package:flutter/material.dart';
import 'package:panel_forecast/widgets/navigation_drawer.dart';


class ModelsScreen extends StatefulWidget {
  const ModelsScreen({ Key? key }) : super(key: key);

  @override
  State<ModelsScreen> createState() => _ModelsScreenState();
}

class _ModelsScreenState extends State<ModelsScreen> {
  @override
  Widget build(BuildContext context)=>Scaffold(
    appBar: AppBar(
      title: const Text('Modele')
    ),
    drawer: const NavigationDrawer(),
    );
}