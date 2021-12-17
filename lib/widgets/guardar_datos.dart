import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:essbio_apk/api/api.dart';
import 'package:essbio_apk/theme_library.dart';
import 'package:essbio_apk/models/fase_instalacion.dart';

// **********BOTON GUARDAR**************

class BotonGuardar extends StatelessWidget {
  final FaseInstalacion faseInstalacion;
  BotonGuardar({Key? key, required this.faseInstalacion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final essbioP = Provider.of<EssbioProvider>(context);
    Map<String, dynamic> modificacion = {
      "ID_TIPO_STATUS": 112,
      "COMENTARIO_INSTALACION": "Test update",
      "ARCHIVO_ADJUNTO": "",
      "ROTULO_TK": "",
    };
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

class GuardarDatosBitacora extends StatefulWidget {
  FaseInstalacion faseInstalacion;
  GuardarDatosBitacora({Key? key, required this.faseInstalacion})
      : super(key: key);
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
        BotonGuardar(faseInstalacion: widget.faseInstalacion),
        SizedBox(height: 20),
      ],
    );
  }
}
