import 'package:essbio_apk/widgets/timer_widget.dart';
import 'package:essbio_apk/widgets/widgets_essbio.dart';
import 'package:flutter/material.dart';

const Color estadoActivo = Color(0xFF10988F);
const Color estadoPasivo = Color(0xFF99CBCD);

enum EstadoAbast {
  EnCurso,
  NoDisponible,
  EstanqueLlenado,
  CierreAbastecimiento,
  Pendiente,
  Empty
}

class OtPendienteAbast extends StatefulWidget {
  final Color colour;
  final String tituloOT;
  final String estadoOT;

  OtPendienteAbast(
      {Key? key,
      required this.colour,
      required this.tituloOT,
      required this.estadoOT})
      : super(key: key);
  @override
  _OtPendienteAbastState createState() => _OtPendienteAbastState();
}

class _OtPendienteAbastState extends State<OtPendienteAbast> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => OtAbastScreen())),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.colour,
          ),
          width: 100,
          height: 150,
          child: Column(
            children: [
              SizedBox(height: 5),
              Icon(Icons.file_copy, color: Colors.white, size: 50),
              SizedBox(height: 5),
              Center(
                child: Text(
                  widget.tituloOT,
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
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.estadoOT,
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

class OtAbastScreen extends StatefulWidget {
  OtAbastScreen({Key? key}) : super(key: key);

  @override
  _OtAbastScreenState createState() => _OtAbastScreenState();
}

class _OtAbastScreenState extends State<OtAbastScreen> {
  EstadoAbast estadoSeleccionado = EstadoAbast.Empty;
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
                      Text("Rocha Esq Tocornal",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                      SizedBox(height: 5),
                      Text("Fase 2 - Abastecimiento",
                          style: TextStyle(color: Colors.white)),
                      SizedBox(height: 5),
                      Text("Estado: Cierre de Abastecimiento",
                          style: TextStyle(color: Colors.white)),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                //TIEMPO RESTANTE SEGÚN ASIGNADO
                TimerEssbio(widget.),

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
                              estadoSeleccionado = EstadoAbast.EnCurso;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: estadoSeleccionado == EstadoAbast.EnCurso
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
                              estadoSeleccionado = EstadoAbast.NoDisponible;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color:
                                  estadoSeleccionado == EstadoAbast.NoDisponible
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
                              estadoSeleccionado = EstadoAbast.EstanqueLlenado;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: estadoSeleccionado ==
                                      EstadoAbast.EstanqueLlenado
                                  ? estadoActivo
                                  : estadoPasivo,
                            ),
                            margin: EdgeInsets.only(left: 10, right: 5),
                            height: 35,
                            width: 180,
                            child: Center(
                              child: Text(
                                "Estanque Llenado",
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              estadoSeleccionado =
                                  EstadoAbast.CierreAbastecimiento;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: estadoSeleccionado ==
                                      EstadoAbast.CierreAbastecimiento
                                  ? estadoActivo
                                  : estadoPasivo,
                            ),
                            margin: EdgeInsets.only(left: 5, right: 10),
                            height: 35,
                            width: 180,
                            child: Center(
                              child: Text(
                                "Cierre de Abastecimiento",
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        setState(() {
                          estadoSeleccionado = EstadoAbast.Pendiente;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: estadoSeleccionado == EstadoAbast.Pendiente
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
                ComentarioGeneral(),
                SizedBox(height: 20),
                //ADJUNTAR IMAGEN
                SizedBox(height: 20),
                GuardarDatosBitacora(),
              ],
            ),
          )),
    );
  }
}
