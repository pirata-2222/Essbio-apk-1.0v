import 'dart:async';
import "dart:convert";
import 'package:crypto/crypto.dart';
import 'package:essbio_apk/models/evento_camion.dart';
import 'package:essbio_apk/models/evento_contratista.dart';
import 'package:essbio_apk/models/evento_data_eventos.dart';
import 'package:essbio_apk/models/evento_data_tk_sector.dart';
import 'package:essbio_apk/models/fase_abast_medicion.dart';
import 'package:essbio_apk/models/fase_abastecimiento.dart';
import 'package:essbio_apk/models/fase_instalacion.dart';
import 'package:essbio_apk/models/fase_retiro.dart';
import 'package:essbio_apk/models/mod_mensaje.dart';
import 'package:essbio_apk/models/mod_wkf_fase.dart';
import 'package:essbio_apk/models/mod_wkf_proceso.dart';
import 'package:essbio_apk/models/mod_wkf_status.dart';
import 'package:essbio_apk/models/mod_wkf_tipo_modulo.dart';
import 'package:essbio_apk/models/xygo_usuario.dart';
import 'package:geolocator/geolocator.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import '../models/mod_wkf_orden_trabajo.dart';

class EssbioProvider with ChangeNotifier {
  EssbioProvider() {
    this.fetchUsuarios();
    this.fetchOrdenesTrabajo();
    this.fetchStatus();
    this.fetchFases();
    this.fetchCamiones();
    this.fetchContratistas();
    this.fetchDataTKSectores();
    this.fetchTiposModulo();
    this.fetchFasesInstalacion();
    this.fetchFasesAbastMedicion();
    this.fetchFasesAbastecimiento();
    this.fetchFasesRetiro();
    this.fetchDataEventos();
    this.fetchProcesos();
    this.fetchMensajes();
  }
  // final server = "http://10.0.2.2:8000";
  final server = "https://djangorestessbio.herokuapp.com";

  int loginCounter = 0;
  StreamController<int> loginCounterController = StreamController.broadcast();

  //Mod_WKF
  List<OrdenTrabajo> _ordenesTrabajo = [];
  List<OrdenTrabajo> get ordenesTrabajo {
    return [..._ordenesTrabajo];
  }

  List<TipoModulo> _tiposModulo = [];
  List<TipoModulo> get tipoModulo {
    return [..._tiposModulo];
  }

  List<Status> _status = [];
  List<Status> get status {
    return [..._status];
  }

  List<Fase> _fases = [];
  List<Fase> get fases {
    return [..._fases];
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

  List<DataEventos> _dataEventos = [];
  List<DataEventos> get dataEventos {
    return [..._dataEventos];
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

  //Usuarios
  List<Usuario> _usuarios = [];
  List<Usuario> get usuarios {
    return [..._usuarios];
  }

  List<Proceso> _procesos = [];
  List<Proceso> get procesos {
    return [..._procesos];
  }

  List<Mensaje> _mensajes = [];
  List<Mensaje> get mensajes {
    return [..._mensajes];
  }

  Usuario? _usuario;
  Usuario? get usuario {
    return _usuario;
  }

  //Funciones para solicitud GET

  fetchProcesos() async {
    final url = '${server}/mod_wkf_proceso/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes)) as List;
      _procesos = data.map<Proceso>((json) => Proceso.fromJson(json)).toList();
      print("Procesos obtenidos");
      loginCounter = loginCounter + 1;
      loginCounterController.add(loginCounter);
    }
  }

  fetchOrdenesTrabajo() async {
    final url = '${server}/mod_wkf_orden_trabajo/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes)) as List;
      _ordenesTrabajo = data
          .map<OrdenTrabajo>((json) => OrdenTrabajo.fromJson(json))
          .toList();
      print("Ordenes de trabajo obtenidas");
      loginCounter = loginCounter + 1;
      loginCounterController.add(loginCounter);
    }
  }

