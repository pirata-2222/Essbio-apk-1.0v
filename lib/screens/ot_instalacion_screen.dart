import 'package:essbio_apk/widgets/timer_widget.dart';
import 'package:essbio_apk/widgets/widgets_essbio.dart';
import 'package:essbio_apk/widgets/workflow_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:essbio_apk/api/api.dart';

const Color estadoActivo = Color(0xFF10988F);
const Color estadoPasivo = Color(0xFF99CBCD);

enum Estado { EnCurso, NoDisponible, Instalado, Pendiente, Empty }

class OtInstalacionScreen extends StatefulWidget {
  const OtInstalacionScreen({Key? key}) : super(key: key);

  @override
  _OtInstalacionScreenState createState() => _OtInstalacionScreenState();
}

class _OtInstalacionScreenState extends State<OtInstalacionScreen> {
  Estado estadoSeleccionado = Estado.Empty;

  @override
  Widget build(BuildContext context) {
    final essbioP = Provider.of<EssbioProvider>(context);
    var tituloOTInstalacion = essbioP.ordenesTrabajo[1].nombre_ot;
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
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WorkflowDesplegado()))),
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
                        tituloOTInstalacion,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 5),
                      Text("Fase 1 -Instalación",
                          style: TextStyle(color: Colors.white)),
                      SizedBox(height: 5),
                      Text("Estado: Pendiente",
                          style: TextStyle(color: Colors.white)),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                //TIEMPO RESTANTE SEGÚN ASIGNADO
                TimerEssbio(),

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
                              estadoSeleccionado = Estado.EnCurso;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: estadoSeleccionado == Estado.EnCurso
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
                              estadoSeleccionado = Estado.NoDisponible;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: estadoSeleccionado == Estado.NoDisponible
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
                              estadoSeleccionado = Estado.Instalado;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: estadoSeleccionado == Estado.Instalado
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
                              estadoSeleccionado = Estado.Pendiente;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: estadoSeleccionado == Estado.Pendiente
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
                ComentarioGeneral(),

                SizedBox(height: 20),
                //ADJUNTAR IMAGEN
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Archivo Adjunto",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800)),
                    Icon(Icons.photo_camera),
                    TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFFDD0009))),
                        onPressed: () {},
                        child: Text(
                          "Tomar Fotografía",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
                SizedBox(height: 20),
                //RÓTULO TK
                RotuloTKField(),
                SizedBox(height: 20),
                GuardarDatosBitacora(),
              ],
            ),
          )),
    );
  }
}
