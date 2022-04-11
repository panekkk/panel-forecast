import 'package:flutter/material.dart';
class ForecastScreen extends StatefulWidget {
  const ForecastScreen({ Key? key }) : super(key: key);

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text('Dobowa prognoza energii elektrycznej'),
        ),
        body: Column(children: [],),
      
    );
  }
}