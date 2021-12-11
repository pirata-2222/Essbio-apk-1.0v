import 'package:flutter/material.dart';
import 'package:essbio_apk/screens/ot_instalacion_screen.dart';
import 'package:essbio_apk/screens/ot_abast_screen.dart';
import 'package:essbio_apk/screens/ot_medicion_screen.dart';
import 'package:essbio_apk/screens/ot_retiro_screen.dart';
import 'package:essbio_apk/api/api.dart';
import 'package:provider/provider.dart';

// *******OT PENDIENTES*********

class OtPendienteInstalacion extends StatefulWidget {
  final Color colour;
  final String tituloOT;
  final String estadoOT;
  OtPendienteInstalacion(
      {Key? key,
      required this.colour,
      required this.tituloOT,
      required this.estadoOT})
      : super(key: key);

  @override
  _OtPendienteInstalacionState createState() => _OtPendienteInstalacionState();
}

class _OtPendienteInstalacionState extends State<OtPendienteInstalacion> {
  @override
  Widget build(BuildContext context) {
    final essbioP = Provider.of<EssbioProvider>(context);
    var tituloOTInstalacion = essbioP.ordenesTrabajo[1].nombre_ot;
    return InkWell(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => OtInstalacionScreen())),
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
                          color: Colors.white, fontWeight: FontWeight.bold),
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

// ***********OT PENDIENTE 2**************

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

// ***********OT PENDIENTE 3**************

class OtPendienteMedicion extends StatefulWidget {
  final Color colour;
  final String tituloOT;
  final String estadoOT;
  OtPendienteMedicion(
      {Key? key,
      required this.colour,
      required this.tituloOT,
      required this.estadoOT})
      : super(key: key);

  @override
  _OtPendienteMedicionState createState() => _OtPendienteMedicionState();
}

class _OtPendienteMedicionState extends State<OtPendienteMedicion> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => OtMedicionScreen())),
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
                          color: Colors.white, fontWeight: FontWeight.bold),
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

// ***********OT PENDIENTE 4**************

class OtPendienteRetiro extends StatefulWidget {
  final Color colour;
  final String tituloOT;
  final String estadoOT;
  OtPendienteRetiro(
      {Key? key,
      required this.colour,
      required this.tituloOT,
      required this.estadoOT})
      : super(key: key);
  @override
  _OtPendienteRetiroState createState() => _OtPendienteRetiroState();
}

class _OtPendienteRetiroState extends State<OtPendienteRetiro> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => OtRetiroScreen())),
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
                          color: Colors.white, fontWeight: FontWeight.bold),
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
