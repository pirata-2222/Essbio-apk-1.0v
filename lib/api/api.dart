import "dart:convert";
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import '../models/mod_wkf_orden_trabajo.dart';

class EssbioProvider with ChangeNotifier {
  EssbioProvider() {
    this.fetchTask();
  }

  List<OrdenTrabajo> _ordenesTrabajo = [];

  List<OrdenTrabajo> get ordenesTrabajo {
    return [..._ordenesTrabajo];
  }

  final server = "http://10.0.2.2:8000";

  validateLogin(String username, String password) async {}

  fetchTask() async {
    final url = '${server}/mod_wkf_orden_trabajo/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _ordenesTrabajo = data
          .map<OrdenTrabajo>((json) => OrdenTrabajo.fromJson(json))
          .toList();
    }
  }

  void updateOrden(OrdenTrabajo ordenTrabajo) async {
    await http.put(Uri.parse('${server}/mod_wkf/'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(ordenTrabajo));
  }

  void updateOrdenName(String name, String id) async {
    final url = '${server}/mod_wkf/${id}/?format=json';
    await http.delete(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"NOMBRE_OT": name}));
    await http.post(Uri.parse('http://10.0.2.2:8000/mod_wkf/'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"NOMBRE_OT": name}));
  }
}
