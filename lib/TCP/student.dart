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
  startTCPClient();
  print('Завершение main');
}

void startTCPClient() async {
  var student = Student(name: 'Alex', age: 19);

  var encoder = JsonEncoder.withIndent(' ');

  // соединяемся с сервером
  var socket = await Socket.connect('127.0.0.1', 8084);

  socket.write(encoder.convert(student));
  socket.cast<List<int>>().transform(utf8.decoder).listen((event) {
    print(event);
    exit(0);
  });
}
