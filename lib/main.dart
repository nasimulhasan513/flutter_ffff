import 'package:flutter/material.dart';
import 'package:learning/screens/HomePage.dart';
import 'package:learning/screens/summery.dart';
import 'package:learning/services/user.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (_) => User(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'ASG Messeging Platform'),
      routes: {'summery': (_) => Summery()},
    );
  }
}
