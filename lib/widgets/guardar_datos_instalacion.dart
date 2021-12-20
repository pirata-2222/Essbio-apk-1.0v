import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:essbio_apk/api/api.dart';
import 'package:essbio_apk/theme_library.dart';
import 'package:essbio_apk/models/fase_instalacion.dart';

// **********BOTON GUARDAR**************

class BotonGuardarInstalacion extends StatelessWidget {
  final FaseInstalacion faseInstalacion;
  final Map<String, dynamic> modificacion;
  BotonGuardarInstalacion(
      {Key? key, required this.faseInstalacion, required this.modificacion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final essbioP = Provider.of<EssbioProvider>(context);
    return Container(
      height: 50,
      width: 150,
      color: azulPrimarioEssbio,
      child: TextButton(
        onPressed: () {
          print(faseInstalacion.id);
          print(faseInstalacion.id_ot);
          essbioP.updateFasesInstalacion(faseInstalacion, modificacion);
          /*showDialog<String>(
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
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Volver al Workflow'),
                        ),
                      ],
                    ),
                  ),
                  child: const Text('Confirmar'),
                ),
              ],
            ),
          );*/
        },
        child: const Text('Guardar cambios',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

// ****************************************

class GuardarDatosBitacoraInstalacion extends StatefulWidget {
  final FaseInstalacion faseInstalacion;
  final Map<String, dynamic> modificacion;
  GuardarDatosBitacoraInstalacion({Key? key, required this.faseInstalacion, required this.modificacion})
      : super(key: key);
  @override
  _GuardarDatosBitacoraInstalacionState createState() => _GuardarDatosBitacoraInstalacionState();
}

class _GuardarDatosBitacoraInstalacionState extends State<GuardarDatosBitacoraInstalacion> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Los campos marcados con * son obligatorios"),
        SizedBox(height: 10),
        BotonGuardarInstalacion(faseInstalacion: widget.faseInstalacion, modificacion: widget.modificacion,),
        SizedBox(height: 20),
      ],
    );
  }
}
