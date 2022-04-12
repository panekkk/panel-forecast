import 'package:flutter/material.dart';
import 'package:panel_forecast/widgets/navigation_drawer.dart';
class ForecastScreen extends StatefulWidget {
  const ForecastScreen({ Key? key }) : super(key: key);

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  @override
  Widget build(BuildContext context)=>Scaffold(
    appBar: AppBar(
      title: const Text('Prognoza')
    ),
    drawer: const NavigationDrawer(),
    );
}