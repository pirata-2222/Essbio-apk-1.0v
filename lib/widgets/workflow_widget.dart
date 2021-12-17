import 'package:essbio_apk/models/fase_abast_medicion.dart';
import 'package:essbio_apk/models/fase_abastecimiento.dart';
import 'package:essbio_apk/models/fase_instalacion.dart';
import 'package:essbio_apk/models/fase_retiro.dart';
import 'package:essbio_apk/models/xygo_usuario.dart';
import 'package:flutter/material.dart';
import 'package:essbio_apk/theme_library.dart';
import '../widgets/widgets_essbio.dart';
import 'package:provider/provider.dart';
import 'package:essbio_apk/api/api.dart';
import 'package:essbio_apk/screens/ot_instalacion_screen.dart';
import 'package:essbio_apk/screens/ot_abast_screen.dart';
import 'package:essbio_apk/screens/ot_medicion_screen.dart';
import 'package:essbio_apk/screens/ot_retiro_screen.dart';

class WorkflowDesplegado extends StatefulWidget {
  final List<FaseInstalacion> instalacionUsuario;
  final List<FaseAbastMedicion> medicionUsuario;
  final List<FaseAbastecimiento> abastecimientoUsuario;
  final List<FaseRetiro> retiroUsuario;
  final Usuario usuario;

  WorkflowDesplegado(
      {Key? key,
      required this.instalacionUsuario,
      required this.abastecimientoUsuario,
      required this.medicionUsuario,
      required this.retiroUsuario,
      required this.usuario})
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
    // var IDUsuarioLogueado = essbioP.usuario;
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(DateTime.now().toIso8601String().substring(0, 19) + "Z");
          },
        ),
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
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.instalacionUsuario.length,
                            itemBuilder: (BuildContext context, int index) {
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
                        height: 200,
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
                      child: Container(
                        height: 200,
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
                      child: Container(
                        height: 200,
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
