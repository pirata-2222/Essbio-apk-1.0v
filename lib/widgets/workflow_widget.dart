import 'package:essbio_apk/models/fase_abast_medicion.dart';
import 'package:essbio_apk/models/fase_abastecimiento.dart';
import 'package:essbio_apk/models/fase_instalacion.dart';
import 'package:essbio_apk/models/fase_retiro.dart';
import 'package:flutter/material.dart';
import 'package:essbio_apk/theme_library.dart';
import 'timer_widget.dart';
import '../widgets/widgets_essbio.dart';
import 'package:provider/provider.dart';
import 'package:essbio_apk/api/api.dart';
import 'package:essbio_apk/screens/ot_instalacion_screen.dart';
import 'package:essbio_apk/screens/ot_abast_screen.dart';
import 'package:essbio_apk/screens/ot_medicion_screen.dart';
import 'package:essbio_apk/screens/ot_retiro_screen.dart';

class WorkflowDesplegado extends StatefulWidget {
  List<FaseInstalacion> instalacionUsuario;
  List<FaseAbastMedicion> medicionUsuario;
  List<FaseAbastecimiento> abastecimientoUsuario;
  List<FaseRetiro> retiroUsuario;

  WorkflowDesplegado(
      {Key? key,
      required this.instalacionUsuario,
      required this.abastecimientoUsuario,
      required this.medicionUsuario,
      required this.retiroUsuario})
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

  @override
  Widget build(BuildContext context) {
    final essbioP = Provider.of<EssbioProvider>(context);

    // for (var i = 0; i < cantidadTituloOT; i++) {
    //   var tituloOTInstalacion = essbioP.ordenesTrabajo[i].nombre_ot;
    // }
    // ;

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
                    SizedBox(height: 5),
                    TimerEssbio(),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OtPendienteInstalacion(
                            colour: rojoTiempoCritico,
                            tituloOT: essbioP.ordenesTrabajo[1].nombre_ot,
                            estadoOT: "En Curso",
                          ),
                          OtPendienteInstalacion(
                              colour: verdeTiempoCritico,
                              tituloOT: essbioP.ordenesTrabajo[2].nombre_ot,
                              estadoOT: "Finalizado")
                        ],
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OtPendienteAbast(
                            colour: amarilloTiempoCritico,
                            tituloOT: "Rocha esq Tocornal",
                            estadoOT: "Cierre Abast",
                          ),
                        ],
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
                                    backgroundColor: MaterialStateProperty.all(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OtPendienteMedicion(
                              colour: naranjaTiempoCritico,
                              tituloOT: "Amunategui JJVV",
                              estadoOT: "Pendiente"),
                          // OtPendienteMedicion(
                          //   colour: naranjaTiempoCritico,
                          //   tituloOT: "Las Higueras",
                          //   estadoOT: "No Disponible",
                          // ),
                          // OtPendienteMedicion(
                          //   colour: verdeTiempoCritico,
                          //   tituloOT: "Alfozívar esq Tocornal",
                          //   estadoOT: "Medido",
                          // )
                        ],
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
                                    backgroundColor: MaterialStateProperty.all(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OtPendienteRetiro(
                              colour: rojoTiempoCritico,
                              tituloOT: "Salas/Zamorano",
                              estadoOT: "Pendiente")
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    Center(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFF10988F))),
                          onPressed: () {},
                          child: Text("Limpiar OT Finalizadas")),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