  fetchTiposModulo() async {
    final url = '${server}/mod_wkf_tipo_modulo/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes)) as List;
      _tiposModulo =
          data.map<TipoModulo>((json) => TipoModulo.fromJson(json)).toList();
      print("Tipos modulo obtenidos");
      loginCounter = loginCounter + 1;
      loginCounterController.add(loginCounter);
    }
  }

  fetchCamiones() async {
    final url = '${server}/evento_camion/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes)) as List;
      _camiones = data.map<Camion>((json) => Camion.fromJson(json)).toList();
      print("Camiones obtenidos");
      loginCounter = loginCounter + 1;
      loginCounterController.add(loginCounter);
    }
  }

  fetchContratistas() async {
    final url = '${server}/evento_contratista/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes)) as List;
      _contratistas =
          data.map<Contratista>((json) => Contratista.fromJson(json)).toList();
      print("Contratistas obtenidos");
      loginCounter = loginCounter + 1;
      loginCounterController.add(loginCounter);
    }
  }

  fetchDataTKSectores() async {
    final url = '${server}/evento_data_tk_sector/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes)) as List;
      _dataTKSectores = data
          .map<DataTKSector>((json) => DataTKSector.fromJson(json))
          .toList();
      print("Data TK Sectores obtenidos");
      loginCounter = loginCounter + 1;
      loginCounterController.add(loginCounter);
    }
  }

  fetchFasesInstalacion() async {
    final url = '${server}/ot_fase_instalacion/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes)) as List;
      _fasesInstalacion = data
          .map<FaseInstalacion>((json) => FaseInstalacion.fromJson(json))
          .toList();
      print("Fases de instalación obtenidas");
      loginCounter = loginCounter + 1;
      loginCounterController.add(loginCounter);
    }
  }

  fetchFasesAbastMedicion() async {
    final url = '${server}/ot_fase_abast_medicion/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes)) as List;
      _fasesAbastMedicion = data
          .map<FaseAbastMedicion>((json) => FaseAbastMedicion.fromJson(json))
          .toList();
      print("Fases de medición obtenidas");
      loginCounter = loginCounter + 1;
      loginCounterController.add(loginCounter);
    }
  }

  fetchFasesAbastecimiento() async {
    final url = '${server}/ot_fase_abastecimiento/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes)) as List;
      _fasesAbastecimiento = data
          .map<FaseAbastecimiento>((json) => FaseAbastecimiento.fromJson(json))
          .toList();
      print("Fases de abastecimiento obtenidas");
      loginCounter = loginCounter + 1;
      loginCounterController.add(loginCounter);
    }
  }

  fetchFasesRetiro() async {
    final url = '${server}/ot_fase_retiro/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes)) as List;
      _fasesRetiro =
          data.map<FaseRetiro>((json) => FaseRetiro.fromJson(json)).toList();
      print("Fases de retiro obtenidas");
      loginCounter = loginCounter + 1;
      loginCounterController.add(loginCounter);
    }
  }

  fetchUsuarios() async {
    final url = '${server}/xygo_usuarios/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes)) as List;
      _usuarios = data.map<Usuario>((json) => Usuario.fromJson(json)).toList();
      print("Usuarios obtenidos");
      loginCounter = loginCounter + 1;
      loginCounterController.add(loginCounter);
    }
  }

  fetchStatus() async {
    final url = '${server}/mod_wkf_status/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes)) as List;
      _status = data.map<Status>((json) => Status.fromJson(json)).toList();
      print("Status obtenidos");
      loginCounter = loginCounter + 1;
      loginCounterController.add(loginCounter);
    }
  }

  fetchFases() async {
    final url = '${server}/mod_wkf_fase/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes)) as List;
      _fases = data.map<Fase>((json) => Fase.fromJson(json)).toList();
      print("Fases obtenidas");
      loginCounter = loginCounter + 1;
      loginCounterController.add(loginCounter);
    }
  }

  fetchDataEventos() async {
    final url = '${server}/evento_data_eventos/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes)) as List;
      _dataEventos =
          data.map<DataEventos>((json) => DataEventos.fromJson(json)).toList();
      print("Data eventos obtenidas");
      loginCounter = loginCounter + 1;
      loginCounterController.add(loginCounter);
    }
  }

  fetchMensajes() async {
    final url = '${server}/mod_mensaje/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes)) as List;
      _mensajes = data.map<Mensaje>((json) => Mensaje.fromJson(json)).toList();
      print("Mensajes obtenidos");
      loginCounter = loginCounter + 1;
      loginCounterController.add(loginCounter);
    }
  }

  updateMensaje(Mensaje mensaje, Map<String, dynamic> modificacion) async {
    final id = mensaje.id_mensaje;
    final url_mensaje = '${server}/mod_mensaje/$id/?format=json';
    final response = await http.put(Uri.parse(url_mensaje),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "MENSAJE_RESPUESTA": modificacion["MENSAJE_RESPUESTA"] == ""
              ? mensaje.mensaje_respuesta
              : modificacion["MENSAJE_RESPUESTA"],
          "FECHA_MOD_XYGO":
              DateTime.now().toIso8601String().substring(0, 19) + "Z"
        }));
  }

  updateMensajeLeidoClick(
      Mensaje mensaje, Map<String, dynamic> modificacion) async {
    final id = mensaje.id_mensaje;
    final url_mensaje = '${server}/mod_mensaje/$id/?format=json';
    final response = await http.put(Uri.parse(url_mensaje),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "ESTADO": modificacion["ESTADO"] == ""
              ? mensaje.confirmacion
              : modificacion["ESTADO"],
          "FECHA_MOD_XYGO":
              DateTime.now().toIso8601String().substring(0, 19) + "Z"
        }));
  }

  updateConfirmacionLectura(
      Mensaje mensaje, Map<String, dynamic> modificacion) async {
    final id = mensaje.id_mensaje;
    final url_mensaje = '${server}/mod_mensaje/$id/?format=json';
    final response = await http.put(Uri.parse(url_mensaje),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "CONFIRMACION": modificacion["CONFIRMACION"] == ""
              ? mensaje.confirmacion
              : modificacion["CONFIRMACION"],
          "FECHA_MOD_XYGO":
              DateTime.now().toIso8601String().substring(0, 19) + "Z"
        }));
  }

  updateFasesInstalacion(FaseInstalacion faseInstalacion,
      Map<String, dynamic> modificacion) async {
    final id = faseInstalacion.id;
    final url_instalacion = '$server/ot_fase_instalacion/$id/?format=json';
    final response = await http.put(Uri.parse(url_instalacion),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "COMENTARIO_INSTALACION": modificacion["COMENTARIO_INSTALACION"] == ""
              ? faseInstalacion.comentario_instalacion
              : modificacion["COMENTARIO_INSTALACION"],
          "FECHA_MOD_XYGO":
              DateTime.now().toIso8601String().substring(0, 19) + "Z",
          "ROTULO_TK": modificacion["ROTULO_TK"] == ""
              ? faseInstalacion.rotulo_tk
              : modificacion["ROTULO_TK"],
          "ARCHIVO_ADJUNTO": modificacion["ARCHIVO_ADJUNTO"] == ""
              ? faseInstalacion.archivo_adjunto
              : modificacion["ARCHIVO_ADJUNTO"]
        }));

    final url_ots =
        '$server/mod_wkf_orden_trabajo/${faseInstalacion.id_ot}/?format=json';
    final response_status = await http.put(Uri.parse(url_ots),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "ID_STATUS": modificacion["ID_TIPO_STATUS"] == ""
              ? faseInstalacion.id_tipo_status
              : modificacion["ID_TIPO_STATUS"],
          "FECHA_MOD_XYGO":
              DateTime.now().toIso8601String().substring(0, 19) + "Z",
        }));

    if (response.statusCode == 200) {
      print("Actualizada correctamente la fase");
    } else {
      print("Hubo un problema al actualizar la fase");
    }
    if (response_status.statusCode == 200) {
      print("Actualizado correctamente el estado");
    } else {
      print(response_status.body);
      print("Hubo un problema al actualizar el estado");
    }
  }

  updateFasesAbastecimiento(FaseAbastecimiento faseAbastecimiento,
      Map<String, dynamic> modificacion) async {
    final id = faseAbastecimiento.id;
    final url_abastecimiento =
        '$server/ot_fase_abastecimiento/$id/?format=json';
    final response = await http.put(Uri.parse(url_abastecimiento),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "COMENTARIO": modificacion["COMENTARIO"] == ""
              ? faseAbastecimiento.comentario
              : modificacion["COMENTARIO"],
          "FECHA_MOD_XYGO":
              DateTime.now().toIso8601String().substring(0, 19) + "Z",
        }));

    final url_ots =
        '$server/mod_wkf_orden_trabajo/${faseAbastecimiento.id_ot}/?format=json';
    final response_status = await http.put(Uri.parse(url_ots),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "ID_STATUS": modificacion["ID_TIPO_STATUS"] == ""
              ? faseAbastecimiento.id_tipo_status
              : modificacion["ID_TIPO_STATUS"],
          "FECHA_MOD_XYGO":
              DateTime.now().toIso8601String().substring(0, 19) + "Z",
        }));

    if (response.statusCode == 200) {
      print("Abast : Actualizada correctamente la fase");
    } else {
      print("Abast : Hubo un problema al actualizar la fase");
    }
    if (response_status.statusCode == 200) {
      print("Abast : Actualizado correctamente el estado");
    } else {
      print(response_status.body);
      print("Abast : Hubo un problema al actualizar el estado");
    }
  }

  updateFasesMedicion(FaseAbastMedicion faseAbastMedicion,
      Map<String, dynamic> modificacion) async {
    //TODO Mapear respuesta de Sí a S
    final id = faseAbastMedicion.id;
    var agua_norma = "";
    var cloro_norma = "";
    var turbiedad_norma = "";

    if (modificacion["NIVEL_AGUA_CUMPLE_NORMA"] == "SI") {
      agua_norma = "S";
    } else {
      agua_norma = "N";
    }
    if (modificacion["NIVEL_CLORO_CUMPLE_NORMA"] == "SI") {
      cloro_norma = "S";
    } else {
      cloro_norma = "N";
    }
    if (modificacion["NIVEL_TURBIEDAD_CUMPLE_NORMA"] == "SI") {
      turbiedad_norma = "S";
    } else {
      turbiedad_norma = "N";
    }

    final url_medicion = '$server/ot_fase_abast_medicion/$id/?format=json';
    final response = await http.put(Uri.parse(url_medicion),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'NIVEL_AGUA': modificacion['NIVEL_AGUA'] == ""
              ? faseAbastMedicion.nivel_agua
              : modificacion['NIVEL_AGUA'],
          'NIVEL_AGUA_CUMPLE_NORMA':
              modificacion['NIVEL_AGUA_CUMPLE_NORMA'] == ""
                  ? faseAbastMedicion.nivel_agua_cumple_norma
                  : agua_norma,
          'NIVEL_CLORO': modificacion['NIVEL_CLORO'] == ""
              ? faseAbastMedicion.nivel_cloro
              : modificacion['NIVEL_CLORO'],
          'NIVEL_CLORO_CUMPLE_NORMA':
              modificacion['NIVEL_CLORO_CUMPLE_NORMA'] == ""
                  ? faseAbastMedicion.nivel_cloro_cumple_norma
                  : cloro_norma,
          'NIVEL_TURBIEDAD': modificacion['NIVEL_TURBIEDAD'] == ""
              ? faseAbastMedicion.nivel_turbiedad
              : modificacion['NIVEL_AGUA'],
          'NIVEL_TURBIEDAD_CUMPLE_NORMA':
              modificacion['NIVEL_TURBIEDAD_CUMPLE_NORMA'] == ""
                  ? faseAbastMedicion.nivel_turbiedad_cumple_norma
                  : turbiedad_norma,
          "COMENTARIO": modificacion["COMENTARIO"] == ""
              ? faseAbastMedicion.comentario
              : modificacion["COMENTARIO"],
          "FECHA_MOD_XYGO":
              DateTime.now().toIso8601String().substring(0, 19) + "Z",
        }));

    final url_ots =
        '$server/mod_wkf_orden_trabajo/${faseAbastMedicion.id_ot}/?format=json';
    final response_status = await http.put(Uri.parse(url_ots),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "ID_STATUS": modificacion["ID_TIPO_STATUS"] == ""
              ? faseAbastMedicion.id_tipo_status
              : modificacion["ID_TIPO_STATUS"],
          "FECHA_MOD_XYGO":
              DateTime.now().toIso8601String().substring(0, 19) + "Z",
        }));

    if (response.statusCode == 200) {
      print("Abast : Actualizada correctamente la fase");
    } else {
      print("Abast : Hubo un problema al actualizar la fase");
    }
    if (response_status.statusCode == 200) {
      print("Abast : Actualizado correctamente el estado");
    } else {
      print(response_status.body);
      print("Abast : Hubo un problema al actualizar el estado");
    }
  }

  updateFasesRetiro(
      FaseRetiro faseRetiro, Map<String, dynamic> modificacion) async {
    final id = faseRetiro.id;
    final url_retiro = '$server/ot_fase_retiro/$id/?format=json';
    final response = await http.put(Uri.parse(url_retiro),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'NUMERO_ESTANQUE': modificacion['NUMERO_ESTANQUE'] == ""
              ? faseRetiro.numero_estanque
              : modificacion['NUMERO_ESTANQUE'],
          "COMENTARIO": modificacion["COMENTARIO"] == ""
              ? faseRetiro.comentario
              : modificacion["COMENTARIO"],
          "FECHA_MOD_XYGO":
              DateTime.now().toIso8601String().substring(0, 19) + "Z",
        }));

    final url_ots =
        '$server/mod_wkf_orden_trabajo/${faseRetiro.id_ot}/?format=json';
    final response_status = await http.put(Uri.parse(url_ots),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "ID_STATUS": modificacion["ID_TIPO_STATUS"] == ""
              ? faseRetiro.id_tipo_status
              : modificacion["ID_TIPO_STATUS"],
          "FECHA_MOD_XYGO":
              DateTime.now().toIso8601String().substring(0, 19) + "Z",
        }));

    if (response.statusCode == 200) {
      print("Abast : Actualizada correctamente la fase");
    } else {
      print("Abast : Hubo un problema al actualizar la fase");
    }
    if (response_status.statusCode == 200) {
      print("Abast : Actualizado correctamente el estado");
    } else {
      print(response_status.body);
      print("Abast : Hubo un problema al actualizar el estado");
    }
  }

  updateGps(Map<String, dynamic> modificacion) async {
    final url_gps = '$server/cont_gps/?format=json';
    final response = await http.post(Uri.parse(url_gps),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'ID_USUARIO': modificacion['ID_USUARIO'],
          "LATITUD": modificacion["LATITUD"],
          "LONGITUD": modificacion["LONGITUD"],
          "ID_OTS": modificacion["ID_OTS"],
          "FECHA": DateTime.now().toIso8601String().substring(0, 19) + "Z",
        }));

    if (response.statusCode == 200) {
      print("GPS : Actualizada correctamente la ubicación");
    } else {
      print("Abast : Hubo un problema al actualizar la ubicación");
    }
  }

  List getFasesUsuario(
      {required List<OrdenTrabajo> ordenesTrabajo,
      required List<FaseInstalacion> fasesInstalacion,
      required List<FaseAbastMedicion> fasesMedicion,
      required List<FaseAbastecimiento> fasesAbastecimiento,
      required List<FaseRetiro> fasesRetiro,
      required List<Fase> fases,
      required List<Status> statuses,
      required List<DataTKSector> sectores,
      required List<Proceso> procesos,
      required List<DataEventos> eventos,
      required List<Mensaje> mensajes,
      required int id_usuario}) {
    List<FaseInstalacion> instalacionUsuario = [];
    List<FaseInstalacion> instalacionActiva = [];
    List<FaseAbastMedicion> medicionUsuario = [];
    List<FaseAbastMedicion> medicionActiva = [];
    List<FaseAbastecimiento> abastecimientoUsuario = [];
    List<FaseAbastecimiento> abastecimientoActiva = [];
    List<FaseRetiro> retiroUsuario = [];
    List<FaseRetiro> retiroActiva = [];
    List<Mensaje> mensajesUsuario = [];
    List<OrdenTrabajo> ordenesTrabajoUsuario = [];
    List<Status> statusesUsuario = [];
    List<Fase> faseUsuario = [];

    var fasesUsuario = [
      instalacionActiva,
      medicionActiva,
      abastecimientoActiva,
      retiroActiva,
      mensajesUsuario
    ];

    //Filtra las OTs para que sólo muestre las que corresponden al usuario
    for(var orden in ordenesTrabajo){
      for(var instalacion in fasesInstalacion){
        if (orden.id_ot == instalacion.id_ot) {
            instalacion.id_responsable = orden.id_responsable;
            instalacion.nombre_ot = orden.nombre_ot;
        }
        if(instalacion.id_responsable == id_usuario){
          ordenesTrabajoUsuario.add(orden);
          instalacionUsuario.add(instalacion);
        }
        
      }
      for(var medicion in fasesMedicion){
        if (orden.id_ot == medicion.id_ot) {
            medicion.id_responsable = orden.id_responsable;
            medicion.nombre_ot = orden.nombre_ot;
        }
        if(medicion.id_responsable == id_usuario){
          ordenesTrabajoUsuario.add(orden);
          medicionUsuario.add(medicion);
        }
        
      }
      for(var abastecimiento in fasesAbastecimiento){
        if (orden.id_ot == abastecimiento.id_ot) {
            abastecimiento.id_responsable = orden.id_responsable;
            abastecimiento.nombre_ot = orden.nombre_ot;
        }
        if(abastecimiento.id_responsable == id_usuario){
          ordenesTrabajoUsuario.add(orden);
          abastecimientoUsuario.add(abastecimiento);
        }
        
      }
      for(var retiro in fasesRetiro){
        if (orden.id_ot == retiro.id_ot) {
            retiro.id_responsable = orden.id_responsable;
            retiro.nombre_ot = orden.nombre_ot;
        }
        if(retiro.id_responsable == id_usuario){
          ordenesTrabajoUsuario.add(orden);
          retiroUsuario.add(retiro);
        }
        
      }
    }

    //Filtra para que aparezcan sólo los status correpondientes al usuario
    for (var status in statuses) {
      for (var orden in ordenesTrabajoUsuario) {
        if (status.id_ot == orden.id_ot) {
          statusesUsuario.add(status);
        }
      }
    }

    //Asignar status a cada OT
    for (var status in statusesUsuario) {
      for (var orden in ordenesTrabajoUsuario) {
        if (orden.id_ot == status.id_ot) {
          //Instalación
          for (var instalacion in instalacionUsuario) {
            if (instalacion.id_ot == orden.id_ot) {
              //TODO: Acá escribe el diccionario
              instalacion.statuses[status.id_status] = status.id_tipo_status;
              instalacion.id_tipo_status =
                  instalacion.statuses[orden.id_status];
            }
          }
          //Medición
          for (var medicion in medicionUsuario) {
            if (medicion.id_ot == orden.id_ot) {
              medicion.statuses[status.id_status] = status.id_tipo_status;
              medicion.id_tipo_status = medicion.statuses[orden.id_status];
            }
          }
          //Abastecimiento
          for (var abastecimiento in abastecimientoUsuario) {
            if (abastecimiento.id_ot == orden.id_ot) {
              abastecimiento.statuses[status.id_status] = status.id_tipo_status;
              abastecimiento.id_tipo_status =
                  abastecimiento.statuses[orden.id_status];
            }
          }
          //Retiro
          for (var retiro in retiroUsuario) {
            if (retiro.id_ot == orden.id_ot) {
              retiro.statuses[status.id_status] = status.id_tipo_status;
              retiro.id_tipo_status = retiro.statuses[orden.id_status];
            }
          }
        }
      }
    }

    //Asignar ubicaciones para los tanques en cada OT
    for (var sector in sectores) {
      //Instalación
      for (var instalacion in instalacionUsuario) {
        if (instalacion.ubicacion == sector.id_tk) {
          instalacion.lat = sector.lat.runtimeType == String
              ? double.parse(sector.lat)
              : sector.lat;
          instalacion.lon = sector.lon.runtimeType == String
              ? double.parse(sector.lon)
              : sector.lon;
        }
      }
      //Medición
      for (var medicion in medicionUsuario) {
        if (medicion.ubicacion == sector.id_tk) {
          medicion.lat = sector.lat.runtimeType == String
              ? double.parse(sector.lat)
              : sector.lat;
          medicion.lon = sector.lon.runtimeType == String
              ? double.parse(sector.lon)
              : sector.lon;
        }
      }
      //Abastecimiento
      for (var abastecimiento in abastecimientoUsuario) {
        if (abastecimiento.ubicacion == sector.id_tk) {
          abastecimiento.lat = sector.lat.runtimeType == String
              ? double.parse(sector.lat)
              : sector.lat;
          abastecimiento.lon = sector.lon.runtimeType == String
              ? double.parse(sector.lon)
              : sector.lon;
        }
      }
      //Retiro
      for (var retiro in retiroUsuario) {
        if (retiro.ubicacion == sector.id_tk) {
          retiro.lat = sector.lat.runtimeType == String
              ? double.parse(sector.lat)
              : sector.lat;
          retiro.lon = sector.lon.runtimeType == String
              ? double.parse(sector.lon)
              : sector.lon;
        }
      }
    }

    //Asignar Fechas de inicio y término para cada OT
    for (var fase in fases) {
      for (var orden in ordenesTrabajoUsuario) {
        if (orden.id_fase == fase.id_fase) {
          //Instalacion
          for (var instalacion in instalacionUsuario) {
            if (instalacion.id_ot == orden.id_ot) {
              instalacion.fecha_inicio = fase.fecha_ini;
              instalacion.fecha_termino = fase.fecha_fin;
              faseUsuario.add(fase);
            }
          }
          //Medicion
          for (var medicion in medicionUsuario) {
            if (medicion.id_ot == orden.id_ot) {
              medicion.fecha_inicio = fase.fecha_ini;
              medicion.fecha_termino = fase.fecha_fin;
              faseUsuario.add(fase);
            }
          }
          //Abastecimiento
          for (var abastecimiento in abastecimientoUsuario) {
            if (abastecimiento.id_ot == orden.id_ot) {
              abastecimiento.fecha_inicio = fase.fecha_ini;
              abastecimiento.fecha_termino = fase.fecha_fin;
              faseUsuario.add(fase);
            }
          }
          //Retiro
          for (var retiro in retiroUsuario) {
            if (retiro.id_ot == orden.id_ot) {
              retiro.fecha_inicio = fase.fecha_ini;
              retiro.fecha_termino = fase.fecha_fin;
              faseUsuario.add(fase);
            }
          }
        }
      }
    }

    //Asignar mensajes
    for (var mensaje in mensajes) {
      if (mensaje.id_usuario == id_usuario) {
        mensajesUsuario.add(mensaje);
      }
    }

    //

    //Asignar tipo de evento
    Stopwatch stopwatch = new Stopwatch()..start();
    for (var proceso in procesos) {
      if (proceso.id_tipo_status.toString() != "3") {
        for (var evento in eventos) {
          if (evento.num_sisda.toString() == proceso.descripcion_proceso) {
            for (var fase in faseUsuario) {
              if (fase.id_flujo == proceso.id_flujo) {
                for (var orden in ordenesTrabajoUsuario) {
                  if (orden.id_fase == fase.id_fase) {
                    for (var instalacion in instalacionUsuario) {
                      if (instalacion.id_ot == orden.id_ot) {
                        instalacion.tipo_evento = evento.tipo_evento;
                        instalacion.nombre_corte = proceso.nombre_proceso;
                        instalacion.ods = proceso.descripcion_proceso;
                        instalacionActiva.add(instalacion);
                      }
                    }
                    for (var medicion in medicionUsuario) {
                      if (medicion.id_ot == orden.id_ot) {
                        medicion.tipo_evento = evento.tipo_evento;
                        medicion.nombre_corte = proceso.nombre_proceso;
                        medicion.ods = proceso.descripcion_proceso;
                        medicionActiva.add(medicion);
                      }
                    }
                    for (var abastecimiento in abastecimientoUsuario) {
                      if (abastecimiento.id_ot == orden.id_ot) {
                        abastecimiento.tipo_evento = evento.tipo_evento;
                        abastecimiento.nombre_corte = proceso.nombre_proceso;
                        abastecimiento.ods = proceso.descripcion_proceso;
                        abastecimientoActiva.add(abastecimiento);
                      }
                    }
                    for (var retiro in retiroUsuario) {
                      if (retiro.id_ot == orden.id_ot) {
                        retiro.tipo_evento = evento.tipo_evento;
                        retiro.nombre_corte = proceso.nombre_proceso;
                        retiro.ods = proceso.descripcion_proceso;
                        retiroActiva.add(retiro);
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    print("Terminé");
    return fasesUsuario;
  }

  List validateLogin(String username, String password) {
    password = md5.convert(utf8.encode(password)).toString();
    print(password);
    bool loginState = false;
    Usuario? loggedUser;
    for (var usuario in usuarios) {
      if (usuario.nomusuario == username && usuario.clave == password) {
        loginState = true;
        loggedUser = usuario;
        _usuario = loggedUser;
        break;
      } else {
        loginState = false;
        loggedUser = usuario;
      }
    }
    return [loginState, loggedUser];
  }

  Stream<List<FaseInstalacion>> instalacionStream() async* {
    yield* Stream.periodic(Duration(seconds: 10), (_) async {
      final url = '${server}/ot_fase_instalacion/?format=json';
      final response = await http.get(Uri.parse(url));
      final data = json.decode(utf8.decode(response.bodyBytes)) as List;
      return data
          .map<FaseInstalacion>((json) => FaseInstalacion.fromJson(json))
          .toList();
    }).asyncMap((event) async => await event);
  }
}
