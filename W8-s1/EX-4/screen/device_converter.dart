import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeviceConverter extends StatefulWidget {
  const DeviceConverter({super.key});

  @override
  State<DeviceConverter> createState() => _DeviceConverterState();
}

class _DeviceConverterState extends State<DeviceConverter> {
 
  final BoxDecoration textDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  );

  final TextEditingController _dollarController = TextEditingController();
  String _selectedDevice = 'EURO';
  double _convertedValue = 0.0;
  final Map<String, double> conversionRates = {
    'EURO': 0.9,
    'RIELS': 4100.0,
    'DONG': 23000.0,
  };

  // for covert from usd
  void _convert() {
    double? dollars = double.tryParse(_dollarController.text);
    if (dollars != null && conversionRates.containsKey(_selectedDevice)) {
      setState(() {
        _convertedValue = dollars * conversionRates[_selectedDevice]!;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.money,
            size: 60,
            color: Colors.white,
          ),
          const Center(
            child: Text(
              "Converter",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          const SizedBox(height: 50),
          const Text("Amount in dollars:"),
          const SizedBox(height: 10),

          TextField(
            controller: _dollarController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              prefixText: '\$ ',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              _convert();
            },
          ),

          const SizedBox(height: 30),
          DropdownButton<String>(
            value: _selectedDevice,
            items: conversionRates.keys.map((String device) {
              return DropdownMenuItem<String>(
                value: device,
                child: Text(device),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedDevice = newValue!;
                _convert();
              });
            },
          ),

          const SizedBox(height: 30),
          const Text("Amount in selected device:"),
          const SizedBox(height: 10),
          Container(
              padding: const EdgeInsets.all(10),
              decoration: textDecoration,
              child: Text("$_convertedValue")
          )
        ],
      )
      ),
    );
  }
}
