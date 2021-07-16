import 'package:client/task6/task6.dart';

void main() {
  print(calculate('5', '10', 2));
}

int toDecimal(String number, String currentState, int nextState) {
  var result = int.parse(number, radix: nextState);
  return result;
}

int toBinary(String number, String currentState, int nextState) {
  var myInt = int.parse(number);
  assert(myInt is int);
  var result = myInt.toRadixString(2);
  var res = int.parse(result);
  assert(res is int);
  return res;
}

int calculate(String number, String currentState, int nextState) {
  switch (nextState) {
    case 2:
      return toBinary(number, currentState, nextState);
    default:
      return 0;
  }
}
