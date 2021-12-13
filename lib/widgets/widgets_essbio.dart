import 'package:flutter/material.dart';
import 'dart:io';
import 'package:essbio_apk/login_page.dart';
import 'workflow_widget.dart';
import 'package:essbio_apk/theme_library.dart';
import 'package:image_picker/image_picker.dart';

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
              title: Text('Ir a Workflows/OT Pendientes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WorkflowDesplegado()),
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
            title: const Text('Cerrar Sesión'),
            content: const Text(
                '¿Estás seguro de cerrar sesión? Recuerda guardar todos los cambios antes de salir'),
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
        child: const Text('Cerrar Sesión',
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
                              builder: (context) => WorkflowDesplegado()),
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

// ********TOMAR FOTOGRAFIA*********

class TomarFotografia extends StatefulWidget {
  const TomarFotografia({Key? key}) : super(key: key);

  @override
  _TomarFotografiaState createState() => _TomarFotografiaState();
}

class _TomarFotografiaState extends State<TomarFotografia> {
  File? _pickedFile;
  final _picker = ImagePicker();
  Future<void> _takePicture() async {
    final _pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (_pickedImage != null) {
      setState(() {
        _pickedFile == _pickedImage;
      });
    } else {
      print("No se ha seleccionado ninguna imagen");
    }

    // try {
    //   await ImagePicker().pickImage(source: ImageSource.camera);
    //   if (image == null) return;

    //   final imageTemporary = File(image!.path);
    //   setState(() => this.image = imageTemporary);
    // } on PlatformException catch (e) {
    //   print("No se pudo cargar la imagen: $e");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Archivo Adjunto",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
        Container(
            height: 160,
            width: 160,
            child: _pickedFile != null
                ? Image.file(_pickedFile!, fit: BoxFit.cover)
                : Icon(
                    Icons.photo_camera,
                    size: 50,
                  )

            // height: 100,
            // width: 140,
            // child: Icon(
            //   Icons.photo_camera,
            //   size: 40,
            // ),
            ),
        TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFFDD0009))),
            onPressed: () => _takePicture(),
            child: Text(
              "Tomar Fotografía",
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
