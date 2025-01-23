abstract class CounterStrategy {
  int change(int number);
  String get label;
  int modifier = 1;
}

class IncrementStrategy extends CounterStrategy {
  @override
  int change(int number) {
    return number + modifier;
  }

  @override
  String get label => 'Increment';
}

class DecrementStrategy extends CounterStrategy {
  @override
  int change(int number) {
    return number - modifier;
  }

  @override
  String get label => 'Decrement';
}

class MultiplyStrategy extends CounterStrategy {
  @override
  int change(int number) {
    return number * modifier;
  }

  @override
  String get label => 'Multiply';
}

class DivideStrategy extends CounterStrategy {
  @override
  int change(int number) {
    if (number == 0) return 0;
    return (number / modifier).round();
  }

  @override
  String get label => 'Divide';
}
