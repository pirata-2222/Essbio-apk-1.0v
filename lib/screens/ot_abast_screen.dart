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
        colorTipoEventoAbastecimiento = colorEstadoEmergencia;
        break;
      case "Crisis":
        colorTipoEventoAbastecimiento = colorEstadoCrisis;
        break;
      default:
        colorTipoEventoAbastecimiento = Colors.grey;
    }
    return colorTipoEventoAbastecimiento;
  }

// TODO: Hacer funcion para icono de OT Abastecimiento
  Icon iconoOTAbastecimiento() {
    Icon iconoAbast = Icon(Icons.ac_unit);
    return Icon(Icons.ac_unit);
  }

  Color colorOTabastecimiento() {
    int daysBetween(DateTime from, DateTime to) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      return (to.difference(from).inDays).round();
    }

    var fechaInicio = widget.faseAbastecimiento.fecha_inicio;
    var fechainicioFormatoDate = DateFormat("yyyy-MM-dd").parse(fechaInicio);
    var fechaTermino = widget.faseAbastecimiento.fecha_termino;
    var fechaTerminoFormatoDate = DateFormat("yyyy-MM-dd").parse(fechaTermino);
    var fechaActual = DateTime.now();
    var eventosFuturosAbastecimientoTiempo =
        daysBetween(fechaActual, fechainicioFormatoDate);
    var tiempoRestanteAbastecimiento =
        daysBetween(fechaActual, fechaTerminoFormatoDate);

    Color colorTiempoRestanteAbastecimiento = Colors.grey;

    if (tiempoRestanteAbastecimiento > 0 &&
        eventosFuturosAbastecimientoTiempo < 0) {
      colorTiempoRestanteAbastecimiento = colorEventoEnCurso;
    }
    if (tiempoRestanteAbastecimiento <= 0 &&
        eventosFuturosAbastecimientoTiempo < 0) {
      colorTiempoRestanteAbastecimiento = colorEventoAtrasado;
    }
    if (eventosFuturosAbastecimientoTiempo > 0) {
      colorTiempoRestanteAbastecimiento = colorEventoFuturo;
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

  callback(int newStatus) {
    setState(() {
      print(newStatus);
      widget.faseAbastecimiento.id_tipo_status = newStatus;
    });
  }

  int numeroIDstatusAbastecimiento = 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtAbastScreen(
                  faseAbastecimiento: widget.faseAbastecimiento,
                  callback: callback))),
      child: Container(
          margin: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            border: Border.all(color: colorBordeAbastecimiento(), width: 5.0),
            borderRadius: BorderRadius.circular(10),
            color: colorOTabastecimiento(),
          ),
          width: 160,
          height: 220,
          child: Column(
            children: [
              SizedBox(height: 5),
              Icon(Icons.file_copy, color: Colors.white, size: 37.5),
              SizedBox(height: 10),
              Center(
                child: Text(
                  widget.faseAbastecimiento.nombre_corte,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  widget.faseAbastecimiento.nombre_ot,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
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
                    SizedBox(height: 10),
                    Column(
                      children: [
                        Text(
                          "Número ODS: ",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          widget.faseAbastecimiento.ods,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
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
  final Function(int) callback;
  OtAbastScreen(
      {Key? key, required this.faseAbastecimiento, required this.callback})
      : super(key: key);

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
  var currentStatus;
  String estadoActualString = " ";

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
  int numeroIDstatusAbastecimiento = 0;
  TextEditingController comentarioAbastecimientoController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final essbioP = Provider.of<EssbioProvider>(context);

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
                Text("Cambio de Estado",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                SizedBox(height: 5),
                estadosOT(widget.faseAbastecimiento.statuses,
                    estadoAbastecimientoenString()),

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
                Column(children: [
                  Text("Último Comentario:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: celesteEssbio),
                      height: 50.0,
                      width: screenWidth * 0.8,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          widget.faseAbastecimiento.comentario.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 25),
                Column(children: [
                  Text("Comentar:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  Center(
                    child: Container(
                      height: 50.0,
                      width: screenWidth * 0.8,
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: comentarioAbastecimientoController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Escribe tu comentario'),
                      ),
                    ),
                  ),
                ]),
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
                                    "COMENTARIO":
                                        comentarioAbastecimientoController.text,
                                    // "ID_TIPO_STATUS":
                                    //     numeroIDstatusAbastecimiento,
                                    "ID_TIPO_STATUS": currentStatus,
                                  };
                                  // widget.faseAbastecimiento.id_tipo_status =
                                  //     numeroIDstatusAbastecimiento;
                                  // widget.callback(numeroIDstatusAbastecimiento);
                                  widget.callback(currentStatus);
                                  setState(() {
                                    estadoAbastecimientoenString();
                                  });
                                  essbioP.updateFasesAbastecimiento(
                                      widget.faseAbastecimiento, modificacion);

                                  Navigator.pop(context, 'Cancel');
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title:
                                                const Text("Cambios Guardados"),
                                            content: const Text(
                                                "Tus cambios han sido guardados con éxito, estos deberían verse reflejados en menos de 1 minuto en tu app"),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ));
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

  Container estadosOT(
      Map<int, int> statuses, String estadoInstalacionenString) {
    Map<int, String> tipo_status = {
      8: 'INSTALADO',
      9: 'NO DISPONIBLE',
      17: 'RETIRADO',
      18: 'NO DISPONIBLE (R)',
      10: 'INICIO CARGA CAMIÓN',
      11: 'TÉRMINO CARGA CAMIÓN',
      12: 'INICIO ABASTECIMIENTO',
      13: 'TÉRMINO ABASTECIMIENTO',
      15: 'MEDIDO',
      16: 'SUPERVISADO',
      14: 'CIERRE ABASTECIMIENTO',
      1: 'INICIO',
      2: 'CANCELADO',
      3: 'FINALIZADO',
      4: 'EN CURSO',
      5: 'PAUSA',
      6: 'RECHAZADO',
      7: 'REVISION',
      110: 'ELIMINADO',
      111: 'EN CURSO',
      112: 'INSTALADO',
      113: 'NO DISPONIBLE',
      120: 'ELIMINADO',
      121: 'EN CURSO',
      122: 'NO DISPONIBLE',
      123: 'INICIO CARGA CAMIÓN',
      124: 'TÉRMINO CARGA CAMIÓN',
      125: 'INICIO ABASTECIMIENTO',
      126: 'ESTANQUE LLENADO',
      127: 'CIERRE ABASTECIMIENTO',
      130: 'ELIMINADO',
      131: 'EN CURSO',
      132: 'NO DISPONIBLE',
      133: 'MEDIDO',
      140: 'ELIMINADO',
      141: 'EN CURSO',
      142: 'RETIRADO',
      143: 'NO DISPONIBLE (R)',
      114: 'POR INSTALAR'
    };
    var screenWidth = MediaQuery.of(context).size.width;
    List<InkWell> estados = [];
    // opciones = {
    //20987 : 113
    //20988 : 112}
    // current status = 20888

    InkWell widgetEstado(int status) {
      return InkWell(
        onTap: () {
          setState(() {
            estadoSeleccionado = tipo_status[status]!;
            estadoActualString = tipo_status[status]!.toString();
            if (estadoActualString == "EN CURSO") {
              currentStatus = statuses.entries
                  .firstWhere((entry) => entry.value == 121)
                  .key;
            }
            if (estadoActualString == "ESTANQUE LLENADO") {
              currentStatus = statuses.entries
                  .firstWhere((entry) => entry.value == 126)
                  .key;
            }
            if (estadoActualString == "NO DISPONIBLE") {
              currentStatus = statuses.entries
                  .firstWhere((entry) => entry.value == 122)
                  .key;
            }
            if (estadoActualString == "CIERRE ABASTECIMIENTO") {
              currentStatus = statuses.entries
                  .firstWhere((entry) => entry.value == 127)
                  .key;
            }

            print("tipo_status[status]: " + tipo_status[status].toString());
            print("tipo_status: " + tipo_status.toString());
            print("status: " + status.toString());
            print("statuses: " + statuses.toString());
            print("statuses.keys: " + statuses.keys.toString());
            print("statuses.values: " + statuses.values.toString());
            print("estadoSeleccionado: " + estadoSeleccionado);
            print("current status: " + currentStatus.toString());
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 4,
              color: widget.faseAbastecimiento.id_tipo_status == status
                  ? estadoActivo
                  : estadoSeleccionado == tipo_status[status]
                      ? estadoActivo
                      : estadoPasivo,
            ),
            borderRadius: BorderRadius.circular(15),
            color: widget.faseAbastecimiento.id_tipo_status == status
                ? estadoActivo
                : estadoPasivo,
          ),
          margin: EdgeInsets.only(left: 10, right: 5, bottom: 10),
          height: 40,
          width: screenWidth * 0.4,
          child: Center(
            child: Text(
              tipo_status[status]!,
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    statuses.forEach((id_status, id_tipo_status) {
      estados.add(widgetEstado(id_tipo_status));
    });
    return Container(
      width: screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: estados,
      ),
    );
  }
}
