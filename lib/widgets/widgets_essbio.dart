import 'package:essbio_apk/login_page.dart';
import 'package:essbio_apk/screens/ot_pendientes_screen.dart';
import 'package:essbio_apk/theme_library.dart';
import 'package:flutter/material.dart';
import 'package:essbio_apk/screens/ot_retiro_screen.dart';
import 'package:essbio_apk/screens/ot_medicion_screen.dart';
import 'package:essbio_apk/screens/ot_abast_screen.dart';
import 'package:essbio_apk/screens/ot_instalacion_screen.dart';
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

//************** DRAWER *****************

class EssbioDrawer extends StatefulWidget {
  @override
  _EssbioDrawerState createState() => _EssbioDrawerState();
}

class _EssbioDrawerState extends State<EssbioDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Image.asset('images/logo-essbio.jpg'),
          ),
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListTile(
              tileColor: Color(0xFF10988F),
              title: Text('Ir a Workflows/Eventos Actuales',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OtPendientesScreen()),
              ),
            ),
          ),
          SizedBox(height: 100),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: CerrarSesionFunction(),
          ),
        ],
      ),
    );
  }
}

// WIDGET DESPLEGABLES ETAPA MEDICI??N

// *****************************************************

class DropdownButtonMedicion1 extends StatefulWidget {
  @override
  State<DropdownButtonMedicion1> createState() =>
      _DropdownButtonMedicionState1();
}

class _DropdownButtonMedicionState1 extends State<DropdownButtonMedicion1> {
  String dropdownValue = 'NIVEL DE AGUA CUMPLE NORMA';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF8AB5CF),
      height: 30,
      width: 300,
      child: DropdownButton<String>(
        value: dropdownValue,
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        underline: Container(
          height: 2,
          color: Color(0xFF8AB5CF),
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>[
          'NIVEL DE AGUA CUMPLE NORMA',
          'NIVEL DE AGUA CUMPLE NORMA : SI',
          'NIVEL DE AGUA CUMPLE NORMA : NO'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

// ******************************************************

class DropdownButtonMedicion2 extends StatefulWidget {
  @override
  State<DropdownButtonMedicion2> createState() =>
      _DropdownButtonMedicionState2();
}

class _DropdownButtonMedicionState2 extends State<DropdownButtonMedicion2> {
  String dropdownValue = 'NIVEL CLORO CUMPLE NORMA';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF8AB5CF),
      height: 30,
      width: 300,
      child: DropdownButton<String>(
        value: dropdownValue,
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        underline: Container(
          height: 2,
          color: Color(0xFF8AB5CF),
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>[
          'NIVEL CLORO CUMPLE NORMA',
          'NIVEL CLORO CUMPLE NORMA : SI',
          'NIVEL CLORO CUMPLE NORMA : NO'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

// ******************************************************

class DropdownButtonMedicion3 extends StatefulWidget {
  @override
  State<DropdownButtonMedicion3> createState() =>
      _DropdownButtonMedicionState3();
}

class _DropdownButtonMedicionState3 extends State<DropdownButtonMedicion3> {
  String dropdownValue = 'TURBIEDAD CUMPLE NORMA';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF8AB5CF),
      height: 30,
      width: 300,
      child: DropdownButton<String>(
        value: dropdownValue,
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        underline: Container(
          height: 2,
          color: Color(0xFF8AB5CF),
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>[
          'TURBIEDAD CUMPLE NORMA',
          'TURBIEDAD CUMPLE NORMA : SI',
          'TURBIEDAD CUMPLE NORMA : NO'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

// ****************************************

class ComentarioGeneral extends StatefulWidget {
  @override
  _ComentarioGeneralState createState() => _ComentarioGeneralState();
}

class _ComentarioGeneralState extends State<ComentarioGeneral> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("Comentario:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
      Center(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Escribe tu comentario'),
          ),
        ),
      ),
    ]);
  }
}

// ****************************************

class RotuloTKField extends StatefulWidget {
  @override
  _RotuloTKFieldState createState() => _RotuloTKFieldState();
}

class _RotuloTKFieldState extends State<RotuloTKField> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("R??tulo TK:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
      Center(
        child: Container(
          color: Colors.white,
          height: 30,
          margin: EdgeInsets.symmetric(horizontal: 25),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    ]);
  }
}

// ****************************************

class GuardarDatosBitacora extends StatefulWidget {
  @override
  _GuardarDatosBitacoraState createState() => _GuardarDatosBitacoraState();
}

class _GuardarDatosBitacoraState extends State<GuardarDatosBitacora> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Los campos marcados con * son obligatorios"),
        SizedBox(height: 10),
        BotonGuardar(),
        SizedBox(height: 20),
      ],
    );
  }
}

// ****************************************

class MedicionTextField extends StatefulWidget {
  @override
  _MedicionTextFieldState createState() => _MedicionTextFieldState();
}

class _MedicionTextFieldState extends State<MedicionTextField> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Color(0xFF8AB5CF),
        height: 30,
        width: 300,
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}

// **********BOTON CERRAR SESION**************

class CerrarSesionFunction extends StatelessWidget {
  const CerrarSesionFunction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      color: rojoEssbio,
      child: TextButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Cerrar Sesi??n'),
            content: const Text(
                '??Est??s seguro de cerrar sesi??n? Recuerda guardar todos los cambios antes de salir'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                ),
                child: const Text('OK'),
              ),
            ],
          ),
        ),
        child: const Text('Cerrar Sesi??n',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

// **********BOTON GUARDAR**************

class BotonGuardar extends StatelessWidget {
  const BotonGuardar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      color: azulPrimarioEssbio,
      child: TextButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Guardar Cambios Datos OT'),
            content: const Text(
                'Has realizado modificaciones en los campos. Confirma para guardar los cambios'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Cambios Guardados'),
                    content: const Text(
                        'Los campos han sido actualizados satisfactoriamente'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtPendientesScreen()),
                        ),
                        child: const Text('Volver al Workflow'),
                      ),
                    ],
                  ),
                ),
                child: const Text('Confirmar'),
              ),
            ],
          ),
        ),
        child: const Text('Guardar cambios',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
