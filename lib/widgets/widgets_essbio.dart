import 'package:essbio_apk/api/api.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:essbio_apk/login_page.dart';
import 'package:provider/provider.dart';
import 'workflow_widget.dart';
import 'package:essbio_apk/theme_library.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

//************** DRAWER *****************

class EssbioDrawer extends StatefulWidget {
  @override
  _EssbioDrawerState createState() => _EssbioDrawerState();
}

class _EssbioDrawerState extends State<EssbioDrawer> {
  @override
  Widget build(BuildContext context) {
    final essbioP = Provider.of<EssbioProvider>(context);
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
              title: Text('Ir a Workflows/OT Pendientes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Funcionalidad en Desarrollo',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: const Text(
                        'Esta funcionalidad está en su última fase de pruebas. Se podrá utilizar desde el 27/12.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
                // List fasesUsuario = essbioP.getFasesUsuario(
                //     essbioP.ordenesTrabajo,
                //     essbioP.fasesInstalacion,
                //     essbioP.fasesAbastMedicion,
                //     essbioP.fasesAbastecimiento,
                //     essbioP.fasesRetiro,
                //     essbioP.fases,
                //     essbioP.status,
                //     essbioP.dataTKSectores,
                //     essbioP.procesos,
                //     essbioP.dataEventos,
                //     essbioP.usuario!.idusuario);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => WorkflowDesplegado(
                //           instalacionUsuario: fasesUsuario[0],
                //           medicionUsuario: fasesUsuario[1],
                //           abastecimientoUsuario: fasesUsuario[2],
                //           retiroUsuario: fasesUsuario[3],
                //           usuario: essbioP.usuario!)),
                // );
              },
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

// WIDGET DESPLEGABLES ETAPA MEDICIÓN

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
  TextEditingController comentarioController = TextEditingController();
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
            controller: comentarioController,
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
      Text("Rótulo TK:",
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
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Funcionalidad en Desarrollo'),
              content: const Text(
                  'Esta funcionalidad está en su última fase de pruebas. Se podrá utilizar desde el 27/12.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
        child: const Text('Cerrar Sesión',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

// ********TOMAR FOTOGRAFIA*********

class TomarFotografia extends StatefulWidget {
  const TomarFotografia({Key? key}) : super(key: key);

  @override
  _TomarFotografiaState createState() => _TomarFotografiaState();
}

class _TomarFotografiaState extends State<TomarFotografia> {
  File? _imagen;
  final picker = ImagePicker();

  Future selImagen(op) async {
    var pickedFile;
    if (op == 1) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      if (pickedFile != null) {
        _imagen = File(pickedFile.path);
      } else {
        print("No se ha seleccionado ninguna foto");
      }
    });
    Navigator.of(context).pop();
  }

  opciones(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                        onTap: () {
                          selImagen(1);
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1, color: Colors.grey),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Tomar una fotografía",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Icon(
                                Icons.camera_alt,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          selImagen(2);
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Seleccionar de Galería",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Icon(
                                Icons.image,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(color: Colors.red),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Cancelar",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFFDD0009))),
            onPressed: () => opciones(context),
            child: Text(
              "Tomar/Adjuntar Fotografía",
              style: TextStyle(color: Colors.white),
            )),
        _imagen == null
            ? Icon(
                Icons.image_outlined,
                color: Colors.grey,
              )
            : Image.file(_imagen!)
      ]),
    );
  }
}
