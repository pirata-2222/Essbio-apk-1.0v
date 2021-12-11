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
            height: screenSize*2/3,
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
                    margin: EdgeInsets.only(top: 20, bottom:10), child: Text("Contraseña")),
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
<<<<<<< HEAD
                SizedBox(height: 40),
                ElevatedButton(
                    onPressed: () async {
                      await essbioP.validateLogin(
                          usernameController.text, passwordController.text);
                      print(usernameController.text + passwordController.text);
                      if (await essbioP.validateLogin(
                          usernameController.text, passwordController.text)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkflowDesplegado(),
                          ),
                        );
                      }
                    },
                    child: Text("Entrar"))
=======
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      onPressed: () {
                        if (essbioP.validateLogin(
                            usernameController.text, passwordController.text)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtPendientesScreen(),
                            ),
                          );
                        }
                      },
                      child: Text("Entrar")),
                )
>>>>>>> 7b2166e936574b06449a278f30a9bfdb1544bbb1
              ],
            )),
      ),
    );
  }
}
