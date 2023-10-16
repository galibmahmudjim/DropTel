import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF505030),
        children: [
          SpeedDialChild(
            child: Icon(Icons.group),
            label: "Group",
            backgroundColor: Color(0xFF939338),
          ),
          SpeedDialChild(
            child: Icon(Icons.person),
            label: "Individual",
            backgroundColor: Color(0xFF939338),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
