import 'dart:ffi';

import 'package:essbio_apk/models/fase_abast_medicion.dart';
import 'package:essbio_apk/models/fase_abastecimiento.dart';
import 'package:essbio_apk/models/fase_instalacion.dart';
import 'package:essbio_apk/models/fase_retiro.dart';
import 'package:essbio_apk/models/mod_mensaje.dart';
import 'package:essbio_apk/models/xygo_usuario.dart';
import 'package:essbio_apk/screens/mensajes_screen.dart';
import 'package:flutter/material.dart';
import 'package:essbio_apk/theme_library.dart';
import '../widgets/widgets_essbio.dart';
import 'package:essbio_apk/screens/ot_instalacion_screen.dart';
import 'package:essbio_apk/screens/ot_abast_screen.dart';
import 'package:essbio_apk/screens/ot_medicion_screen.dart';
import 'package:essbio_apk/screens/ot_retiro_screen.dart';
import 'package:badges/badges.dart';
import 'package:essbio_apk/api/streams.dart';

class WorkflowDesplegado extends StatefulWidget {
  final List<FaseInstalacion> instalacionUsuario;
  final List<FaseAbastMedicion> medicionUsuario;
  final List<FaseAbastecimiento> abastecimientoUsuario;
  final List<FaseRetiro> retiroUsuario;
  final Usuario usuario;
  final List<Mensaje> mensajesEssbio;

  WorkflowDesplegado(
      {Key? key,
      required this.instalacionUsuario,
      required this.abastecimientoUsuario,
      required this.medicionUsuario,
      required this.retiroUsuario,
      required this.usuario,
      required this.mensajesEssbio})
      : super(key: key);

  @override
  _WorkflowDesplegadoState createState() => _WorkflowDesplegadoState();
}

class _WorkflowDesplegadoState extends State<WorkflowDesplegado> {
  bool isVisible = true;
  bool instalacionIsVisible = true;
  bool abastIsVisible = true;
  bool medicionIsVisible = true;
  bool retiroIsVisible = true;
  final stream = Streams();

