import 'dart:typed_data';

import 'package:essbio_apk/models/fase_instalacion.dart';
import 'package:essbio_apk/theme_library.dart';
import 'package:essbio_apk/widgets/mapa.dart';
import 'package:essbio_apk/widgets/timer_widget.dart';
import 'package:essbio_apk/widgets/widgets_essbio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:essbio_apk/api/api.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

const Color estadoActivo = Color(0xFF10988F);
const Color estadoPasivo = Color(0xFF99CBCD);

class OtPendienteInstalacion extends StatefulWidget {
  final FaseInstalacion faseInstalacion;

  OtPendienteInstalacion({Key? key, required this.faseInstalacion})
      : super(key: key);

  @override
  _OtPendienteInstalacionState createState() => _OtPendienteInstalacionState();
}

class _OtPendienteInstalacionState extends State<OtPendienteInstalacion> {
  Color colorBordeInstalacion() {
    var dataTipoEvento = widget.faseInstalacion.tipo_evento.toString();
    Color colorTipoEventoInstalacion;
    switch (dataTipoEvento) {
      case "Emergencia":
        colorTipoEventoInstalacion = colorEstadoEmergencia;
        break;
      case "Crisis":
        colorTipoEventoInstalacion = colorEstadoCrisis;
        break;
      default:
        colorTipoEventoInstalacion = Colors.grey;
    }
    return colorTipoEventoInstalacion;
  }

  Color colorOTinstalacion() {
    int daysBetween(DateTime from, DateTime to) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      return (to.difference(from).inDays).round();
    }

    var fechaInicio = widget.faseInstalacion.fecha_inicio;
    var fechainicioFormatoDate = DateFormat("yyyy-MM-dd").parse(fechaInicio);
    var fechaTermino = widget.faseInstalacion.fecha_termino;
    var fechaTerminoFormatoDate = DateFormat("yyyy-MM-dd").parse(fechaTermino);
    var fechaActual = DateTime.now();
    var eventosFuturosTiempo = daysBetween(fechaActual, fechainicioFormatoDate);
    var tiempoRestanteInstalacion =
        daysBetween(fechaActual, fechaTerminoFormatoDate);

    Color colorTiempoRestanteInstalacion = Colors.grey;

