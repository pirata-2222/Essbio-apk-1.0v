import 'package:essbio_apk/theme_library.dart';
import 'package:essbio_apk/widgets/widgets_essbio.dart';
import 'package:flutter/material.dart';

class MensajeScreen extends StatefulWidget {
  const MensajeScreen({Key? key}) : super(key: key);

  @override
  _MensajeScreenState createState() => _MensajeScreenState();
}

class _MensajeScreenState extends State<MensajeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFE5E5E5),
        appBarTheme: AppBarTheme(
          color: Color(0xFF3C3C3C),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("ESSBIO APP"),
        ),
        drawer: EssbioDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 70,
                    color: azulPrimarioEssbio,
                    child: InkWell(
                        child: Icon(
                          Icons.chevron_left_outlined,
                          size: 40,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ),
                  Expanded(
                    child: Container(
                      height: 60,
                      color: azulPrimarioEssbio,
                      child: Center(
                          child: Text("MENSAJES",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold))),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CardMensaje(
                colorMensaje: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              CardMensaje(
                colorMensaje: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              CardMensaje(
                colorMensaje: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              CardMensaje(
                colorMensaje: celesteEssbio,
              ),
              SizedBox(
                height: 10,
              ),
              CardMensaje(
                colorMensaje: celesteEssbio,
              ),
              SizedBox(
                height: 10,
              ),
              CardMensaje(
                colorMensaje: celesteEssbio,
              ),
              SizedBox(
                height: 10,
              ),
              CardMensaje(
                colorMensaje: celesteEssbio,
              ),
              SizedBox(
                height: 10,
              ),
              CardMensaje(
                colorMensaje: celesteEssbio,
              ),
              SizedBox(
                height: 10,
              ),
              CardMensaje(
                colorMensaje: celesteEssbio,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ***********************************************************

class CardMensaje extends StatefulWidget {
  Color colorMensaje;
  CardMensaje({Key? key, required this.colorMensaje}) : super(key: key);

  @override
  _CardMensajeState createState() => _CardMensajeState();
}

class _CardMensajeState extends State<CardMensaje> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CardMensajeDesplegado()));
      },
      child: Container(
        decoration: BoxDecoration(
            color: widget.colorMensaje,
            borderRadius: BorderRadius.circular(10)),
        height: 150,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Fecha: dd-MM-YYYY",
                    style: TextStyle(color: Colors.white)),
                Text("Hora de Envío: 12:00:00",
                    style: TextStyle(color: Colors.white))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "Remitente: ",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "ACA COLOCAR MENSAJERO",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: Container(
              margin: EdgeInsets.only(left: 25, top: 10),
              child: Text(
                  "Mensaje con Contenido en donde se entregará la información",
                  style: TextStyle(color: Colors.white)),
            ))
          ],
        ),
      ),
    );
  }
}

class CardMensajeDesplegado extends StatefulWidget {
  const CardMensajeDesplegado({Key? key}) : super(key: key);

  @override
  _CardMensajeDesplegadoState createState() => _CardMensajeDesplegadoState();
}

class _CardMensajeDesplegadoState extends State<CardMensajeDesplegado> {
  @override
  TextEditingController comentarioMensajeController = TextEditingController();
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFE5E5E5),
          appBarTheme: AppBarTheme(
            color: Color(0xFF3C3C3C),
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("ESSBIO APP"),
          ),
          body: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: 70,
                      color: azulPrimarioEssbio,
                      child: InkWell(
                          child: Icon(
                            Icons.chevron_left_outlined,
                            size: 40,
                            color: Colors.white,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          }),
                    ),
                    Expanded(
                      child: Container(
                        height: 60,
                        color: azulPrimarioEssbio,
                        child: Center(
                            child: Text("MENSAJE OT",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.5,
                                    fontWeight: FontWeight.bold))),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Remitente:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Persona que emite el mensaje"),
                SizedBox(height: 20),
                Text(
                  "Fecha de Envío",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("dd-MM-YYYY  -    12:00:00"),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Mensaje:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                      "aenean et tortor at risus viverra adipiscing at in tellus integer feugiat scelerisque varius morbi enim nunc faucibus a pellentesque sit amet porttitor eget dolor morbi non arcu risus"),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: azulPrimarioEssbio,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Confirmar Lectura",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    height: 60.0,
                    width: MediaQuery.of(context).size.width * 0.9,
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: comentarioMensajeController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Aquí puedes escribir tu respuesta'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: azulPrimarioEssbio,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Responder",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
