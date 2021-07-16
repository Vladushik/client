import 'dart:convert';
import 'dart:io';

class Converter {
  late String number;
  late String currentState;
  late int nextState;

  Converter(
      {required this.number,
      required this.currentState,
      required this.nextState});

  Converter.fromJson(Map<String, dynamic> json) : number = json['number'] {
    currentState = json['currentState'];
    nextState = json['nextState'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'number': number,
      'currentState': currentState,
      'nextState': nextState
    };
  }
}

void main() {
  print('Запуск main');
  startTCPClient();
  print('Завершение main');
}

void startTCPClient() async {
  var data = Converter(number: '101', currentState: '2', nextState: 2);

  var encoder = JsonEncoder.withIndent(' ');

  // соединяемся с сервером
  var socket = await Socket.connect('127.0.0.1', 8084);

  print('${data.number} ${data.currentState} ${data.nextState}');

  socket.write(encoder.convert(data));
  socket.cast<List<int>>().transform(utf8.decoder).listen((event) {
    print(event);
    exit(0);
  });
}
