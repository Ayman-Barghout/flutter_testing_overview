abstract class CounterStrategy {
  int change(int number);
}

class IncrementStrategy implements CounterStrategy {
  @override
  int change(int number){
    return number +1;
  }
}


class DecrementStrategy implements CounterStrategy {
  @override
  int change(int number){
    return number - 1;
  }
}

class MultiplyStrategy implements CounterStrategy {
  @override
  int change(int number){
    return number * number;
  }
}

class DivideStrategy implements CounterStrategy {
  @override
  int change(int number){
    if(number == 0) return 0;
    return number / number;
  }
}