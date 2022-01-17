import 'package:essbio_apk/models/mod_mensaje.dart';
import 'package:essbio_apk/theme_library.dart';
import 'package:essbio_apk/widgets/widgets_essbio.dart';
import 'package:flutter/material.dart';
import 'package:essbio_apk/api/api.dart';
import 'package:provider/provider.dart';

class MensajeScreen extends StatefulWidget {
  final List<Mensaje> mensajesLista;
  final Function callback;
  const MensajeScreen(
      {Key? key, required this.mensajesLista, required this.callback})
      : super(key: key);

  @override
  _MensajeScreenState createState() => _MensajeScreenState();
}

class _MensajeScreenState extends State<MensajeScreen> {
  @override
  Widget build(BuildContext context) {
    final essbioP = Provider.of<EssbioProvider>(context);

    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFE5E5E5),
        appBarTheme: AppBarTheme(
          color: Color(0xFF3C3C3C),
        ),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
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
            Container(
              height: 60,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text("Mensaje Leído: "),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: celesteEssbio,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text("Mensaje No Leído: "),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: estadoPasivo,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: widget.mensajesLista.length,
                  itemBuilder: (BuildContext context, int index) {
                    int reverseIndex = widget.mensajesLista.length - 1 - index;
                    widget.mensajesLista
                        .sort((a, b) => b.estado.compareTo(a.estado));
                    widget.mensajesLista
                        .sort((a, b) => a.prioridad.compareTo(b.prioridad));

                    return CardMensaje(
                      mensajeEssbio: widget.mensajesLista[reverseIndex],
                      callback: widget.callback,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

// ***********************************************************

class CardMensaje extends StatefulWidget {
  final Mensaje mensajeEssbio;
  final Function callback;
  CardMensaje({Key? key, required this.mensajeEssbio, required this.callback})
      : super(key: key);

  @override
  _CardMensajeState createState() => _CardMensajeState();
}

class _CardMensajeState extends State<CardMensaje> {
  @override
  Widget build(BuildContext context) {
    Color colorMensajes() {
      var mensajeLeidoClick = widget.mensajeEssbio.estado.toString();

      Color colorMensajeOT = Colors.grey;
      if (mensajeLeidoClick == "3" ||
          mensajeLeidoClick == "4" ||
          mensajeLeidoClick == "5") {
        colorMensajeOT = celesteEssbio;
      } else {
        colorMensajeOT = verdeTiempoCritico;
      }

      return colorMensajeOT;
    }

    var fechaYHoraMensajeString =
        widget.mensajeEssbio.fecha_creacion.toString();
    var splitFechayHora = fechaYHoraMensajeString.split("T");
    var fechaMensajeString = splitFechayHora[0];
    // var split2 = splitFechayHora[1].split("Z");
    // var horaMensajeString = split2[0];

    final essbioP = Provider.of<EssbioProvider>(context);

    String nombreRemitenteMensaje() {
      var usuariosLength = essbioP.usuarios.length;
      var usuarioCreacionString =
          widget.mensajeEssbio.id_usuario_creacion.toString();
      String nombreRemitente = " ";
      for (var i = 0; i < usuariosLength; i++) {
        var usuarioIDString = essbioP.usuarios[i].idusuario.toString();
        var nombreUsuarioString = essbioP.usuarios[i].nomusuario;
        var nombreUsuario = essbioP.usuarios[i].nombres;
        // var apellidoUsuario = essbioP.usuarios[i].apellidos;
        if (usuarioCreacionString == usuarioIDString) {
          nombreRemitente =
              nombreUsuario + " " + "(" + nombreUsuarioString + ")";
        }
      }
      return nombreRemitente;
    }

    return InkWell(
      onTap: () {
        if (widget.mensajeEssbio.estado.toString() == "1" ||
            widget.mensajeEssbio.estado.toString() == "2") {
          setState(() {
            Map<String, dynamic> modificacion = {"ESTADO": 3};
            essbioP.updateMensajeLeidoClick(widget.mensajeEssbio, modificacion);
            colorMensajes();
          });
          print("Debería cambiar estado");
          widget.callback();
        }

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CardMensajeDesplegado(
                    mensajeEssbio: widget.mensajeEssbio)));
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, right: 5),
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
            color: colorMensajes(),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Prioridad: " + widget.mensajeEssbio.prioridad.toString(),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Fecha de Envío: " + fechaMensajeString,
                style: TextStyle(color: Colors.white)),
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enviado por: ",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  nombreRemitenteMensaje(),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: Container(
              margin: EdgeInsets.only(left: 25, top: 10),
              child: Text(widget.mensajeEssbio.mensaje.toString(),
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
  String ultimaRespuesta = " ";
  @override
  Widget build(BuildContext context) {
    String confirmacionLecturaString() {
      var confirmarLectura = widget.mensajeEssbio.confirmacion.toString();

      String confirmacionString = " ";
      if (confirmarLectura == "S") {
        confirmacionString = "Mensaje Confirmado";
      } else {
        confirmacionString = "Aún no se confirma lectura del mensaje";
      }

      return confirmacionString;
    }

    var fechaYHoraMensajeString =
        widget.mensajeEssbio.fecha_creacion.toString();
    var splitFechayHora = fechaYHoraMensajeString.split("T");
    var fechaMensajeString = splitFechayHora[0];

    final essbioP = Provider.of<EssbioProvider>(context);

    String nombreRemitenteMensaje() {
      var usuariosLength = essbioP.usuarios.length;
      var usuarioCreacionString =
          widget.mensajeEssbio.id_usuario_creacion.toString();
      String nombreRemitente = " ";
      for (var i = 0; i < usuariosLength; i++) {
        var usuarioIDString = essbioP.usuarios[i].idusuario.toString();
        var nombreUsuarioString = essbioP.usuarios[i].nomusuario;
        var nombreUsuario = essbioP.usuarios[i].nombres;
        // var apellidoUsuario = essbioP.usuarios[i].apellidos;
        if (usuarioCreacionString == usuarioIDString) {
          nombreRemitente =
              nombreUsuario + " " + "(" + nombreUsuarioString + ")";
        }
      }
      return nombreRemitente;
    }

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
          body: SingleChildScrollView(
            child: Container(
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
                    "Prioridad:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(widget.mensajeEssbio.prioridad.toString()),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Enviado por:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(nombreRemitenteMensaje()),
                  SizedBox(height: 20),
                  Text(
                    "Fecha de Envío",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(fechaMensajeString),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: azulPrimarioEssbio,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Column(
                        children: [
                          Container(
                            // TODO: ver el margen con medidas relativas para responsividad
                            margin: EdgeInsets.only(right: 250),
                            child: Text(
                              "Mensaje:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              widget.mensajeEssbio.mensaje.toString(),
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  confirmacionLecturaString() == "Mensaje Confirmado"
                      ? Container(
                          decoration: BoxDecoration(
                              color: rojoEssbio,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                confirmacionLecturaString(),
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      : InkWell(
                          onTap: () {
                            setState(() {
                              Map<String, dynamic> modificacion = {
                                "CONFIRMACION": "S",
                              };
                              essbioP.updateConfirmacionLectura(
                                  widget.mensajeEssbio, modificacion);
                              print(
                                  "Se debería actualizar tabla con lectura confirmada");
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: azulPrimarioEssbio,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Confirmar Mensaje",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                  SizedBox(
                    height: 10,
                  ),
                  widget.mensajeEssbio.mensaje_respuesta.toString() != null
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              color: verdeTiempoCritico,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Column(
                            children: [
                              Container(
                                  // TODO: ver el margen con medidas relativas para responsividad
                                  margin: EdgeInsets.only(right: 200),
                                  child: Text(
                                    "Última Respuesta:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    textAlign: TextAlign.start,
                                  )),
                              SizedBox(height: 10),
                              Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                  ultimaRespuesta = widget
                                      .mensajeEssbio.mensaje_respuesta
                                      .toString(),
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ))
                      : Text(" "),
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
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Enviar Respuesta'),
                                    content: const Text(
                                        'Estás a punto de enviar una respuesta al mensaje enviado. Por favor confirma para enviar'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Map<String, dynamic> modificacion =
                                                {
                                              "MENSAJE_RESPUESTA":
                                                  comentarioMensajeController
                                                      .text,
                                            };
                                            essbioP.updateMensaje(
                                                widget.mensajeEssbio,
                                                modificacion);
                                            print(
                                                "Se debería actualizar tabla con mensaje respuesta");
                                            Navigator.pop(context, 'Cancel');
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                          title: const Text(
                                                              "Respuesta enviada"),
                                                          content: const Text(
                                                              "Tu respuesta ha sido enviada con éxito al emisor del mensaje, los cambios deberían verse reflejados en menos de 1 minuto en tu app"),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context,
                                                                      'Cancel'),
                                                              child: const Text(
                                                                  'OK'),
                                                            ),
                                                          ],
                                                        ));
                                          },
                                          child: const Text('Confirmar')),
                                    ]));
                      },
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
          ),
        ));
  }
}
