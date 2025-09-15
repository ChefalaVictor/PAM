import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator TVA',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TvaCalculatorPage(),
    );
  }
}

class TvaCalculatorPage extends StatefulWidget {
  const TvaCalculatorPage({super.key});

  @override
  State<TvaCalculatorPage> createState() => _TvaCalculatorPageState();
}

class _TvaCalculatorPageState extends State<TvaCalculatorPage> {
  final TextEditingController _pretController = TextEditingController();
  double _tva = 0.05; // TVA implicit 5%
  double? _rezultat;

  final List<double> _tvaOptions = [0.05, 0.08, 0.20];

  void _calculeazaTVA() {
    final pretFaraTVA = double.tryParse(_pretController.text);
    if (pretFaraTVA != null) {
      setState(() {
        _rezultat = pretFaraTVA * (1 + _tva);
      });
    } else {
      setState(() {
        _rezultat = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculator TVA")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _pretController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Preț fără TVA",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            DropdownButton<double>(
              value: _tva,
              isExpanded: true,
              items: _tvaOptions.map((valoare) {
                return DropdownMenuItem(
                  value: valoare,
                  child: Text("${(valoare * 100).toInt()}%"),
                );
              }).toList(),
              onChanged: (valoareNoua) {
                setState(() {
                  _tva = valoareNoua!;
                });
              },
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: _calculeazaTVA,
              child: const Text("Calculează"),
            ),
            const SizedBox(height: 16),

            if (_rezultat != null)
              Text( "Preț final: ${_rezultat!.toStringAsFixed(2)} lei",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
