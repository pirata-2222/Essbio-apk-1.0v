import 'package:flutter/material.dart';
import 'screens/ot_pendientes_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
      final essbioP = Provider.of<EssbioProvider>(context);
      essbioP.fetchUsuarios();
      print(essbioP.usuarios);
    }

    final essbioP = Provider.of<EssbioProvider>(context);
    print(essbioP.usuarios);

    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("ESSBIO APK"),
      ),
      body: SingleChildScrollView(
        child: Container(
            height: 500,
            color: Colors.white,
            margin: EdgeInsets.only(top: 30, left: 35, right: 35, bottom: 80),
            child: Column(
              children: [
                SizedBox(height: 15),
                Image.asset('images/logo-essbio.jpg'),
                SizedBox(height: 40),
                Text(
                  "Nombre de Usuario",
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 7.5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Usuario',
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text("Contraseña"),
                SizedBox(height: 7.5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contraseña',
                    ),
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtPendientesScreen(),
                        ),
                      );
                    },
                    child: Text("Entrar"))
              ],
            )),
      ),
    );
  }
}
