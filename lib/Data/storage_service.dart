import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/Domain/counter_strategy.dart';

abstract class StorageService {
  Future<void> saveCounter(int counter);
  Future<void> saveStrategy(CounterStrategy strategy);
  int loadCounter();
  CounterStrategy loadStrategy();
}

class SharedPreferencesStorageService implements StorageService {
  SharedPreferencesStorageService(this._preferences);

  final SharedPreferences _preferences;

  @override
  Future<void> saveCounter(int counter) async {
    await _preferences.setInt('counter', counter);
  }

  @override
  Future<void> saveStrategy(CounterStrategy strategy) async {
    await _preferences.setString('strategy', strategy.label);
    await _preferences.setInt('modifier', strategy.modifier);
  }

  @override
  int loadCounter() {
    return _preferences.getInt('counter') ?? 0;
  }

  @override
  CounterStrategy loadStrategy() {
    final strategy = _preferences.getString('strategy');
    final modifier = _preferences.getInt('modifier') ?? 1;
    final strategies = [
      IncrementStrategy(),
      DecrementStrategy(),
      MultiplyStrategy(),
      DivideStrategy(),
    ];

    final savedStrategy = strategies.firstWhere(
      (element) => element.label == strategy,
      orElse: () => IncrementStrategy(),
    );

    return savedStrategy..modifier = modifier;
  }
}
