import 'package:essbio_apk/models/mod_mensaje.dart';
import 'package:essbio_apk/theme_library.dart';
import 'package:essbio_apk/widgets/widgets_essbio.dart';
import 'package:flutter/material.dart';

class MensajeScreen extends StatefulWidget {
  final List<Mensaje> mensajesLista;
  const MensajeScreen({Key? key, required this.mensajesLista})
      : super(key: key);

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
        body: Column(
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
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.mensajesLista.length,
                itemBuilder: (BuildContext context, int index) {
                  return CardMensaje(
                      mensajeEssbio: widget.mensajesLista[index]);
                })
          ],
        ),
      ),
    );
  }
}

// ***********************************************************

class CardMensaje extends StatefulWidget {
  final Mensaje mensajeEssbio;
  CardMensaje({Key? key, required this.mensajeEssbio}) : super(key: key);

  @override
  _CardMensajeState createState() => _CardMensajeState();
}

class _CardMensajeState extends State<CardMensaje> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CardMensajeDesplegado(
                    mensajeEssbio: widget.mensajeEssbio)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(10)),
        height: 150,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Fecha de Envío:", style: TextStyle(color: Colors.white)),
                Text(widget.mensajeEssbio.fecha_creacion,
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
                    widget.mensajeEssbio.id_usuario_creacion,
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
              child: Text(widget.mensajeEssbio.mensaje,
                  style: TextStyle(color: Colors.white)),
            ))
          ],
        ),
      ),
    );
  }
}

class CardMensajeDesplegado extends StatefulWidget {
  final Mensaje mensajeEssbio;
  const CardMensajeDesplegado({Key? key, required this.mensajeEssbio})
      : super(key: key);

  @override
  _CardMensajeDesplegadoState createState() => _CardMensajeDesplegadoState();
}

class _CardMensajeDesplegadoState extends State<CardMensajeDesplegado> {
  TextEditingController comentarioMensajeController = TextEditingController();
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
                Text(widget.mensajeEssbio.id_usuario_creacion),
                SizedBox(height: 20),
                Text(
                  "Fecha de Envío",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(widget.mensajeEssbio.fecha_creacion),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Mensaje:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text(widget.mensajeEssbio.mensaje),
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
