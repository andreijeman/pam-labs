import 'package:flutter/material.dart';

void main() {
  runApp(const AverageSpeedApp());
}

class AverageSpeedApp extends StatelessWidget {
  const AverageSpeedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Average Speed Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String _result = "";

  void _calculateSpeed() {
    final double? distance = double.tryParse(_distanceController.text);
    final double? time = double.tryParse(_timeController.text);

    if (distance == null || time == null || time <= 0) {
      setState(() {
        _result = "Please enter valid values!";
      });
      return;
    }

    final double speed = distance / time;
    setState(() {
      _result = "Average speed: ${speed.toStringAsFixed(2)} km/h";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Average Speed Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _distanceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Distance (km)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _timeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Time (hours)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateSpeed,
              child: const Text("Calculate"),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
