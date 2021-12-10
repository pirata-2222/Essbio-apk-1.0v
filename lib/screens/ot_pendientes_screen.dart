import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/widgets_essbio.dart';
import 'package:essbio_apk/widgets/workflow_widget.dart';

class OtPendientesScreen extends StatefulWidget {
  @override
  _OtPendientesScreenState createState() => _OtPendientesScreenState();
}

class _OtPendientesScreenState extends State<OtPendientesScreen> {
  bool isVisible = true;
  bool instalacionIsVisible = true;
  bool abastIsVisible = true;
  bool medicionIsVisible = true;
  bool retiroIsVisible = true;

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
              //TITULO PRINCIPAL Y BACK BUTTON
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 70,
                    color: Color(0xFF248BCB),
                    child: InkWell(
                        child: Icon(
                      Icons.home,
                      size: 40,
                      color: Colors.white,
                    )),
                  ),
                  Expanded(
                    child: Container(
                      height: 60,
                      color: Color(0xFF248BCB),
                      child: Center(
                          child: Text("WORKFLOW/EVENTOS ACTUALES",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold))),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              //DATOS BÁSICOS OT

              Workflow(tituloWorkflow: "Corte Programado Vicuña Mackenna"),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
