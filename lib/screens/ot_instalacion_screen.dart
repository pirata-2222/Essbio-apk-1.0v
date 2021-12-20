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

const Color estadoActivo = Color(0xFF10988F);
const Color estadoPasivo = Color(0xFF99CBCD);

enum Estado { EnCurso, NoDisponible, Instalado, Pendiente, Empty }

class OtPendienteInstalacion extends StatefulWidget {
  final FaseInstalacion faseInstalacion;
  OtPendienteInstalacion({Key? key, required this.faseInstalacion})
      : super(key: key);

  @override
  _OtPendienteInstalacionState createState() => _OtPendienteInstalacionState();
}

class _OtPendienteInstalacionState extends State<OtPendienteInstalacion> {
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
            color: amarilloTiempoCritico,
          ),
          width: 100,
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
  File? _imagen;
  final picker = ImagePicker();

  Future selImagen(op) async {
    var pickedFile;
    if (op == 1) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      if (pickedFile != null) {
        _imagen = File(pickedFile.path);
      } else {
        print("No se ha seleccionado ninguna foto");
      }
    });
    Navigator.of(context).pop();
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
                          selImagen(1);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1, color: Colors.grey),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Tomar una fotografía",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Icon(
                                Icons.camera_alt,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          selImagen(2);
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Seleccionar de Galería",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Icon(
                                Icons.image,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(color: Colors.red),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Cancelar",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ));
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
                ComentarioGeneral(),
                SizedBox(height: 20),
                //ADJUNTAR IMAGEN
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xFFDD0009))),
                            onPressed: () => opciones(context),
                            child: Text(
                              "Tomar/Adjuntar Fotografía",
                              style: TextStyle(color: Colors.white),
                            )),
                        _imagen == null
                            ? Icon(
                                Icons.image_outlined,
                                color: Colors.grey,
                                size: 40,
                              )
                            : Image.file(_imagen!)
                      ]),
                ),
                SizedBox(height: 20),
                //RÓTULO TK
                RotuloTKField(),
                SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      Map<String, dynamic> modificacion = {
                        "COMENTARIO_INSTALACION": "hot",
                        "ROTULO_TK": "HOLA",
                        "ARCHIVO_ADJUNTO": "HOLA",
                        "ID_TIPO_STATUS": "HOLA"
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
