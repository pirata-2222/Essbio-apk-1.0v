import 'package:essbio_apk/api/api.dart';
import 'package:essbio_apk/models/fase_abastecimiento.dart';
import 'package:essbio_apk/theme_library.dart';
import 'package:essbio_apk/widgets/mapa.dart';
import 'package:essbio_apk/widgets/timer_widget.dart';
import 'package:essbio_apk/widgets/widgets_essbio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

const Color estadoActivo = Color(0xFF10988F);
const Color estadoPasivo = Color(0xFF99CBCD);

enum EstadoAbast {
  EnCurso,
  NoDisponible,
  EstanqueLlenado,
  CierreAbastecimiento,
  Pendiente,
  Empty
}

class OtPendienteAbast extends StatefulWidget {
  final FaseAbastecimiento faseAbastecimiento;
  OtPendienteAbast({Key? key, required this.faseAbastecimiento})
      : super(key: key);
  @override
  _OtPendienteAbastState createState() => _OtPendienteAbastState();
}

class _OtPendienteAbastState extends State<OtPendienteAbast> {
  Color colorBordeAbastecimiento() {
    var dataTipoEvento = widget.faseAbastecimiento.tipo_evento.toString();
    Color colorTipoEventoAbastecimiento;
    switch (dataTipoEvento) {
      case "Emergencia":
        colorTipoEventoAbastecimiento = Colors.purple;
        break;
      case "Crisis":
        colorTipoEventoAbastecimiento = Colors.deepOrange;
        break;
      default:
        colorTipoEventoAbastecimiento = Colors.grey;
    }
    return colorTipoEventoAbastecimiento;
  }

  Color colorOTabastecimiento() {
    int daysBetween(DateTime from, DateTime to) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      return (to.difference(from).inDays).round();
    }

    var fechaTermino = widget.faseAbastecimiento.fecha_termino;
    var fechaTerminoFormatoDate = DateFormat("yyyy-MM-dd").parse(fechaTermino);
    var fechaActual = DateTime.now();
    var tiempoRestanteAbastecimiento =
        daysBetween(fechaActual, fechaTerminoFormatoDate);

    Color colorTiempoRestanteAbastecimiento = Colors.grey;

