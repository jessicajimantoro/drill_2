import 'package:drill_2/src/dependency_injection.dart';
import 'package:drill_2/src/pages/home_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await DependencyInjection.configure();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
