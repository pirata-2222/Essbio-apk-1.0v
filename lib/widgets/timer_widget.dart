import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimerEssbio extends StatefulWidget {
  final String fecha;
  TimerEssbio({Key? key, required this.fecha}) : super(key: key);
  @override
  _TimerEssbioState createState() => _TimerEssbioState();
}

class _TimerEssbioState extends State<TimerEssbio> {
  @override
  Widget build(BuildContext context) {
    int daysBetween(DateTime from, DateTime to) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      return (to.difference(from).inHours / 24).round();
    }

    ;

    var fechaTermino = widget.fecha;
    var fechaTerminoFormatoDate = DateFormat("yyyy-MM-dd").parse(fechaTermino);
    var fechaActual = DateTime.now();
    var tiempoRestante = daysBetween(fechaTerminoFormatoDate, fechaActual);
    var tiempoRestanteString = tiempoRestante.toString();

    String timerString() {
      var fechaTermino = widget.fecha;
      var fechaTerminoFormatoDate =
          DateFormat("yyyy-MM-dd").parse(fechaTermino);
      var fechaActual = DateTime.now();
      var tiempoRestante = daysBetween(fechaTerminoFormatoDate, fechaActual);

      String tiempoFaltanteString = " ";
      if (tiempoRestante > 0) {
        tiempoFaltanteString = "Dias de Atraso:";
      }
      if (tiempoRestante <= 0) {
        tiempoFaltanteString = "Tiempo Restante";
      }
      return tiempoFaltanteString;
    }

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
                Text(widget.fecha, style: TextStyle(color: Colors.white)),
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
                Text(timerString(), style: TextStyle(color: Colors.white)),
                Text(tiempoRestanteString + " Días",
                    style: TextStyle(color: Colors.white)),
              ],
            )),
      ],
    );
  }
}
