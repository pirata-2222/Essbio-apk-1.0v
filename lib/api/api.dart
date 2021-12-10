import "dart:convert";
import 'package:essbio_apk/models/evento_camion.dart';
import 'package:essbio_apk/models/evento_contratista.dart';
import 'package:essbio_apk/models/evento_data_tk_sector.dart';
import 'package:essbio_apk/models/fase_abast_medicion.dart';
import 'package:essbio_apk/models/fase_abastecimiento.dart';
import 'package:essbio_apk/models/fase_instalacion.dart';
import 'package:essbio_apk/models/fase_retiro.dart';
import 'package:essbio_apk/models/mod_wkf_tipo_modulo.dart';
import 'package:essbio_apk/models/xygo_usuario.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import '../models/mod_wkf_orden_trabajo.dart';

class EssbioProvider with ChangeNotifier {
  EssbioProvider() {
    this.fetchOrdenesTrabajo();
    this.fetchFasesInstalacion();
    this.fetchCamiones();
    this.fetchContratistas();
    this.fetchDataTKSectores();
    this.fetchFasesAbastMedicion();
    this.fetchFasesAbastecimiento();
    this.fetchFasesRetiro();
    this.fetchTiposModulo();
    this.fetchUsuarios();
  }

  final server = "http://10.0.2.2:8000";

  //Mod_WKF
  List<OrdenTrabajo> _ordenesTrabajo = [];
  List<OrdenTrabajo> get ordenesTrabajo {
    return [..._ordenesTrabajo];
  }

  List<TipoModulo> _tiposModulo = [];
  List<TipoModulo> get tipoModulo {
    return [..._tiposModulo];
  }

  //Eventos
  List<Camion> _camiones = [];
  List<Camion> get camiones {
    return [..._camiones];
  }

  List<Contratista> _contratistas = [];
  List<Contratista> get contratistas {
    return [..._contratistas];
  }

  List<DataTKSector> _dataTKSectores = [];
  List<DataTKSector> get dataTKSectores {
    return [..._dataTKSectores];
  }

  //Fases
  List<FaseInstalacion> _fasesInstalacion = [];
  List<FaseInstalacion> get fasesInstalacion {
    return [..._fasesInstalacion];
  }

  List<FaseAbastMedicion> _fasesAbastMedicion = [];
  List<FaseAbastMedicion> get fasesAbastMedicion {
    return [..._fasesAbastMedicion];
  }

  List<FaseAbastecimiento> _fasesAbastecimiento = [];
  List<FaseAbastecimiento> get fasesAbastecimiento {
    return [..._fasesAbastecimiento];
  }

  List<FaseRetiro> _fasesRetiro = [];
  List<FaseRetiro> get fasesRetiro {
    return [..._fasesRetiro];
  }

  List<Usuario> _usuarios = [];
  List<Usuario> get usuarios {
    return [..._usuarios];
  }

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

  fetchTiposModulo() async {
    final url = '${server}/mod_wkf_tipo_modulo/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _tiposModulo =
          data.map<TipoModulo>((json) => TipoModulo.fromJson(json)).toList();
    }
  }

  fetchCamiones() async {
    final url = '${server}/evento_camion/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _camiones = data.map<Camion>((json) => Camion.fromJson(json)).toList();
    }
  }

  fetchContratistas() async {
    final url = '${server}/evento_contratista/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _contratistas =
          data.map<Contratista>((json) => Contratista.fromJson(json)).toList();
    }
  }

  fetchDataTKSectores() async {
    final url = '${server}/evento_data_tk_sector/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _dataTKSectores = data
          .map<DataTKSector>((json) => DataTKSector.fromJson(json))
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

  fetchFasesAbastMedicion() async {
    final url = '${server}/ot_fase_abast_medicion/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _fasesAbastMedicion = data
          .map<FaseAbastMedicion>((json) => FaseAbastMedicion.fromJson(json))
          .toList();
    }
  }

  fetchFasesAbastecimiento() async {
    final url = '${server}/ot_fase_abastecimiento/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _fasesAbastecimiento = data
          .map<FaseAbastecimiento>((json) => FaseAbastecimiento.fromJson(json))
          .toList();
    }
  }

  fetchFasesRetiro() async {
    final url = '${server}/ot_fase_retiro/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _fasesRetiro =
          data.map<FaseRetiro>((json) => FaseRetiro.fromJson(json)).toList();
    }
  }

  fetchUsuarios() async {
    final url = '${server}/xygo_usuario/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _usuarios = data.map<Usuario>((json) => Usuario.fromJson(json)).toList();
    }
  }

  bool validateLogin(String username, String password) {
    bool loginState = false;
    for (var usuario in usuarios) {
      if (usuario.nomusuario == username && usuario.clave == password) {
        loginState = true;
      } else {
        loginState = false;
      }
    }
    return loginState;
  }
}
