import 'package:flutter/material.dart';
import 'package:testing/Domain/counter_strategy.dart';

class StrategyPicker extends StatelessWidget {
  const StrategyPicker({required this.onSelected, super.key});

  final ValueChanged<CounterStrategy> onSelected;

  @override
  Widget build(BuildContext context) {
    final strategies = <CounterStrategy>[
      IncrementStrategy(),
      DecrementStrategy(),
      MultiplyStrategy(),
      DivideStrategy(),
    ];
    return Wrap(
      children: strategies
          .map(
            (strategy) => ElevatedButton(
              onPressed: () => onSelected(strategy),
              child: Text(strategy.label),
            ),
          )
          .toList(),
    );
  }
}
