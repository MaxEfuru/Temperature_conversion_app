import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConversionApp());
}

class TemperatureConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Conversion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TemperatureConversionHome(),
    );
  }
}

class TemperatureConversionHome extends StatefulWidget {
  @override
  _TemperatureConversionHomeState createState() => _TemperatureConversionHomeState();
}

class _TemperatureConversionHomeState extends State<TemperatureConversionHome> {
  String _selectedConversion = 'F to C';
  TextEditingController _tempController = TextEditingController();
  String _convertedTemp = '';
  List<String> _history = [];

  void _convertTemperature() {
    String input = _tempController.text;
    if (input.isNotEmpty) {
      double temp = double.parse(input);
      double converted;
      String conversion;

      if (_selectedConversion == 'F to C') {
        converted = (temp - 32) * 5 / 9;
        conversion = 'F to C: $temp => ${converted.toStringAsFixed(2)}';
      } else {
        converted = temp * 9 / 5 + 32;
        conversion = 'C to F: $temp => ${converted.toStringAsFixed(2)}';
      }

      setState(() {
        _convertedTemp = converted.toStringAsFixed(2);
        _history.add(conversion);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Conversion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Select Conversion Type:',
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio<String>(
                  value: 'F to C',
                  groupValue: _selectedConversion,
                  onChanged: (value) {
                    setState(() {
                      _selectedConversion = value!;
                    });
                  },
                ),
                Text('F to C'),
                Radio<String>(
                  value: 'C to F',
                  groupValue: _selectedConversion,
                  onChanged: (value) {
                    setState(() {
                      _selectedConversion = value!;
                    });
                  },
                ),
                Text('C to F'),
              ],
            ),
            TextField(
              controller: _tempController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Temperature',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              'Converted Temperature: $_convertedTemp',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'History:',
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