    if (tiempoRestanteAbastecimiento <= 7) {
      colorTiempoRestanteAbastecimiento = rojoTiempoCritico;
    }
    if (tiempoRestanteAbastecimiento <= 14 &&
        tiempoRestanteAbastecimiento > 7) {
      colorTiempoRestanteAbastecimiento = naranjaTiempoCritico;
    }
    if (tiempoRestanteAbastecimiento > 14 &&
        tiempoRestanteAbastecimiento <= 21) {
      colorTiempoRestanteAbastecimiento = amarilloTiempoCritico;
    }
    if (tiempoRestanteAbastecimiento > 21) {
      colorTiempoRestanteAbastecimiento = verdeTiempoCritico;
    }
    return colorTiempoRestanteAbastecimiento;
  }

  String estadoAbastecimientoenString() {
    var dataEstadoAbastecimiento =
        widget.faseAbastecimiento.id_tipo_status.toString();

    switch (dataEstadoAbastecimiento) {
      case "120":
        dataEstadoAbastecimiento = "Finalizado";
        break;
      case "121":
        dataEstadoAbastecimiento = "En Curso";
        break;
      case "122":
        dataEstadoAbastecimiento = "No Disponible";
        break;
      case "126":
        dataEstadoAbastecimiento = "Estanque Llenado";
        break;
      case "127":
        dataEstadoAbastecimiento = "Cierre Abastecimiento";
        break;
      default:
    }
    return dataEstadoAbastecimiento;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtAbastScreen(
                  faseAbastecimiento: widget.faseAbastecimiento))),
      child: Container(
          margin: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            border: Border.all(color: colorBordeAbastecimiento(), width: 5.0),
            borderRadius: BorderRadius.circular(10),
            color: colorOTabastecimiento(),
          ),
          width: 120,
          height: 180,
          child: Column(
            children: [
              SizedBox(height: 5),
              Icon(Icons.file_copy, color: Colors.white, size: 37.5),
              SizedBox(height: 5),
              Center(
                child: Text(
                  widget.faseAbastecimiento.nombre_ot,
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
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      estadoAbastecimientoenString(),
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

class OtAbastScreen extends StatefulWidget {
  final FaseAbastecimiento faseAbastecimiento;
  OtAbastScreen({Key? key, required this.faseAbastecimiento}) : super(key: key);

  @override
  _OtAbastScreenState createState() => _OtAbastScreenState();
}

class _OtAbastScreenState extends State<OtAbastScreen> {
  Map<int, String> estadoAbastecimiento = {
    121: "En Curso",
    127: "Cierre Abastecimiento",
    122: "No Disponible",
    126: "Estanque Llenado",
  };
  String estadoSeleccionado = "";

  String estadoAbastecimientoenString() {
    var dataEstadoAbastecimiento =
        widget.faseAbastecimiento.id_tipo_status.toString();

    switch (dataEstadoAbastecimiento) {
      case "120":
        dataEstadoAbastecimiento = "Finalizado";
        break;
      case "121":
        dataEstadoAbastecimiento = "En Curso";
        break;
      case "122":
        dataEstadoAbastecimiento = "No Disponible";
        break;
      case "126":
        dataEstadoAbastecimiento = "Estanque Llenado";
        break;
      case "127":
        dataEstadoAbastecimiento = "Cierre Abastecimiento";
        break;
      default:
    }

    return dataEstadoAbastecimiento;
  }
  // FALTAN 123='INICIO CARGA CAMIÓN', 124='TÉRMINO CARGA CAMIÓN', 125='INICIO ABASTECIMIENTO',

  @override
  Widget build(BuildContext context) {
    final essbioP = Provider.of<EssbioProvider>(context);
    TextEditingController comentarioController = TextEditingController();
    int id_tipo_status = widget.faseAbastecimiento.id_tipo_status;
    double screenWidth = MediaQuery.of(context).size.width;
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
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(height: 5),
                        Text(widget.faseAbastecimiento.nombre_ot,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700)),
                        SizedBox(height: 5),
                        Text("Fase 2 - Abastecimiento",
                            style: TextStyle(color: Colors.white)),
                        SizedBox(height: 5),
                        Text("Estado: " + estadoAbastecimientoenString(),
                            style: TextStyle(color: Colors.white)),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //TIEMPO RESTANTE SEGÚN ASIGNADO
                TimerEssbio(
                    fecha: widget.faseAbastecimiento.fecha_termino
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
                              estadoSeleccionado = estadoAbastecimiento[121]!;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 4,
                                color:
                                    estadoAbastecimientoenString() == "En Curso"
                                        ? estadoActivo
                                        : estadoSeleccionado ==
                                                estadoAbastecimiento[121]
                                            ? estadoActivo
                                            : estadoPasivo,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              color:
                                  estadoAbastecimientoenString() == "En Curso"
                                      ? estadoActivo
                                      : estadoPasivo,
                            ),
                            margin: EdgeInsets.only(left: 10, right: 5),
                            height: 35,
                            width: screenWidth * 0.4,
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
                              estadoSeleccionado = estadoAbastecimiento[122]!;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 4,
                                color: estadoAbastecimientoenString() ==
                                        "No Disponible"
                                    ? estadoActivo
                                    : estadoSeleccionado ==
                                            estadoAbastecimiento[122]
                                        ? estadoActivo
                                        : estadoPasivo,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              color: estadoAbastecimientoenString() ==
                                      "No Disponible"
                                  ? estadoActivo
                                  : estadoPasivo,
                            ),
                            margin: EdgeInsets.only(left: 5, right: 10),
                            height: 35,
                            width: screenWidth * 0.4,
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
                              estadoSeleccionado = estadoAbastecimiento[126]!;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 4,
                                color: estadoAbastecimientoenString() ==
                                        "Estanque Llenado"
                                    ? estadoActivo
                                    : estadoSeleccionado ==
                                            estadoAbastecimiento[126]
                                        ? estadoActivo
                                        : estadoPasivo,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              color: estadoAbastecimientoenString() ==
                                      "Estanque Llenado"
                                  ? estadoActivo
                                  : estadoPasivo,
                            ),
                            margin: EdgeInsets.only(left: 10, right: 5),
                            height: 35,
                            width: screenWidth * 0.4,
                            child: Center(
                              child: Text(
                                "Estanque Llenado",
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              estadoSeleccionado = estadoAbastecimiento[127]!;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 4,
                                color: estadoAbastecimientoenString() ==
                                        "Cierre Abastecimiento"
                                    ? estadoActivo
                                    : estadoSeleccionado ==
                                            estadoAbastecimiento[127]
                                        ? estadoActivo
                                        : estadoPasivo,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              color: estadoAbastecimientoenString() ==
                                      "Cierre Abastecimiento"
                                  ? estadoActivo
                                  : estadoPasivo,
                            ),
                            margin: EdgeInsets.only(left: 5, right: 10),
                            height: 35,
                            width: screenWidth * 0.4,
                            child: Center(
                              child: Text(
                                "Cierre Abastecimiento",
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),

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
                  lat: widget.faseAbastecimiento.lat,
                  lon: widget.faseAbastecimiento.lon,
                ),
                SizedBox(height: 25),
                ComentarioGeneral(),
                SizedBox(height: 20),
                //ADJUNTAR IMAGEN
                SizedBox(height: 20),
                Container(
                  color: azulPrimarioEssbio,
                  child: TextButton(
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Guardar Cambios Datos OT'),
                            content: const Text(
                                'Has realizado modificaciones en los campos. Confirma para guardar los cambios'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Map<String, dynamic> modificacion = {
                                    "COMENTARIO": comentarioController.text,
                                    "ID_TIPO_STATUS": id_tipo_status
                                  };
                                  essbioP.updateFasesAbastecimiento(
                                      widget.faseAbastecimiento, modificacion);
                                  essbioP.fetchFasesInstalacion();
                                  essbioP.fetchFases();
                                  essbioP.fetchOrdenesTrabajo();
                                  essbioP.fetchStatus();
                                  essbioP.getFasesUsuario(
                                      essbioP.ordenesTrabajo,
                                      essbioP.fasesInstalacion,
                                      essbioP.fasesAbastMedicion,
                                      essbioP.fasesAbastecimiento,
                                      essbioP.fasesRetiro,
                                      essbioP.fases,
                                      essbioP.status,
                                      essbioP.dataTKSectores,
                                      essbioP.procesos,
                                      essbioP.dataEventos,
                                      essbioP.usuario!.idusuario);
                                  Navigator.pop(context, 'Cancel');
                                },
                                child: const Text('Confirmar'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text('Guardar cambios',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                ),
                SizedBox(height: 20),
              ],
            ),
          )),
    );
  }
}
