import 'dart:convert';
import 'dart:io';

class Student {
  final String name;
  late int age;

  Student({required this.name, required this.age});
  Student.fromJson(Map<String, dynamic> json) : name = json['name'] {
    age = json['age'];
  }

  @override
  String toString() {
    var student = 'Студент {имя: $name, возраст: $age, ';
    return student;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'age': age,
    };
  }
}

void main() {
  print('Запуск main');
  startUDPClient();
  print('Завершение main');
}

void startUDPClient() async {
  var student = Student(name: 'Alex', age: 19);

  var encoder = JsonEncoder.withIndent(' ');
  var rawDgramSocket = await RawDatagramSocket.bind('127.0.0.1', 8084);
  rawDgramSocket.send(utf8.encode(encoder.convert(student)),
      InternetAddress('127.0.0.1'), 8083);

  await for (RawSocketEvent event in rawDgramSocket) {
    if (event == RawSocketEvent.read) {
      var datagram = rawDgramSocket.receive();
      print(utf8.decode(datagram!.data));
      rawDgramSocket.close();
      exit(0);
    }
  }
}
