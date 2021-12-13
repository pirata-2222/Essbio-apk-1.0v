import 'dart:ffi';

import 'package:flutter/material.dart';

class TimerEssbio extends StatefulWidget {
  @override
  _TimerEssbioState createState() => _TimerEssbioState();
}

class _TimerEssbioState extends State<TimerEssbio> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xFF303DC5)),
            margin: EdgeInsets.only(bottom: 20),
            height: 90,
            width: 160,
            child: Column(
              children: [
                SizedBox(height: 10),
                Icon(Icons.calendar_today_rounded, color: Colors.white),
                SizedBox(height: 10),
                Text("Fecha de Término", style: TextStyle(color: Colors.white)),
                Text("XX-XX-20XX", style: TextStyle(color: Colors.white)),
              ],
            )),
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xFF303DC5)),
            margin: EdgeInsets.only(
              bottom: 20,
            ),
            height: 90,
            width: 160,
            child: Column(
              children: [
                SizedBox(height: 10),
                Icon(Icons.timer, color: Colors.white),
                SizedBox(height: 10),
                Text("Tiempo Restante:", style: TextStyle(color: Colors.white)),
                Text("XXXX D", style: TextStyle(color: Colors.white)),
              ],
            )),
      ],
    );
  }
}
