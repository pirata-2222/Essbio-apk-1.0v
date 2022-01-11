import 'dart:convert';
import 'dart:io';

import 'package:essbio_apk/api/api.dart';
import 'package:essbio_apk/models/fase_abast_medicion.dart';
import 'package:essbio_apk/theme_library.dart';
import 'package:essbio_apk/widgets/mapa.dart';
import 'package:essbio_apk/widgets/widgets_essbio.dart';
import 'package:flutter/material.dart';
import 'package:essbio_apk/widgets/timer_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

const Color estadoActivo = Color(0xFF10988F);
const Color estadoPasivo = Color(0xFF99CBCD);

class OtPendienteMedicion extends StatefulWidget {
  final FaseAbastMedicion faseAbastMedicion;
  OtPendienteMedicion({Key? key, required this.faseAbastMedicion})
      : super(key: key);

  @override
  _OtPendienteMedicionState createState() => _OtPendienteMedicionState();
}

class _OtPendienteMedicionState extends State<OtPendienteMedicion> {
  Color colorBordeMedicion() {
    var dataTipoEvento = widget.faseAbastMedicion.tipo_evento.toString();
    Color colorTipoEventoMedicion;
    switch (dataTipoEvento) {
      case "Emergencia":
        colorTipoEventoMedicion = colorEstadoEmergencia;
        break;
      case "Crisis":
        colorTipoEventoMedicion = colorEstadoCrisis;
        break;
      default:
        colorTipoEventoMedicion = Colors.grey;
    }
    return colorTipoEventoMedicion;
  }

  Color colorOTmedicion() {
    int daysBetween(DateTime from, DateTime to) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      return (to.difference(from).inDays).round();
    }

    var fechaInicio = widget.faseAbastMedicion.fecha_inicio;
    var fechainicioFormatoDate = DateFormat("yyyy-MM-dd").parse(fechaInicio);
    var fechaTermino = widget.faseAbastMedicion.fecha_termino;
    var fechaTerminoFormatoDate = DateFormat("yyyy-MM-dd").parse(fechaTermino);
    var fechaActual = DateTime.now();
    var eventosFuturosMedicionTiempo =
        daysBetween(fechaActual, fechainicioFormatoDate);
    var tiempoRestanteMedicion =
        daysBetween(fechaActual, fechaTerminoFormatoDate);

    Color colorTiempoRestanteMedicion = Colors.grey;

