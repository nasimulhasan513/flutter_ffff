
import 'package:flutter/material.dart';

class Summery extends StatefulWidget {
  @override
  _SummeryState createState() => _SummeryState();
}

class _SummeryState extends State<Summery> {
  Widget summaryComponent(String criteria, String count) => Container(
        height: 130,
        width: 130,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 1)],
            borderRadius: BorderRadius.circular(4)),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(count,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
            Text(criteria, style: TextStyle(fontSize: 17))
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Summery"),
          backgroundColor: Colors.teal,
          centerTitle: true),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              summaryComponent("Send", "20"),
              SizedBox(width: 20),
              summaryComponent("Failed", "20"),
            ],
          ),
        ),
      ),
    );
  }
}
