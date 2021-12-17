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
                        if (snapshot.data! < 13) {
                          return Column(
                            children: [
                              Text("Cargando desde base de datos"),
                              CircularProgressIndicator(),
                            ],
                          );
                        } else {
                          return ElevatedButton(
                              onPressed: () {
                                if (essbioP.validateLogin(
                                    usernameController.text,
                                    passwordController.text)[0]) {
                                  List fasesUsuario = essbioP.getFasesUsuario(
                                      essbioP.ordenesTrabajo,
                                      essbioP.fasesInstalacion,
                                      essbioP.fasesAbastMedicion,
                                      essbioP.fasesAbastecimiento,
                                      essbioP.fasesRetiro,
                                      essbioP.fases,
                                      essbioP.status,
                                      4
                                      /*essbioP.validateLogin(
                            usernameController.text, passwordController.text)[1].idusuario*/
                                      );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WorkflowDesplegado(
                                          instalacionUsuario: fasesUsuario[0],
                                          medicionUsuario: fasesUsuario[1],
                                          abastecimientoUsuario:
                                              fasesUsuario[2],
                                          retiroUsuario: fasesUsuario[3],
                                          usuario: essbioP.validateLogin(
                                              usernameController.text,
                                              passwordController.text)[1]),
                                    ),
                                  );
                                }
                              },
                              child: Text("Entrar"));
                        }
                      } else {
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
}
