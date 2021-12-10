import "dart:convert";
import 'package:essbio_apk/models/fase_instalacion.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import '../models/mod_wkf_orden_trabajo.dart';

class EssbioProvider with ChangeNotifier {
  EssbioProvider() {
    this.fetchOrdenesTrabajo();
    this.fetchFasesInstalacion();
  }

  final server = "http://10.0.2.2:8000";

  List<OrdenTrabajo> _ordenesTrabajo = [];
  List<OrdenTrabajo> get ordenesTrabajo {
    return [..._ordenesTrabajo];
  }

  List<FaseInstalacion> _fasesInstalacion = [];
  List<FaseInstalacion> get fasesInstalacion {
    return [..._fasesInstalacion];
  }

  validateLogin(String username, String password) async {}

  fetchOrdenesTrabajo() async {
    final url = '${server}/mod_wkf_orden_trabajo/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _ordenesTrabajo = data
          .map<OrdenTrabajo>((json) => OrdenTrabajo.fromJson(json))
          .toList();
    }
  }

  fetchFasesInstalacion() async {
    final url = '${server}/ot_fase_instalacion/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _fasesInstalacion = data
          .map<FaseInstalacion>((json) => FaseInstalacion.fromJson(json))
          .toList();
    }
  }
}
