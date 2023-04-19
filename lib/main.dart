import 'package:flutter/material.dart';

void main() => runApp(ConverterApp());

class ConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Convertidor de temperatura',
      home: ConverterHomePage(),
    );
  }
}

class ConverterHomePage extends StatefulWidget {
  @override
  _ConverterHomePageState createState() => _ConverterHomePageState();
}

class _ConverterHomePageState extends State<ConverterHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _inputController;
  String _result = '';
  static const List<Tab> _tabs = <Tab>[
    Tab(text: 'Celsius a Fahrenheit'),
    Tab(text: 'Fahrenheit a Celsius'),
    Tab(text: 'Kelvin a Celsius'),
    Tab(text: 'Celsius a Kelvin'),
    Tab(text: 'Fahrenheit a Kelvin'),
    Tab(text: 'Kelvin a Fahrenheit'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _inputController = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  void _onConvertButtonPressed() {
    setState(() {
      double input = double.tryParse(_inputController.text) ?? 0;
      double result;
      switch (_tabController.index) {
        case 0: // Celsius a Fahrenheit
          if (_tabController.previousIndex == 1) {
            result = (input * 9 / 5) + 32; // Conversión inversa
          } else {
            result = (input * 9 / 5) + 32;
          }
          break;
        case 1: // Fahrenheit a Celsius
          if (_tabController.previousIndex == 0) {
            result = (input - 32) * 5 / 9; // Conversión inversa
          } else {
            result = (input - 32) * 5 / 9;
          }
          break;
        case 2: // Kelvin a Celsius
          if (_tabController.previousIndex == 0) {
            result = input - 273.15; // Conversión inversa
          } else {
            result = input - 273.15;
          }
          break;
        case 3: // Celsius a Kelvin
          if (_tabController.previousIndex == 0) {
            result = input + 273.15; // Conversión inversa
          } else {
            result = input + 273.15;
          }
          break;
        case 4: // Fahrenheit a Kelvin
          if (_tabController.previousIndex == 0) {
            result = (input - 32) * (5 / 9) + 273.15; // Conversión inversa
          } else {
            result = (input - 32) * (5 / 9) + 273.15;
          }
          break;
        case 5: // Kelvin a Fahrenheit
          if (_tabController.previousIndex == 0) {
            result = (input - 273.15) * (9 / 5) + 32; // Conversión inversa
          } else {
            result = (input - 273.15) * (9 / 5) + 32;
          }
          break;
        default:
          result = 0;
          break;
      }
      _result = result.toStringAsFixed(2);
    });
    // Mostrar un SnackBar con el
final snackBar = SnackBar(
content: Text('El resultado de la conversión es $_result'),
);
ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('convertidor de temperatura '),
bottom: TabBar(
controller: _tabController,
tabs: _tabs,
),
),
body: TabBarView(
controller: _tabController,
children: <Widget>[
_buildConverterTab('Celsius'),
_buildConverterTab('Fahrenheit'),
_buildConverterTab('Kelvin'),
_buildConverterTab('celsius2'),
_buildConverterTab('Fahrenheit2'),
_buildConverterTab('kelvin2'),
],
),
);
}

Widget _buildConverterTab(String unit) {
return Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
children: <Widget>[
TextField(
controller: _inputController,
keyboardType: TextInputType.number,
decoration: InputDecoration(
labelText: 'Enter $unit',
),
),
SizedBox(height: 16.0),
OutlinedButton(
onPressed: _onConvertButtonPressed,
child: Text('Convertir'),
),
SizedBox(height: 16.0),
Text(
'Result: $_result',
style: TextStyle(fontSize: 24.0),
),
],
),
);
}
}