  callback() {
    setState(() {
      stream.modificador = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    int numeroMensajesLeidosEssbio() {
      int contadorMensaje = 0 + stream.modificador;
      var mensajesLength = widget.mensajesEssbio.length;
      for (var i = 0; i < mensajesLength; i++) {
        if (widget.mensajesEssbio[i].estado.toString() == "1" ||
            widget.mensajesEssbio[i].estado.toString() == "2") {
          contadorMensaje++;
        }
        if (contadorMensaje < 0) {
          contadorMensaje = 0;
        }
      }

      return contadorMensaje;
    }

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: MaterialApp(
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
                          onTap: () {},
                          child: Icon(
                            Icons.home,
                            size: 40,
                            color: Colors.white,
                          )),
                    ),
                    Expanded(
                      child: Container(
                        height: 60,
                        color: Color(0xFF248BCB),
                        child: Center(
                            child: Text("WORFLOWS/OT PENDIENTES",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.5,
                                    fontWeight: FontWeight.bold))),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                //DATOS BÁSICOS OT

                Container(
                  child: Column(
                    children: [
                      numeroMensajesLeidosEssbio() != 0
                          ? Badge(
                              position:
                                  BadgePosition.topEnd(top: -10, end: -15),
                              badgeColor: Colors.red,
                              badgeContent: Container(
                                width: 30,
                                height: 30,
                                alignment: Alignment.center,
                                child: Text(
                                  numeroMensajesLeidosEssbio().toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MensajeScreen(
                                              mensajesLista:
                                                  widget.mensajesEssbio,
                                              callback: callback)));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                      color: azulPrimarioEssbio,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Icon(Icons.message,
                                            size: 50, color: Colors.white),
                                      ),
                                      Center(
                                        child: Text(
                                          "Ver Mensajes",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MensajeScreen(
                                              mensajesLista:
                                                  widget.mensajesEssbio,
                                              callback: callback,
                                            )));
                              },
                              child: Container(
                                padding: EdgeInsets.all(20),
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                    color: azulPrimarioEssbio,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Icon(Icons.message,
                                          size: 50, color: Colors.white),
                                    ),
                                    Center(
                                      child: Text(
                                        "Ver Mensajes",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                      SizedBox(
                        height: 20,
                      ),
                      //ROWS OT PENDIENTES INSTALACION
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 40,
                            color: celesteEssbio,
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Fase 1 - Instalación       "),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                azulPrimarioEssbio)),
                                    onPressed: () {
                                      setState(() {
                                        instalacionIsVisible =
                                            !instalacionIsVisible;
                                      });
                                    },
                                    child: Text("Ver/Ocultar"))
                              ],
                            )),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      Visibility(
                        visible: instalacionIsVisible,
                        child: Container(
                          height: 260,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.instalacionUsuario.length,
                              itemBuilder: (BuildContext context, int index) {
                                widget.instalacionUsuario.sort((a, b) =>
                                    b.nombre_corte.compareTo(a.nombre_corte));

                                return OtPendienteInstalacion(
                                    faseInstalacion:
                                        widget.instalacionUsuario[index]);
                              }),
                        ),
                      ),
                      SizedBox(height: 10),
                      //ROWS OT PENDIENTES ABASTECIMIENTO
                      Container(
                        width: double.infinity,
                        height: 40,
                        color: celesteEssbio,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Fase 2 - Abastecimiento"),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        azulPrimarioEssbio)),
                                onPressed: () {
                                  setState(() {
                                    abastIsVisible = !abastIsVisible;
                                  });
                                },
                                child: Text("Ver/Ocultar"))
                          ],
                        )),
                      ),
                      SizedBox(height: 10),
                      Visibility(
                        visible: abastIsVisible,
                        child: Container(
                          height: 260,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.abastecimientoUsuario.length,
                              itemBuilder: (BuildContext context, int index) {
                                return OtPendienteAbast(
                                  faseAbastecimiento:
                                      widget.abastecimientoUsuario[index],
                                );
                              }),
                        ),
                      ),
                      SizedBox(height: 10),
                      //ROWS OT PENDIENTES MEDICION
                      InkWell(
                        onTap: () {
                          setState(() {
                            medicionIsVisible = !medicionIsVisible;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          color: celesteEssbio,
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Fase 3 - Medición          "),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              azulPrimarioEssbio)),
                                  onPressed: () {
                                    setState(() {
                                      medicionIsVisible = !medicionIsVisible;
                                    });
                                  },
                                  child: Text("Ver/Ocultar"))
                            ],
                          )),
                        ),
                      ),
                      SizedBox(height: 10),
                      Visibility(
                        visible: medicionIsVisible,
                        child: Container(
                          height: 260,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.medicionUsuario.length,
                              itemBuilder: (BuildContext context, int index) {
                                return OtPendienteMedicion(
                                    faseAbastMedicion:
                                        widget.medicionUsuario[index]);
                              }),
                        ),
                      ),
                      SizedBox(height: 10),
                      //ROWS OT PENDIENTES RETIRO
                      InkWell(
                        onTap: () {
                          setState(() {
                            retiroIsVisible = !retiroIsVisible;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          color: celesteEssbio,
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Fase 4 - Retiro                "),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              azulPrimarioEssbio)),
                                  onPressed: () {
                                    setState(() {
                                      retiroIsVisible = !retiroIsVisible;
                                    });
                                  },
                                  child: Text("Ver/Ocultar"))
                            ],
                          )),
                        ),
                      ),
                      SizedBox(height: 10),
                      Visibility(
                        visible: retiroIsVisible,
                        child: Container(
                          height: 260,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.retiroUsuario.length,
                              itemBuilder: (BuildContext context, int index) {
                                return OtPendienteRetiro(
                                    faseRetiro: widget.retiroUsuario[index]);
                              }),
                        ),
                      ),
                      SizedBox(height: 20),

                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "Significado Colores OT según Tiempo Restante"),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: colorEventoEnCurso),
                              width: 180,
                              height: 40,
                              child: Center(child: Text("Evento en Curso")),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: colorEventoAtrasado),
                              width: 180,
                              height: 40,
                              child: Center(child: Text("Evento Atrasado")),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: colorEventoFuturo),
                              width: 180,
                              height: 40,
                              child: Center(child: Text("Evento Futuro")),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "Significado Colores Bordes según Tipo de Evento"),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 5.0),
                                  borderRadius: BorderRadius.circular(10)),
                              width: 180,
                              height: 40,
                              child: Center(child: Text("Sin Definir")),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 180,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: colorEstadoEmergencia, width: 5.0),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(child: Text("Emergencia")),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 180,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: colorEstadoCrisis, width: 5.0),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(child: Text("Crisis")),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
