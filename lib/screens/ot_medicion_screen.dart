import 'package:essbio_apk/api/api.dart';
import 'package:essbio_apk/models/fase_abast_medicion.dart';
import 'package:essbio_apk/theme_library.dart';
import 'package:essbio_apk/widgets/mapa.dart';
import 'package:essbio_apk/widgets/widgets_essbio.dart';
import 'package:flutter/material.dart';
import 'package:essbio_apk/widgets/timer_widget.dart';
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
          width: 120,
          height: 180,
          child: Column(
            children: [
              SizedBox(height: 5),
              Icon(Icons.file_copy, color: Colors.white, size: 37.5),
              SizedBox(height: 5),
              Center(
                child: Text(
                  widget.faseAbastMedicion.nombre_ot,
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
                      estadoMedicionenString(),
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
  String dropdownValueNivelAgua = 'NIVEL DE AGUA CUMPLE NORMA';
  String dropdownValueNivelCloro = 'NIVEL CLORO CUMPLE NORMA';
  String dropdownValueNivelTurbiedad = 'TURBIEDAD CUMPLE NORMA';

  Map<int, String> estadoMedicion = {
    130: "Finalizado",
    131: "En Curso",
    132: "No Disponible",
    133: "Medido",
  };
  String estadoSeleccionado = "";

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
  TextEditingController comentarioController = TextEditingController();
  TextEditingController nivelAguaController = TextEditingController();
  TextEditingController nivelCloroController = TextEditingController();
  TextEditingController nivelTurbiedadController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                    Text("                NIVEL AGUA"),
                    MedicionTextField(),
                    SizedBox(height: 15),
                    Text("                NIVEL AGUA CUMPLE NORMA"),
                    Center(
                        child: Container(
                      color: Color(0xFF8AB5CF),
                      height: 30,
                      width: 300,
                      child: DropdownButton<String>(
                        value: dropdownValueNivelAgua,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Color(0xFF8AB5CF),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValueNivelAgua = newValue!;
                          });
                        },
                        items: <String>[
                          'NIVEL DE AGUA CUMPLE NORMA',
                          'SI',
                          'NO'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )),
                    SizedBox(height: 15),
                    Text("                NIVEL CLORO Mg/L"),
                    MedicionTextField(),
                    SizedBox(height: 15),
                    Text("                NIVEL CLORO CUMPLE NORMA"),
                    Center(
                        child: Container(
                      color: Color(0xFF8AB5CF),
                      height: 30,
                      width: 300,
                      child: DropdownButton<String>(
                        value: dropdownValueNivelCloro,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Color(0xFF8AB5CF),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValueNivelCloro = newValue!;
                          });
                        },
                        items: <String>['NIVEL CLORO CUMPLE NORMA', 'SI', 'NO']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )),
                    SizedBox(height: 15),
                    Text("                TURBIEDAD"),
                    MedicionTextField(),
                    SizedBox(height: 15),
                    Text("                TURBIEDAD CUMPLE NORMA"),
                    Center(
                        child: Container(
                      color: Color(0xFF8AB5CF),
                      height: 30,
                      width: 300,
                      child: DropdownButton<String>(
                        value: dropdownValueNivelTurbiedad,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Color(0xFF8AB5CF),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValueNivelTurbiedad = newValue!;
                          });
                        },
                        items: <String>['TURBIEDAD CUMPLE NORMA', 'SI', 'NO']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )),
                  ],
                ),

                SizedBox(height: 20),
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
                          widget.faseAbastMedicion.comentario.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 25),
                ComentarioGeneral(),
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
                                    "NIVEL_AGUA": nivelAguaController.text,
                                    "NIVEL_AGUA_CUMPLE_NORMA":
                                        dropdownValueNivelAgua,
                                    "NIVEL_CLORO": nivelCloroController.text,
                                    "NIVEL_CLORO_CUMPLE_NORMA":
                                        dropdownValueNivelCloro,
                                    "NIVEL_TURBIEDAD":
                                        nivelTurbiedadController.text,
                                    "NIVEL_TURBIEDAD_CUMPLE_NORMA":
                                        dropdownValueNivelTurbiedad,
                                    "COMENTARIO": comentarioController.text,
                                    "ID_TIPO_STATUS": id_tipo_status
                                  };
                                  widget.faseAbastMedicion.id_tipo_status =
                                      numeroIDstatusMedicion;
                                  widget.callback(numeroIDstatusMedicion);
                                  setState(() {
                                    estadoMedicionenString();
                                  });
                                  essbioP.updateFasesMedicion(
                                      widget.faseAbastMedicion, modificacion);

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
                SizedBox(height: 20)

                //ADJUNTAR IMAGEN
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
