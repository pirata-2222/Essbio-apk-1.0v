import 'package:essbio_apk/api/api.dart';
import 'package:essbio_apk/models/fase_retiro.dart';
import 'package:essbio_apk/theme_library.dart';
import 'package:essbio_apk/widgets/mapa.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets_essbio.dart';
import 'package:essbio_apk/widgets/timer_widget.dart';
import 'package:intl/intl.dart';

const Color estadoActivo = Color(0xFF10988F);
const Color estadoPasivo = Color(0xFF99CBCD);

class OtPendienteRetiro extends StatefulWidget {
  final FaseRetiro faseRetiro;
  OtPendienteRetiro({Key? key, required this.faseRetiro}) : super(key: key);
  @override
  _OtPendienteRetiroState createState() => _OtPendienteRetiroState();
}

class _OtPendienteRetiroState extends State<OtPendienteRetiro> {
  Color colorBordeRetiro() {
    var dataTipoEvento = widget.faseRetiro.tipo_evento.toString();
    Color colorTipoEventoRetiro;
    switch (dataTipoEvento) {
      case "Emergencia":
        colorTipoEventoRetiro = colorEstadoEmergencia;
        break;
      case "Crisis":
        colorTipoEventoRetiro = colorEstadoCrisis;
        break;
      default:
        colorTipoEventoRetiro = Colors.grey;
    }
    return colorTipoEventoRetiro;
  }

  Color colorOTretiro() {
    int daysBetween(DateTime from, DateTime to) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      return (to.difference(from).inDays).round();
    }

    var fechaInicio = widget.faseRetiro.fecha_inicio;
    var fechainicioFormatoDate = DateFormat("yyyy-MM-dd").parse(fechaInicio);
    var fechaTermino = widget.faseRetiro.fecha_termino;
    var fechaTerminoFormatoDate = DateFormat("yyyy-MM-dd").parse(fechaTermino);
    var fechaActual = DateTime.now();
    var eventosFuturosTiempo = daysBetween(fechaActual, fechainicioFormatoDate);
    var tiempoRestanteRetiro =
        daysBetween(fechaActual, fechaTerminoFormatoDate);

    Color colorTiempoRestanteRetiro = Colors.grey;

    if (tiempoRestanteRetiro > 0 && eventosFuturosTiempo < 0) {
      colorTiempoRestanteRetiro = colorEventoEnCurso;
    }
    if (tiempoRestanteRetiro <= 0 && eventosFuturosTiempo < 0) {
      colorTiempoRestanteRetiro = colorEventoAtrasado;
    }
    if (eventosFuturosTiempo > 0) {
      colorTiempoRestanteRetiro = colorEventoFuturo;
    }
    return colorTiempoRestanteRetiro;
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

  callback(int newStatus) {
    setState(() {
      print(newStatus);
      widget.faseRetiro.id_tipo_status = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtRetiroScreen(
                  faseRetiro: widget.faseRetiro, callback: callback))),
      child: Container(
          margin: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            border: Border.all(color: colorBordeRetiro(), width: 5.0),
            borderRadius: BorderRadius.circular(10),
            color: colorOTretiro(),
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
                  widget.faseRetiro.nombre_corte,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  widget.faseRetiro.nombre_ot,
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
                      estadoRetiroenString(),
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
                          widget.faseRetiro.ods,
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

class OtRetiroScreen extends StatefulWidget {
  final FaseRetiro faseRetiro;
  final Function(int) callback;
  OtRetiroScreen({Key? key, required this.faseRetiro, required this.callback})
      : super(key: key);

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
  var currentStatus;
  String estadoActualString = " ";

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

  int numeroIDstatusRetiro = 0;
  TextEditingController comentarioRetiroController = TextEditingController();
  TextEditingController numeroEstanqueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    comentarioRetiroController.text = widget.faseRetiro.comentario;
    numeroEstanqueController.text = widget.faseRetiro.numero_estanque;
    final essbioP = Provider.of<EssbioProvider>(context);

    int id_tipo_status = widget.faseRetiro.id_tipo_status;
    double screenWidth = MediaQuery.of(context).size.width;
    String estadoSeleccionado = " ";

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
                Text("Cambio de Estado",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                SizedBox(height: 5),
                estadosOT(widget.faseRetiro.statuses, estadoRetiroenString()),

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
                // SizedBox(height: 20),

                // //RÓTULO TK
                // RotuloTKField(),
                // SizedBox(height: 20),
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
                //           widget.faseRetiro.comentario.toString(),
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
                      height: 50.0,
                      width: screenWidth * 0.8,
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: comentarioRetiroController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Escribe tu comentario'),
                      ),
                    ),
                  ),
                ]),
                // SizedBox(height: 20),
                // Column(children: [
                //   Text("Último Rótulo TK Registrado:",
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
                //       child: Center(
                //         child: Text(
                //           widget.faseRetiro.numero_estanque(),
                //           style: TextStyle(color: Colors.white),
                //         ),
                //       ),
                //     ),
                //   ),
                // ]),
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
                        controller: numeroEstanqueController,
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
                                  Map<String, dynamic> modificacion = {
                                    "COMENTARIO":
                                        comentarioRetiroController.text,
                                    "NUMERO_ESTANQUE":
                                        numeroEstanqueController.text,
                                    "ID_TIPO_STATUS": currentStatus
                                  };
                                  // TODO: revisar correcto funcionamiento del callback
                                  // widget.callback(currentStatus);
                                  setState(() {
                                    estadoRetiroenString();
                                  });
                                  essbioP.updateFasesRetiro(
                                      widget.faseRetiro, modificacion);

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

                //GUARDAR DATOS
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
                  .firstWhere((entry) => entry.value == 141)
                  .key;
            }
            if (estadoActualString == "RETIRADO") {
              currentStatus = statuses.entries
                  .firstWhere((entry) => entry.value == 142)
                  .key;
            }
            if (estadoActualString == "NO DISPONIBLE (R)") {
              currentStatus = statuses.entries
                  .firstWhere((entry) => entry.value == 143)
                  .key;
            }

            // print("tipo_status[status]: " + tipo_status[status].toString());
            // print("tipo_status: " + tipo_status.toString());
            // print("status: " + status.toString());
            // print("statuses: " + statuses.toString());
            // print("statuses.keys: " + statuses.keys.toString());
            // print("statuses.values: " + statuses.values.toString());
            // print("estadoSeleccionado: " + estadoSeleccionado);
            // print("current status: " + currentStatus.toString());
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 4,
              color: widget.faseRetiro.id_tipo_status == status
                  ? estadoActivo
                  : estadoSeleccionado == tipo_status[status]
                      ? estadoActivo
                      : estadoPasivo,
            ),
            borderRadius: BorderRadius.circular(15),
            color: widget.faseRetiro.id_tipo_status == status
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
