import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:essbio_apk/api/api.dart';
import 'package:essbio_apk/theme_library.dart';
import 'package:essbio_apk/models/fase_abastecimiento.dart';

// **********BOTON GUARDAR**************

class BotonGuardarAbastecimiento extends StatelessWidget {
  final FaseAbastecimiento faseAbastecimiento;
  final Map<String, dynamic> modificacion;
  BotonGuardarAbastecimiento(
      {Key? key, required this.faseAbastecimiento, required this.modificacion})
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
          print(faseAbastecimiento.id);
          print(faseAbastecimiento.id_ot);
          essbioP.updateFasesAbastecimiento(faseAbastecimiento, modificacion);
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

class GuardarDatosBitacoraAbastecimiento extends StatefulWidget {
  final FaseAbastecimiento faseAbastecimiento;
  final Map<String, dynamic> modificacion;
  GuardarDatosBitacoraAbastecimiento({Key? key, required this.faseAbastecimiento, required this.modificacion})
      : super(key: key);
  @override
  _GuardarDatosBitacoraAbastecimientoState createState() => _GuardarDatosBitacoraAbastecimientoState();
}

class _GuardarDatosBitacoraAbastecimientoState extends State<GuardarDatosBitacoraAbastecimiento> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Los campos marcados con * son obligatorios"),
        SizedBox(height: 10),
        BotonGuardarAbastecimiento(faseAbastecimiento: widget.faseAbastecimiento, modificacion: widget.modificacion,),
        SizedBox(height: 20),
      ],
    );
  }
}
