import 'package:flutter/material.dart';
import 'package:essbio_apk/theme_library.dart';
import 'timer_widget.dart';
import '../widgets/widgets_essbio.dart';
import 'package:essbio_apk/widgets/ot_pendientes_widget.dart';

class Workflow extends StatefulWidget {
  final String tituloWorkflow;
  const Workflow({Key? key, required this.tituloWorkflow}) : super(key: key);

  @override
  _WorkflowState createState() => _WorkflowState();
}

class _WorkflowState extends State<Workflow> {
  bool isVisible = true;
  bool instalacionIsVisible = true;
  bool abastIsVisible = true;
  bool medicionIsVisible = true;
  bool retiroIsVisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //TITULO PRINCIPAL Y BACK BUTTON

        SizedBox(height: 20),
        //DATOS BÁSICOS OT
        Container(
          color: Color(0xFF0513AA),
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(widget.tituloWorkflow,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.5,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TimerEssbio(),
              SizedBox(height: 5),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WorkflowDesplegado()));
                    });
                  },
                  child: Text("Ver OT Pendientes")),
              SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}

class WorkflowDesplegado extends StatefulWidget {
  const WorkflowDesplegado({Key? key}) : super(key: key);

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
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.chevron_left_outlined,
                          size: 40,
                          color: Colors.white,
                        )),
                  ),
                  Expanded(
                    child: Container(
                      height: 60,
                      color: Color(0xFF248BCB),
                      child: Center(
                          child: Text("CORTE PROGRAMADO VICUÑA MACKENNA",
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
                            tituloOT: "Isidoro Rocha",
                            estadoOT: "En Curso",
                          ),
                          // OtPendienteInstalacion(
                          //     colour: amarilloTiempoCritico,
                          //     tituloOT: "Vicuña esq. Marcel",
                          //     estadoOT: "Pendiente"),
                          // OtPendienteInstalacion(
                          //     colour: verdeTiempoCritico,
                          //     tituloOT: "Palomar Norte",
                          //     estadoOT: "Instalado"),
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
