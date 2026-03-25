import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    callEndPoint();
    print('aaaaaaaaaaaaa');
    super.initState();
  }

  void callEndPoint() async {
    var url = Uri.https('newsapi.org', 'v2/top-headlines', {
      "apiKey": "cd6f217edcb94be6b0e5dc49231d03ee",
      "country": "us",
    });
    print(url);
    final http.Response response = await http.get(url);

    print(response.statusCode);
    // var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
