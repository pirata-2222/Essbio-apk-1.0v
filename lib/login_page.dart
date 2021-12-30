import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:essbio_apk/widgets/workflow_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api/api.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final essbioP = Provider.of<EssbioProvider>(context);
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final screenSize = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: screenSize * 2 / 3,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(child: Image.asset('images/logo-essbio.jpg')),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "Nombre de Usuario",
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Usuario',
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    child: Text("Contraseña")),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contraseña',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: StreamBuilder(
                    stream: essbioP.loginCounterController.stream,
                    builder: (context, AsyncSnapshot<int> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data! < 15) {
                          return Column(
                            children: [
                              Text("Cargando desde base de datos"),
                              CircularProgressIndicator(),
                            ],
                          );
                        } else {
                          essbioP.loginCounterController.close();
                          return ElevatedButton(
                              onPressed: () {
                                if (essbioP.validateLogin(
                                    usernameController.text,
                                    passwordController.text)[0]) {
                                  List fasesUsuario = essbioP.getFasesUsuario(
                                    ordenesTrabajo: essbioP.ordenesTrabajo,
                                    fasesInstalacion: essbioP.fasesInstalacion,
                                    fasesAbastecimiento:
                                        essbioP.fasesAbastecimiento,
                                    fasesMedicion: essbioP.fasesAbastMedicion,
                                    fasesRetiro: essbioP.fasesRetiro,
                                    eventos: essbioP.dataEventos,
                                    fases: essbioP.fases,
                                    id_usuario: 4,
                                    //essbioP.validateLogin(
                                    //usernameController.text, generateMd5(passwordController.text))[1].idusuario
                                    mensajes: essbioP.mensajes,
                                    procesos: essbioP.procesos,
                                    sectores: essbioP.dataTKSectores,
                                    statuses: essbioP.status,
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WorkflowDesplegado(
                                        instalacionUsuario: fasesUsuario[0],
                                        medicionUsuario: fasesUsuario[1],
                                        abastecimientoUsuario: fasesUsuario[2],
                                        retiroUsuario: fasesUsuario[3],
                                        usuario: essbioP.validateLogin(
                                            usernameController.text,
                                            passwordController.text)[1],
                                        mensajesEssbio: essbioP.mensajes,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Text("Entrar"));
                        }
                      } else {
                        print("Snapshot no recupera data");
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