    if (tiempoRestanteInstalacion > 0 && eventosFuturosTiempo < 0) {
      colorTiempoRestanteInstalacion = colorEventoEnCurso;
    }
    if (tiempoRestanteInstalacion <= 0 && eventosFuturosTiempo < 0) {
      colorTiempoRestanteInstalacion = colorEventoAtrasado;
    }
    if (eventosFuturosTiempo > 0) {
      colorTiempoRestanteInstalacion = colorEventoFuturo;
    }
    return colorTiempoRestanteInstalacion;
  }

  String estadoInstalacionenString() {
    var dataEstadoinstalacion =
        widget.faseInstalacion.id_tipo_status.toString();
    switch (dataEstadoinstalacion) {
      case "110":
        dataEstadoinstalacion = "Finalizado";
        break;
      case "111":
        dataEstadoinstalacion = "En Curso";
        break;
      case "112":
        dataEstadoinstalacion = "Instalado";
        break;
      case "113":
        dataEstadoinstalacion = "No Disponible";
        break;
      case "114":
        dataEstadoinstalacion = "Pendiente";
        break;
      default:
    }
    return dataEstadoinstalacion;
  }

  callback(int newStatus) {
    setState(() {
      print(newStatus);
      widget.faseInstalacion.id_tipo_status = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final essbioP = Provider.of<EssbioProvider>(context);
    // var fecha = widget.faseInstalacion.fecha_termino;

    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtInstalacionScreen(
                  faseInstalacion: widget.faseInstalacion,
                  callback: callback))),
      child: Container(
          margin: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            border: Border.all(color: colorBordeInstalacion(), width: 5.0),
            borderRadius: BorderRadius.circular(10),
            color: colorOTinstalacion(),
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
                  widget.faseInstalacion.nombre_corte,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  widget.faseInstalacion.nombre_ot,
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
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      estadoInstalacionenString(),
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
                          widget.faseInstalacion.ods,
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

class OtInstalacionScreen extends StatefulWidget {
  final FaseInstalacion faseInstalacion;
  final Function(int) callback;
  OtInstalacionScreen(
      {Key? key, required this.faseInstalacion, required this.callback})
      : super(key: key);

  @override
  _OtInstalacionScreenState createState() => _OtInstalacionScreenState();
}

class _OtInstalacionScreenState extends State<OtInstalacionScreen> {
  Map<int, String> estadoInstalacion = {
    110: "Finalizado",
    111: "En Curso",
    112: "Instalado",
    113: "No disponible",
    114: "Pendiente",
  };
  String estadoSeleccionado = "";
  var currentStatus;
  String estadoActualString = " ";

  Map<String, dynamic> datosActualizarInstalacion = {
    "ID_TIPO_STATUS": "",
    "COMENTARIO_INSTALACION": "",
    "ARCHIVO_ADJUNTO": "",
    "ROTULO_TK": "",
  };

// *****CONFIGURACION PARA IMAGE PICKER*****
  File? imagen = null;
  final picker = ImagePicker();

  Future selimagen(op) async {
    var pickedFile;

    if (op == 1) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      if (pickedFile != null) {
        imagen = File(pickedFile.path);
      } else {
        print('No selecciono una foto');
      }
    });
  }

  opciones(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      selimagen(1);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.grey))),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Tomar una foto',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Icon(Icons.camera_alt, color: Colors.blue)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      selimagen(2);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Seleccionar Foto',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Icon(Icons.image, color: Colors.blue)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.red,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Listo',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  // *******************************************************************
  int numeroIDstatusInstalacion = 0;
  String databaseText = " ";
  TextEditingController comentarioController = TextEditingController();
  TextEditingController rotuloController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final essbioP = Provider.of<EssbioProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;

    int id_tipo_status = widget.faseInstalacion.id_tipo_status;

    String estadoInstalacionenString() {
      var dataEstadoinstalacion =
          widget.faseInstalacion.id_tipo_status.toString();

      switch (dataEstadoinstalacion) {
        case "110":
          dataEstadoinstalacion = "Finalizado";
          break;
        case "111":
          dataEstadoinstalacion = "En Curso";
          break;
        case "112":
          dataEstadoinstalacion = "Instalado";
          break;
        case "113":
          dataEstadoinstalacion = "No Disponible";
          break;
        case "114":
          dataEstadoinstalacion = "Pendiente";
          break;
        default:
      }
      return dataEstadoinstalacion;
    }

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
                          onTap: () {
                            Navigator.pop(context);
                          }),
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
                      Text(
                        widget.faseInstalacion.nombre_ot,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 5),
                      Text("Fase 1 -Instalación",
                          style: TextStyle(color: Colors.white)),
                      SizedBox(height: 5),
                      Text("Estado: " + estadoInstalacionenString(),
                          style: TextStyle(color: Colors.white)),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                //TIEMPO RESTANTE SEGÚN ASIGNADO
                TimerEssbio(
                    fecha: widget.faseInstalacion.fecha_termino
                        .toString()
                        .substring(0, 10)),

                //ESTADOS DE LA OT
                Text("Cambio de Estado",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                SizedBox(height: 5),
                estadosOT(widget.faseInstalacion.statuses,
                    estadoInstalacionenString()),
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
                  lat: widget.faseInstalacion.lat,
                  lon: widget.faseInstalacion.lon,
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
                          widget.faseInstalacion.comentario_instalacion
                              .toString(),
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
                        controller: comentarioController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Escribe tu comentario'),
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 20),
                //ADJUNTAR IMAGEN
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(rojoEssbio)),
                        onPressed: () {
                          opciones(context);
                        },
                        child: Center(
                          child: Row(
                            children: [
                              Text(
                                '                        Adjuntar Fotografía',
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(Icons.image)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      imagen != null ? Image.file(imagen!) : Center()
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Column(children: [
                  Text("Último Rótulo TK Registrado:",
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
                      child: Center(
                        child: Text(
                          widget.faseInstalacion.rotulo_tk.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ]),
                SizedBox(
                  height: 25,
                ),
                //RÓTULO TK
                Column(children: [
                  Text("Rótulo TK:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  Center(
                    child: Container(
                      color: Colors.white,
                      height: 30,
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      child: TextField(
                        controller: rotuloController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ]),
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
                                  var imagenEnBytes = imagen?.readAsBytesSync();
                                  String imagenFormatoEncode64 = "";
                                  imagen == null
                                      ? ""
                                      : imagenFormatoEncode64 =
                                          base64Encode(imagenEnBytes!);
                                  Map<String, dynamic> modificacion = {
                                    "COMENTARIO_INSTALACION":
                                        comentarioController.text,
                                    "ROTULO_TK": rotuloController.text,
                                    "ARCHIVO_ADJUNTO": imagenFormatoEncode64,
                                    // "ID_TIPO_STATUS": numeroIDstatusInstalacion,
                                    "ID_TIPO_STATUS": currentStatus
                                  };

                                  // print("id tipo status es " +
                                  //     id_tipo_status.toString());
                                  // widget.faseInstalacion.id_tipo_status =
                                  //     numeroIDstatusInstalacion;
                                  // widget.callback(numeroIDstatusInstalacion);
                                  widget.callback(currentStatus);
                                  setState(() {
                                    estadoInstalacionenString();
                                  });
                                  essbioP.updateFasesInstalacion(
                                      widget.faseInstalacion, modificacion);
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
                  .firstWhere((entry) => entry.value == 111)
                  .key;
            }
            if (estadoActualString == "INSTALADO") {
              currentStatus = statuses.entries
                  .firstWhere((entry) => entry.value == 112)
                  .key;
            }
            if (estadoActualString == "NO DISPONIBLE") {
              currentStatus = statuses.entries
                  .firstWhere((entry) => entry.value == 113)
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

          // I/flutter (20302): tipo_status[status]: EN CURSO
//           I/flutter (20302): status: 111
// I/flutter (20302): statuses: {22502: 111, 22503: 112, 22504: 113}
// I/flutter (20302): statuses.keys: (22502, 22503, 22504)
// I/flutter (20302): statuses.values: (111, 112, 113)
// I/flutter (20302): estadoSeleccionado: EN CURSO
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 4,
              color: widget.faseInstalacion.id_tipo_status == status
                  ? estadoActivo
                  : estadoSeleccionado == tipo_status[status]
                      ? estadoActivo
                      : estadoPasivo,
            ),
            borderRadius: BorderRadius.circular(15),
            color: widget.faseInstalacion.id_tipo_status == status
                ? estadoActivo
                : estadoPasivo,
          ),
          margin: EdgeInsets.only(left: 10, right: 5, bottom: 10),
          height: 35,
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
