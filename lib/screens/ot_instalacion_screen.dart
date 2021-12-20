import 'package:essbio_apk/models/fase_instalacion.dart';
import 'package:essbio_apk/theme_library.dart';
import 'package:essbio_apk/widgets/guardar_datos_instalacion.dart';
import 'package:essbio_apk/widgets/mapa.dart';
import 'package:essbio_apk/widgets/timer_widget.dart';
import 'package:essbio_apk/widgets/widgets_essbio.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:essbio_apk/api/api.dart';
import 'package:flutter_map/flutter_map.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

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
  Color colorOTinstalacion() {
    var dataTipoEvento = widget.faseInstalacion.tipo_evento.toString();
    Color colorTipoEventoInstalacion;
    switch (dataTipoEvento) {
      case "Alerta":
        colorTipoEventoInstalacion = verdeTiempoCritico;
        break;
      case "Pre-Emergencia":
        colorTipoEventoInstalacion = amarilloTiempoCritico;
        break;
      case "Emergencia":
        colorTipoEventoInstalacion = naranjaTiempoCritico;
        break;
      case "Crisis":
        colorTipoEventoInstalacion = rojoTiempoCritico;
        break;
      default:
        colorTipoEventoInstalacion = Colors.grey;
    }
    return colorTipoEventoInstalacion;
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

  @override
  Widget build(BuildContext context) {
    // final essbioP = Provider.of<EssbioProvider>(context);
    // var fecha = widget.faseInstalacion.fecha_termino;

    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtInstalacionScreen(
                  faseInstalacion: widget.faseInstalacion))),
      child: Container(
          margin: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colorOTinstalacion(),
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
                  widget.faseInstalacion.nombre_ot,
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
                      estadoInstalacionenString(),
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

class OtInstalacionScreen extends StatefulWidget {
  final FaseInstalacion faseInstalacion;
  OtInstalacionScreen({Key? key, required this.faseInstalacion})
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

  @override
  Widget build(BuildContext context) {
    final essbioP = Provider.of<EssbioProvider>(context);
    TextEditingController comentarioController = TextEditingController();
    TextEditingController rotuloController = TextEditingController();
    String comentario_instalacion =
        widget.faseInstalacion.comentario_instalacion;
    String rotulo_tk = widget.faseInstalacion.rotulo_tk;
    String archivo_adjunto = widget.faseInstalacion.archivo_adjunto;
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
                              estadoSeleccionado = estadoInstalacion[111]!;
                              id_tipo_status = 111;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color:
                                  estadoSeleccionado == estadoInstalacion[111]
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
                              estadoSeleccionado = estadoInstalacion[113]!;
                              id_tipo_status = 113;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color:
                                  estadoSeleccionado == estadoInstalacion[113]
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
                              estadoSeleccionado = estadoInstalacion[112]!;
                              id_tipo_status = 112;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color:
                                  estadoSeleccionado == estadoInstalacion[112]
                                      ? estadoActivo
                                      : estadoPasivo,
                            ),
                            margin: EdgeInsets.only(left: 10, right: 5),
                            height: 35,
                            width: 180,
                            child: Center(
                              child: Text(
                                "Instalado",
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              estadoSeleccionado = estadoInstalacion[114]!;
                              id_tipo_status = 114;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color:
                                  estadoSeleccionado == estadoInstalacion[114]
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
                  Text("Comentario:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  Center(
                    child: Container(
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
                TextButton(
                    onPressed: () {
                      Map<String, dynamic> modificacion = {
                        "COMENTARIO_INSTALACION": comentarioController.text,
                        "ROTULO_TK": rotuloController.text,
                        "ARCHIVO_ADJUNTO": "",
                        "ID_TIPO_STATUS": id_tipo_status
                      };
                      essbioP.updateFasesInstalacion(
                          widget.faseInstalacion, modificacion);
                    },
                    child: Text('Guardar cambios',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)))
              ],
            ),
          )),
    );
  }
}