    if (tiempoRestanteMedicion > 0 && eventosFuturosMedicionTiempo < 0) {
      colorTiempoRestanteMedicion = colorEventoEnCurso;
    }
    if (tiempoRestanteMedicion <= 0 && eventosFuturosMedicionTiempo < 0) {
      colorTiempoRestanteMedicion = colorEventoAtrasado;
    }
    if (eventosFuturosMedicionTiempo > 0) {
      colorTiempoRestanteMedicion = colorEventoFuturo;
    }
    return colorTiempoRestanteMedicion;
  }

  String estadoMedicionenString() {
    var dataEstadoMedicion = widget.faseAbastMedicion.id_tipo_status.toString();

    switch (dataEstadoMedicion) {
      case "130":
        dataEstadoMedicion = "Finalizado";
        break;
      case "131":
        dataEstadoMedicion = "En Curso";
        break;
      case "132":
        dataEstadoMedicion = "No Disponible";
        break;
      case "133":
        dataEstadoMedicion = "Medido";
        break;
      default:
    }

    return dataEstadoMedicion;
  }

  callback(int newStatus) {
    setState(() {
      print(newStatus);
      widget.faseAbastMedicion.id_tipo_status = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtMedicionScreen(
                  faseAbastMedicion: widget.faseAbastMedicion,
                  callback: callback))),
      child: Container(
          margin: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            border: Border.all(color: colorBordeMedicion(), width: 5.0),
            borderRadius: BorderRadius.circular(10),
            color: colorOTmedicion(),
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
                  widget.faseAbastMedicion.nombre_corte,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  widget.faseAbastMedicion.nombre_ot,
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
                      estadoMedicionenString(),
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
                          widget.faseAbastMedicion.ods,
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

class OtMedicionScreen extends StatefulWidget {
  final FaseAbastMedicion faseAbastMedicion;
  final Function(int) callback;
  OtMedicionScreen(
      {Key? key, required this.faseAbastMedicion, required this.callback})
      : super(key: key);

  @override
  _OtMedicionScreenState createState() => _OtMedicionScreenState();
}

class _OtMedicionScreenState extends State<OtMedicionScreen> {
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

  String nivelAguaCumpleNorma = 'NIVEL DE AGUA CUMPLE NORMA';
  String nivelCloroCumpleNorma = 'NIVEL CLORO CUMPLE NORMA';
  String nivelTurbiedadCumpleNorma = 'TURBIEDAD CUMPLE NORMA';

  Map<int, String> estadoMedicion = {
    130: "Finalizado",
    131: "En Curso",
    132: "No Disponible",
    133: "Medido",
  };
  String estadoSeleccionado = "";
  var currentStatus;
  String estadoActualString = " ";

  String estadoMedicionenString() {
    var dataEstadoMedicion = widget.faseAbastMedicion.id_tipo_status.toString();
//  130: "Finalizado",
//     131: "En Curso",
//     132: "No Disponible",
//     133: "Medido",
//   };
    switch (dataEstadoMedicion) {
      case "130":
        dataEstadoMedicion = "Finalizado";
        break;
      case "131":
        dataEstadoMedicion = "En Curso";
        break;
      case "132":
        dataEstadoMedicion = "No Disponible";
        break;
      case "133":
        dataEstadoMedicion = "Medido";
        break;
      default:
    }

    return dataEstadoMedicion;
  }

  int numeroIDstatusMedicion = 0;
  TextEditingController comentarioMedicionController = TextEditingController();
  TextEditingController nivelAguaController = TextEditingController();
  TextEditingController nivelAguaNormaController = TextEditingController();
  TextEditingController nivelCloroController = TextEditingController();
  TextEditingController nivelTurbiedadController = TextEditingController();
  TextEditingController horaMedicionController = TextEditingController();

  var numeroIdAcompanante;
  String aguaCumple = " ";
  String cloroCumple = " ";
  String turbiedadCumple = " ";

  // Initial Selected Value
  String dropdownvalue = '- Seleccionar Opción -';

  // List of items in our dropdown menu
  var items = [
    '- Seleccionar Opción -',
    '1. Ministerio de Salud',
    '2. Municipalidad',
    '3. SISS',
    '4. Sin Acompañante',
  ];

  @override
  Widget build(BuildContext context) {
    // comentarioMedicionController.text = widget.faseAbastMedicion.comentario;
    // horaMedicionController.text = widget.faseAbastMedicion.hora_medicion;
    final essbioP = Provider.of<EssbioProvider>(context);

    int id_tipo_status = widget.faseAbastMedicion.id_tipo_status;
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: 5),
                      Text(widget.faseAbastMedicion.nombre_ot,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                      SizedBox(height: 5),
                      Text("Fase 3 - Medición",
                          style: TextStyle(color: Colors.white)),
                      SizedBox(height: 5),
                      Text("Estado Actual: " + estadoMedicionenString(),
                          style: TextStyle(color: Colors.white)),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                //TIEMPO RESTANTE SEGÚN ASIGNADO
                TimerEssbio(
                    fecha: widget.faseAbastMedicion.fecha_termino
                        .toString()
                        .substring(0, 10)),

                //ESTADOS DE LA OT
                Text("Cambio de Estado",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                SizedBox(height: 5),
                estadosOT(widget.faseAbastMedicion.statuses,
                    estadoMedicionenString()),
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
                  lat: widget.faseAbastMedicion.lat,
                  lon: widget.faseAbastMedicion.lon,
                ),
                SizedBox(height: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("                NIVEL AGUA (%)"),
                    Center(
                      child: Container(
                        color: Color(0xFF8AB5CF),
                        height: 30,
                        width: 300,
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: TextField(
                          controller: nivelAguaController,
                          onChanged: (value) {
                            setState(() {
                              var valorControllerAgua =
                                  double.parse(nivelAguaController.text);
                              if (valorControllerAgua < 30) {
                                aguaCumple = "NIVEL DE AGUA NO CUMPLE NORMA";
                              }
                              if (valorControllerAgua > 30) {
                                aguaCumple = "NIVEL DE AGUA CUMPLE NORMA";
                              }
                              if (valorControllerAgua == null) {
                                aguaCumple = "SE REQUIEREN DATOS DE MEDICIÓN";
                              }
                            });
                          },
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text("                NIVEL AGUA CUMPLE NORMA"),
                    Center(
                      child: Container(
                        color: Color(0xFF8AB5CF),
                        height: 30,
                        width: 300,
                        child: Text(aguaCumple),
                        // double.parse(nivelAguaController.text) < 30
                        //     ? Text("NO")
                        //     : Text("SÍ"),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text("                NIVEL CLORO Mg/L"),
                    Center(
                      child: Container(
                        color: Color(0xFF8AB5CF),
                        height: 30,
                        width: 300,
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: TextField(
                          controller: nivelCloroController,
                          onChanged: (value) {
                            setState(() {
                              var valorControllerCloro =
                                  double.parse(nivelCloroController.text);

                              if (valorControllerCloro < 0.2 ||
                                  valorControllerCloro > 2) {
                                cloroCumple = "NIVEL DE CLORO NO CUMPLE NORMA";
                              }
                              if (valorControllerCloro >= 0.2 &&
                                  valorControllerCloro <= 2) {
                                cloroCumple = "NIVEL DE CLORO CUMPLE NORMA";
                              }
                              if (valorControllerCloro == null) {
                                cloroCumple = "SE REQUIEREN DATOS DE MEDICIÓN";
                              }
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text("                NIVEL CLORO CUMPLE NORMA"),
                    Center(
                      child: Container(
                        color: Color(0xFF8AB5CF),
                        height: 30,
                        width: 300,
                        child: Text(cloroCumple),
                        // child: double.parse(nivelCloroController.text) < 30
                        //     ? Text("NO")
                        //     : Text("SÍ"),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text("                TURBIEDAD"),
                    Center(
                      child: Container(
                        color: Color(0xFF8AB5CF),
                        height: 30,
                        width: 300,
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: TextField(
                          controller: nivelTurbiedadController,
                          onChanged: (value) {
                            setState(() {
                              var valorControllerTurbiedad =
                                  double.parse(nivelTurbiedadController.text);
                              if (valorControllerTurbiedad > 2) {
                                turbiedadCumple =
                                    "NIVEL DE TURBIEDAD NO CUMPLE NORMA";
                              }
                              if (valorControllerTurbiedad <= 2) {
                                turbiedadCumple =
                                    "NIVEL DE TURBIEDAD CUMPLE NORMA";
                              }

                              if (valorControllerTurbiedad == false) {
                                turbiedadCumple =
                                    "SE REQUIEREN DATOS DE MEDICIÓN";
                              }
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text("                TURBIEDAD CUMPLE NORMA"),
                    Center(
                      child: Container(
                          color: Color(0xFF8AB5CF),
                          height: 30,
                          width: 300,
                          child: Text(turbiedadCumple)
                          // double.parse(nivelTurbiedadController.text) > 2
                          //     ? Text("Valor no cumple norma")
                          //     : Text("Valor sí cumple norma"),
                          ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                // CAMPO HORA DE MEDICIÓN
                Column(children: [
                  Text("Hora de Medición:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  Center(
                    child: Container(
                      height: 50.0,
                      width: screenWidth * 0.5,
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: horaMedicionController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: widget.faseAbastMedicion.hora_medicion),
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 20),
                //ACOMPAÑADO POR
                Column(children: [
                  Text("Acompañado por: ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  Center(
                    child: DropdownButton(
                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
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
                // SizedBox(
                //   height: 30,
                // ),
                // Column(children: [
                //   Text("Último Comentario:",
                //       style:
                //           TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                //   Center(
                //     child: Container(
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           color: celesteEssbio),
                //       height: 50.0,
                //       width: screenWidth * 0.8,
                //       margin: EdgeInsets.symmetric(horizontal: 20),
                //       child: Container(
                //         margin: EdgeInsets.all(10),
                //         child: Text(
                //           widget.faseAbastMedicion.comentario.toString(),
                //           style: TextStyle(color: Colors.white),
                //         ),
                //       ),
                //     ),
                //   ),
                // ]),
                SizedBox(height: 25),
                Column(children: [
                  Text("Comentar:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  Center(
                    child: Container(
                      height: 80.0,
                      width: screenWidth * 0.8,
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: comentarioMedicionController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: widget.faseAbastMedicion.comentario),
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
                                  if (int.parse(nivelAguaController.text) <
                                      30) {
                                    nivelAguaCumpleNorma = "S";
                                  } else {
                                    nivelAguaCumpleNorma = "N";
                                  }

                                  if (int.parse(nivelCloroController.text) <
                                          0.2 ||
                                      int.parse(nivelCloroController.text) >
                                          2) {
                                    nivelAguaCumpleNorma = "N";
                                  } else {
                                    nivelAguaCumpleNorma = "S";
                                  }

                                  if (int.parse(
                                          nivelTurbiedadController.text) <=
                                      2) {
                                    nivelAguaCumpleNorma = "S";
                                  } else {
                                    nivelAguaCumpleNorma = "N";
                                  }

                                  if (dropdownvalue ==
                                      '- Seleccionar Opción -') {
                                    numeroIdAcompanante = null;
                                  }
                                  if (dropdownvalue ==
                                      '1. Ministerio de Salud') {
                                    numeroIdAcompanante = 1;
                                  }
                                  if (dropdownvalue == '2. Municipalidad') {
                                    numeroIdAcompanante = 2;
                                  }
                                  if (dropdownvalue == '3. SISS') {
                                    numeroIdAcompanante = 3;
                                  }
                                  if (dropdownvalue == '4. Sin Acompañante') {
                                    numeroIdAcompanante = 4;
                                  }

//  '- Seleccionar Opción -',
//     '1. Ministerio de Salud',
//     '2. Municipalidad',
//     '3. SISS',
//     '4. Sin Acompañante',
                                  Map<String, dynamic> modificacion = {
                                    "NIVEL_AGUA": nivelAguaController.text,
                                    "NIVEL_AGUA_CUMPLE_NORMA":
                                        nivelAguaCumpleNorma,
                                    "NIVEL_CLORO": nivelCloroController.text,
                                    "NIVEL_CLORO_CUMPLE_NORMA":
                                        widget.faseAbastMedicion,
                                    "NIVEL_TURBIEDAD":
                                        nivelTurbiedadController.text,
                                    "NIVEL_TURBIEDAD_CUMPLE_NORMA":
                                        nivelTurbiedadCumpleNorma,
                                    "HORA_MEDICION":
                                        horaMedicionController.text,
                                    "ACOMPANADO_POR": numeroIdAcompanante,
                                    "IMAGEN": imagenFormatoEncode64,
                                    "COMENTARIO":
                                        comentarioMedicionController.text,
                                    // "ID_TIPO_STATUS": id_tipo_status,
                                    "ID_TIPO_STATUS": currentStatus
                                  };
                                  // widget.faseAbastMedicion.id_tipo_status =
                                  //     numeroIDstatusMedicion;
                                  // widget.callback(numeroIDstatusMedicion);
                                  // widget.callback(currentStatus);
                                  setState(() {
                                    estadoMedicionenString();
                                  });
                                  essbioP.updateFasesMedicion(
                                      widget.faseAbastMedicion, modificacion);

                                  print("Acompañante: " + numeroIdAcompanante);

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
                SizedBox(height: 20)
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
                  .firstWhere((entry) => entry.value == 131)
                  .key;
            }
            if (estadoActualString == "MEDIDO") {
              currentStatus = statuses.entries
                  .firstWhere((entry) => entry.value == 133)
                  .key;
            }
            if (estadoActualString == "NO DISPONIBLE") {
              currentStatus = statuses.entries
                  .firstWhere((entry) => entry.value == 132)
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
              color: widget.faseAbastMedicion.id_tipo_status == status
                  ? estadoActivo
                  : estadoSeleccionado == tipo_status[status]
                      ? estadoActivo
                      : estadoPasivo,
            ),
            borderRadius: BorderRadius.circular(15),
            color: widget.faseAbastMedicion.id_tipo_status == status
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
