import 'dart:convert';
import 'dart:io';

class Calculator {
  late int num1;
  late int num2;
  late String action;

  Calculator({required this.num1, required this.num2, required this.action});

  Calculator.fromJson(Map<String, dynamic> json) : num1 = json['num1'] {
    num2 = json['num2'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'num1': num1, 'num2': num2, 'action': action};
  }
}

void main() {
  print('Запуск main');
  startTCPClient();
  print('Завершение main');
}

void startTCPClient() async {
  var data = Calculator(num1: 25, num2: 10, action: '-');

  var encoder = JsonEncoder.withIndent(' ');

  // соединяемся с сервером
  var socket = await Socket.connect('127.0.0.1', 8084);
  print('${data.num1} ${data.action} ${data.num2}');
  socket.write(encoder.convert(data));
  socket.cast<List<int>>().transform(utf8.decoder).listen((event) {
    print(event);
    exit(0);
  });
}
