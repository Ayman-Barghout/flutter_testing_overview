import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:testing/Domain/counter_strategy.dart';
import 'package:testing/Data/storage_service.dart';
import 'package:testing/Presentation/strategy_picker.dart';

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  CounterStrategy _strategy = IncrementStrategy();

  @override
  void initState() {
    super.initState();
    _counter = GetIt.I.get<StorageService>().loadCounter();
    _strategy = GetIt.I.get<StorageService>().loadStrategy();
  }

  void _changeCounter() {
    setState(() => _counter = _strategy.change(_counter));
    GetIt.I.get<StorageService>().saveCounter(_counter);
  }

  void _updateStrategy(CounterStrategy strategy) {
    setState(() => _strategy = strategy);
    GetIt.I.get<StorageService>().saveStrategy(strategy);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter your modifier, current: ${_strategy.modifier}'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final number = int.tryParse(value);
                  if (number == null) return;
                  final strategy = _strategy..modifier = number;
                  _updateStrategy(strategy);
                },
              ),
            ),
            const SizedBox(height: 8),
            Text('Pick strategy, current: ${_strategy.label}'),
            StrategyPicker(
              onSelected: (strategy) {
                final effectiveStrategy = (strategy..modifier = _strategy.modifier);

                _updateStrategy(effectiveStrategy);
              },
            ),
            const Text(
              'Your current number is:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeCounter,
        tooltip: 'ChangeNumber',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
