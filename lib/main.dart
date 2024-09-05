import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Program Launcher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProgramGrid(),
    );
  }
}

class Program {
  final String name;
  final String imagePath;
  final String launch_id;
  final String terminate_id;

  Program(this.name, this.imagePath, this.launch_id, this.terminate_id);
}

class ProgramGrid extends StatelessWidget {
  final List<Program> programs = [
    Program('Google Chrome', 'assets/Chrome_logo.png', '570', 'chrome.exe'),
    Program('Geometry Dash', 'assets/Geometry_Dash_logo.png', '322170', 'GeometryDash.exe'),
    // Добавьте больше программ здесь
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Моя мега программа'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // или 3, в зависимости от ваших предпочтений
          childAspectRatio: 1,
        ),
        itemCount: programs.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _showOptionsDialog(context, programs[index]);
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    programs[index].imagePath,
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(height: 10),
                  Text(programs[index].name),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showOptionsDialog(BuildContext context, Program program) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Выберите действие'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Запуск'),
                onTap: () {
                  _sendPostRequest('http://192.168.1.125:8000/launch', program.launch_id);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Завершение'),
                onTap: () {
                  _sendPostRequest('http://192.168.1.125:8000/terminate', program.terminate_id);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _sendPostRequest(String url, String programId) async {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: '{"process_name": "$programId"}',
    );

    if (response.statusCode == 200) {
      print('Request successful');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
}
