import 'package:essbio_apk/models/fase_retiro.dart';
import 'package:essbio_apk/theme_library.dart';
import 'package:essbio_apk/widgets/mapa.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets_essbio.dart';
import 'package:essbio_apk/widgets/timer_widget.dart';

const Color estadoActivo = Color(0xFF10988F);
const Color estadoPasivo = Color(0xFF99CBCD);

class OtPendienteRetiro extends StatefulWidget {
  final FaseRetiro faseRetiro;
  OtPendienteRetiro({Key? key, required this.faseRetiro}) : super(key: key);
  @override
  _OtPendienteRetiroState createState() => _OtPendienteRetiroState();
}

class _OtPendienteRetiroState extends State<OtPendienteRetiro> {
  Color colorOTretiro() {
    var dataTipoEvento = widget.faseRetiro.tipo_evento.toString();
    Color colorTipoEventoRetiro;
    switch (dataTipoEvento) {
      case "Alerta":
        colorTipoEventoRetiro = verdeTiempoCritico;
        break;
      case "Pre-Emergencia":
        colorTipoEventoRetiro = amarilloTiempoCritico;
        break;
      case "Emergencia":
        colorTipoEventoRetiro = naranjaTiempoCritico;
        break;
      case "Crisis":
        colorTipoEventoRetiro = rojoTiempoCritico;
        break;
      default:
        colorTipoEventoRetiro = Colors.grey;
    }
    return colorTipoEventoRetiro;
  }

  String estadoRetiroenString() {
    var dataEstadoRetiro = widget.faseRetiro.id_tipo_status.toString();

    switch (dataEstadoRetiro) {
      case "140":
        dataEstadoRetiro = "Finalizado";
        break;
      case "141":
        dataEstadoRetiro = "En Curso";
        break;
      case "142":
        dataEstadoRetiro = "Retirado";
        break;
      case "143":
        dataEstadoRetiro = "No Disponible";
        break;
      default:
    }

    return dataEstadoRetiro;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  OtRetiroScreen(faseRetiro: widget.faseRetiro))),
      child: Container(
          margin: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colorOTretiro(),
          ),
          width: 120,
          height: 170,
          child: Column(
            children: [
              SizedBox(height: 5),
              Icon(Icons.file_copy, color: Colors.white, size: 50),
              SizedBox(height: 5),
              Center(
                child: Text(
                  widget.faseRetiro.nombre_ot,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Estado: ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      estadoRetiroenString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class OtRetiroScreen extends StatefulWidget {
  final FaseRetiro faseRetiro;
  OtRetiroScreen({Key? key, required this.faseRetiro}) : super(key: key);

  @override
  _OtRetiroScreenState createState() => _OtRetiroScreenState();
}

class _OtRetiroScreenState extends State<OtRetiroScreen> {
  Map<int, String> estadoRetiro = {
    143: "No disponible",
    142: "Retirado",
    141: "En Curso",
    140: "Finalizado",
  };
  String estadoSeleccionado = "";

  String estadoRetiroenString() {
    var dataEstadoRetiro = widget.faseRetiro.id_tipo_status.toString();

    switch (dataEstadoRetiro) {
      case "140":
        dataEstadoRetiro = "Finalizado";
        break;
      case "141":
        dataEstadoRetiro = "En Curso";
        break;
      case "142":
        dataEstadoRetiro = "Retirado";
        break;
      case "143":
        dataEstadoRetiro = "No Disponible";
        break;
      default:
    }

    return dataEstadoRetiro;
  }

  @override
  Widget build(BuildContext context) {
    String placeholder = estadoRetiro[widget.faseRetiro.id_tipo_status]!;
    estadoSeleccionado == "" ? estadoSeleccionado : placeholder;

    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFE5E5E5),
        appBarTheme: AppBarTheme(
          color: Color(0xFF3C3C3C),
        ),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text("ESSBIO APP"),
          ),
          drawer: EssbioDrawer(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                //TITULO PRINCIPAL Y BACK BUTTON
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: 70,
                      color: Color(0xFF248BCB),
                      child: InkWell(
                          child: Icon(
                            Icons.chevron_left_outlined,
                            size: 40,
                            color: Colors.white,
                          ),
                          onTap: () => Navigator.pop(context)),
                    ),
                    Expanded(
                      child: Container(
                        height: 60,
                        color: Color(0xFF248BCB),
                        child: Center(
                            child: Text("ORDEN DE TRABAJO",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.5,
                                    fontWeight: FontWeight.bold))),
                      ),
                    )
                  ],
                ),
                //DATOS BÁSICOS OT
                Container(
                  color: Color(0xFF0513AA),
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Text(widget.faseRetiro.nombre_ot,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                      SizedBox(height: 5),
                      Text("Fase 4 - Retiro",
                          style: TextStyle(color: Colors.white)),
                      SizedBox(height: 5),
                      Text("Estado: " + estadoRetiroenString(),
                          style: TextStyle(color: Colors.white)),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                //TIEMPO RESTANTE SEGÚN ASIGNADO
                TimerEssbio(
                    fecha: widget.faseRetiro.fecha_termino
                        .toString()
                        .substring(0, 10)),

                //ESTADOS DE LA OT
                Column(
                  children: [
                    Text(
                      "CAMBIO DE ESTADO",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              estadoSeleccionado = estadoRetiro[141]!;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: estadoSeleccionado == estadoRetiro[141]
                                  ? estadoActivo
                                  : estadoPasivo,
                            ),
                            margin: EdgeInsets.only(left: 10, right: 5),
                            height: 35,
                            width: 180,
                            child: Center(
                              child: Text(
                                "En Curso",
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              estadoSeleccionado = estadoRetiro[143]!;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: estadoSeleccionado == estadoRetiro[143]
                                  ? estadoActivo
                                  : estadoPasivo,
                            ),
                            margin: EdgeInsets.only(left: 5, right: 10),
                            height: 35,
                            width: 180,
                            child: Center(
                              child: Text(
                                "No Disponible",
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              estadoSeleccionado = estadoRetiro[142]!;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: estadoSeleccionado == estadoRetiro[142]!
                                  ? estadoActivo
                                  : estadoPasivo,
                            ),
                            margin: EdgeInsets.only(left: 10, right: 5),
                            height: 35,
                            width: 180,
                            child: Center(
                              child: Text(
                                "Retirado",
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              estadoSeleccionado = estadoRetiro[140]!;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: estadoSeleccionado == estadoRetiro[140]!
                                  ? estadoActivo
                                  : estadoPasivo,
                            ),
                            margin: EdgeInsets.only(left: 5, right: 10),
                            height: 35,
                            width: 180,
                            child: Center(
                              child: Text(
                                "Pendiente",
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),

                //UBICACIÓN TK

                SizedBox(height: 25),
                //UBICACIÓN TK

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("UBICACIÓN TK",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800)),
                    Text("Ver Mapa",
                        style: TextStyle(color: Color(0xFFDD0009))),
                  ],
                ),
                SizedBox(height: 25),
                Mapa(
                  lat: widget.faseRetiro.lat,
                  lon: widget.faseRetiro.lon,
                ),
                SizedBox(height: 20),
                //RÓTULO TK
                RotuloTKField(),
                SizedBox(height: 20),
                ComentarioGeneral(),
                SizedBox(height: 20),

                //GUARDAR DATOS
              ],
            ),
          )),
    );
  }
}
