import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';

import 'package:image_picker_web/image_picker_web.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    var dio = Dio();
    final response = await dio.get('http://127.0.0.1:8000/imagePost/Imageapi/');
    // final response = await dio.get('https://google.com',
    //     options: Options(headers: {'Access-Control-Allow-Origin': '*'}));
    print(response.data);

    //Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
    var mediaData = await ImagePickerWeb.getImageInfo;
    print(mediaData.fileName);
    //print(mediaData.data);
    List<int>? bytes = mediaData.data as List<int>;
    //print(by.runtimeType);

    await dio.post('http://127.0.0.1:8000/imagePost/Imageapi/',
        //options: Options(headers: {'Content-Type': 'multipart/form-data'}),
        data: FormData.fromMap({
          "title": "aaa",
          "picture": MultipartFile.fromBytes(
            bytes,
            filename: mediaData.fileName,
          )
        }));
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
