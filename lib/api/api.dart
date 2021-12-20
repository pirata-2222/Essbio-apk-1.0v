import 'dart:async';
import "dart:convert";
import 'package:essbio_apk/models/evento_camion.dart';
import 'package:essbio_apk/models/evento_contratista.dart';
import 'package:essbio_apk/models/evento_data_eventos.dart';
import 'package:essbio_apk/models/evento_data_tk_sector.dart';
import 'package:essbio_apk/models/fase_abast_medicion.dart';
import 'package:essbio_apk/models/fase_abastecimiento.dart';
import 'package:essbio_apk/models/fase_instalacion.dart';
import 'package:essbio_apk/models/fase_retiro.dart';
import 'package:essbio_apk/models/mod_wkf_fase.dart';
import 'package:essbio_apk/models/mod_wkf_proceso.dart';
import 'package:essbio_apk/models/mod_wkf_status.dart';
import 'package:essbio_apk/models/mod_wkf_tipo_modulo.dart';
import 'package:essbio_apk/models/xygo_usuario.dart';
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
  }
  // final server = "http://10.0.2.2:8000";
  final server = "https://djangorestessbio.herokuapp.com";

  int loginCounter = 0;
  StreamController<int> loginCounterController = StreamController();

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

  Usuario? _usuario;
  Usuario? get usuario {
    return _usuario;
  }

  //Funciones para solicitud GET

  fetchProcesos() async {
    final url = '${server}/mod_wkf_proceso/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
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
      var data = json.decode(response.body) as List;
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
      var data = json.decode(response.body) as List;
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
      var data = json.decode(response.body) as List;
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
      var data = json.decode(response.body) as List;
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
      var data = json.decode(response.body) as List;
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
      var data = json.decode(response.body) as List;
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
      var data = json.decode(response.body) as List;
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
      var data = json.decode(response.body) as List;
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
      var data = json.decode(response.body) as List;
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
      var data = json.decode(response.body) as List;
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
      var data = json.decode(response.body) as List;
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
      var data = json.decode(response.body) as List;
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
      var data = json.decode(response.body) as List;
      _dataEventos =
          data.map<DataEventos>((json) => DataEventos.fromJson(json)).toList();
      print("Data eventos obtenidas");
      loginCounter = loginCounter + 1;
      loginCounterController.add(loginCounter);
    }
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
    final response_ots = await http.get(Uri.parse(url_ots));
    var data_ots = json.decode(response_ots.body);
    var id_status = data_ots["ID_STATUS"].toString();
    print("id status: " + id_status.toString());
    final url_status = '$server/mod_wkf_status/$id_status/?format=json';

    final response_status = await http.put(Uri.parse(url_status),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "ID_TIPO_STATUS": modificacion["ID_TIPO_STATUS"] == ""
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
              : modificacion["COMENTARIO_INSTALACION"],
          "FECHA_MOD_XYGO":
              DateTime.now().toIso8601String().substring(0, 19) + "Z",
        }));

    final url_ots =
        '$server/mod_wkf_orden_trabajo/${faseAbastecimiento.id_ot}/?format=json';
    final response_ots = await http.get(Uri.parse(url_ots));
    var data_ots = json.decode(response_ots.body);
    var id_status = data_ots["ID_STATUS"].toString();
    print("id status: " + id_status.toString());
    final url_status = '$server/mod_wkf_status/$id_status/?format=json';

    final response_status = await http.put(Uri.parse(url_status),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "ID_TIPO_STATUS": modificacion["ID_TIPO_STATUS"] == ""
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
    final id = faseAbastMedicion.id;
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
                  : modificacion['NIVEL_AGUA_CUMPLE_NORMA'],
          'NIVEL_CLORO': modificacion['NIVEL_CLORO'] == ""
              ? faseAbastMedicion.nivel_cloro
              : modificacion['NIVEL_CLORO'],
          'NIVEL_CLORO_CUMPLE_NORMA':
              modificacion['NIVEL_CLORO_CUMPLE_NORMA'] == ""
                  ? faseAbastMedicion.nivel_cloro_cumple_norma
                  : modificacion['NIVEL_CLORO_CUMPLE_NORMA'],
          'NIVEL_TURBIEDAD': modificacion['NIVEL_TURBIEDAD'] == ""
              ? faseAbastMedicion.nivel_turbiedad
              : modificacion['NIVEL_AGUA'],
          'NIVEL_TURBIEDAD_CUMPLE_NORMA':
              modificacion['NIVEL_TURBIEDAD_CUMPLE_NORMA'] == ""
                  ? faseAbastMedicion.nivel_turbiedad_cumple_norma
                  : modificacion['NIVEL_TURBIEDAD_CUMPLE_NORMA'],
          "COMENTARIO": modificacion["COMENTARIO"] == ""
              ? faseAbastMedicion.comentario
              : modificacion["COMENTARIO_INSTALACION"],
          "FECHA_MOD_XYGO":
              DateTime.now().toIso8601String().substring(0, 19) + "Z",
        }));

    final url_ots =
        '$server/mod_wkf_orden_trabajo/${faseAbastMedicion.id_ot}/?format=json';
    final response_ots = await http.get(Uri.parse(url_ots));
    var data_ots = json.decode(response_ots.body);
    var id_status = data_ots["ID_STATUS"].toString();
    print("id status: " + id_status.toString());
    final url_status = '$server/mod_wkf_status/$id_status/?format=json';

    final response_status = await http.put(Uri.parse(url_status),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "ID_TIPO_STATUS": modificacion["ID_TIPO_STATUS"] == ""
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
              : modificacion["COMENTARIO_INSTALACION"],
          "FECHA_MOD_XYGO":
              DateTime.now().toIso8601String().substring(0, 19) + "Z",
        }));

    final url_ots =
        '$server/mod_wkf_orden_trabajo/${faseRetiro.id_ot}/?format=json';
    final response_ots = await http.get(Uri.parse(url_ots));
    var data_ots = json.decode(response_ots.body);
    var id_status = data_ots["ID_STATUS"].toString();
    print("id status: " + id_status.toString());
    final url_status = '$server/mod_wkf_status/$id_status/?format=json';

    final response_status = await http.put(Uri.parse(url_status),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "ID_TIPO_STATUS": modificacion["ID_TIPO_STATUS"] == ""
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

  List getFasesUsuario(
      List<OrdenTrabajo> ordenesTrabajo,
      List<FaseInstalacion> fasesInstalacion,
      List<FaseAbastMedicion> fasesMedicion,
      List<FaseAbastecimiento> fasesAbastecimiento,
      List<FaseRetiro> fasesRetiro,
      List<Fase> fases,
      List<Status> statuses,
      List<DataTKSector> sectores,
      List<Proceso> procesos,
      List<DataEventos> eventos,
      int id_usuario) {
    List<FaseInstalacion> instalacionUsuario = [];
    List<FaseAbastMedicion> medicionUsuario = [];
    List<FaseAbastecimiento> abastecimientoUsuario = [];
    List<FaseRetiro> retiroUsuario = [];
    List<OrdenTrabajo> ordenesTrabajoUsuario = [];
    List<Status> statusesUsuario = [];
    var fasesUsuario = [
      instalacionUsuario,
      medicionUsuario,
      abastecimientoUsuario,
      retiroUsuario
    ];

    for (var instalacion in fasesInstalacion) {
      if (instalacion.contratista == id_usuario) {
        instalacionUsuario.add(instalacion);
        for (var orden in ordenesTrabajo) {
          if (orden.id_ot == instalacion.id_ot) {
            ordenesTrabajoUsuario.add(orden);
            instalacion.nombre_ot = orden.nombre_ot;
          }
        }
      }
    }
    for (var medicion in fasesMedicion) {
      if (medicion.personal == id_usuario) {
        medicionUsuario.add(medicion);
        for (var orden in ordenesTrabajo) {
          if (orden.id_ot == medicion.id_ot) {
            ordenesTrabajoUsuario.add(orden);
            medicion.nombre_ot = orden.nombre_ot;
          }
        }
      }
    }
    for (var abastecimiento in fasesAbastecimiento) {
      if (abastecimiento.contratista == id_usuario) {
        abastecimientoUsuario.add(abastecimiento);
        for (var orden in ordenesTrabajo) {
          if (orden.id_ot == abastecimiento.id_ot) {
            ordenesTrabajoUsuario.add(orden);
            abastecimiento.nombre_ot = orden.nombre_ot;
          }
        }
      }
    }
    for (var retiro in fasesRetiro) {
      if (retiro.contratista == id_usuario) {
        retiroUsuario.add(retiro);
        for (var orden in ordenesTrabajo) {
          if (orden.id_ot == retiro.id_ot) {
            ordenesTrabajoUsuario.add(orden);
            retiro.nombre_ot = orden.nombre_ot;
          }
        }
      }
    }

    for (var status in statuses) {
      for (var orden in ordenesTrabajoUsuario) {
        if (status.id_ot == orden.id_ot) {
          statusesUsuario.add(status);
        }
      }
    }

    //Asignar ubicaciones
    for (var sector in sectores) {
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
    }
    for (var sector in sectores) {
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
    }
    for (var sector in sectores) {
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
    }
    for (var sector in sectores) {
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

    //Asignar status
    for (var status in statusesUsuario) {
      for (var orden in ordenesTrabajoUsuario) {
        if (orden.id_status == status.id_status) {
          for (var instalacion in instalacionUsuario) {
            if (instalacion.id_ot == orden.id_ot) {
              instalacion.id_tipo_status = status.id_tipo_status;
            }
          }
        }
      }
    }

    for (var status in statusesUsuario) {
      for (var orden in ordenesTrabajoUsuario) {
        if (orden.id_status == status.id_status) {
          for (var medicion in medicionUsuario) {
            if (medicion.id_ot == orden.id_ot) {
              medicion.id_tipo_status = status.id_tipo_status;
            }
          }
        }
      }
    }
    for (var status in statusesUsuario) {
      for (var orden in ordenesTrabajoUsuario) {
        if (orden.id_status == status.id_status) {
          for (var abastecimiento in abastecimientoUsuario) {
            if (abastecimiento.id_ot == orden.id_ot) {
              abastecimiento.id_tipo_status = status.id_tipo_status;
            }
          }
        }
      }
    }
    for (var status in statusesUsuario) {
      for (var orden in ordenesTrabajoUsuario) {
        if (orden.id_status == status.id_status) {
          for (var retiro in retiroUsuario) {
            if (retiro.id_ot == orden.id_ot) {
              retiro.id_tipo_status = status.id_tipo_status;
            }
          }
        }
      }
    }

    //Asignar Fechas
    for (var fase in fases) {
      for (var orden in ordenesTrabajoUsuario) {
        if (orden.id_fase == fase.id_fase) {
          for (var instalacion in instalacionUsuario) {
            if (instalacion.id_ot == orden.id_ot) {
              instalacion.fecha_inicio = fase.fecha_ini;
              instalacion.fecha_termino = fase.fecha_fin;
            }
          }
        }
      }
    }
    for (var fase in fases) {
      for (var orden in ordenesTrabajoUsuario) {
        if (orden.id_fase == fase.id_fase) {
          for (var medicion in medicionUsuario) {
            if (medicion.id_ot == orden.id_ot) {
              medicion.fecha_inicio = fase.fecha_ini;
              medicion.fecha_termino = fase.fecha_fin;
            }
          }
        }
      }
    }
    for (var fase in fases) {
      for (var orden in ordenesTrabajoUsuario) {
        if (orden.id_fase == fase.id_fase) {
          for (var abastecimiento in abastecimientoUsuario) {
            if (abastecimiento.id_ot == orden.id_ot) {
              abastecimiento.fecha_inicio = fase.fecha_ini;
              abastecimiento.fecha_termino = fase.fecha_fin;
            }
          }
        }
      }
    }
    for (var fase in fases) {
      for (var orden in ordenesTrabajoUsuario) {
        if (orden.id_fase == fase.id_fase) {
          for (var retiro in retiroUsuario) {
            if (retiro.id_ot == orden.id_ot) {
              retiro.fecha_inicio = fase.fecha_ini;
              retiro.fecha_termino = fase.fecha_fin;
            }
          }
        }
      }
    }

    //Asignar tipo de evento
    Stopwatch stopwatch = new Stopwatch()..start();
    for (var evento in eventos) {
      for (var proceso in procesos) {
        if (evento.num_sisda == proceso.descripcion_proceso) {
          for (var fase in fases) {
            if (fase.id_flujo == proceso.id_flujo) {
              for (var orden in ordenesTrabajo) {
                if (orden.id_fase == fase.id_fase) {
                  for (var instalacion in instalacionUsuario) {
                    if (instalacion.id_ot == orden.id_ot) {
                      instalacion.tipo_evento = evento.tipo_evento;
                    }
                  }
                  for (var medicion in medicionUsuario) {
                    if (medicion.id_ot == orden.id_ot) {
                      medicion.tipo_evento = evento.tipo_evento;
                    }
                  }
                  for (var abastecimiento in abastecimientoUsuario) {
                    if (abastecimiento.id_ot == orden.id_ot) {
                      abastecimiento.tipo_evento = evento.tipo_evento;
                    }
                  }
                  for (var retiro in retiroUsuario) {
                    if (retiro.id_ot == orden.id_ot) {
                      retiro.tipo_evento = evento.tipo_evento;
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    print('for gigante executed in ${stopwatch.elapsed.inSeconds}');

    print("Terminé");
    return fasesUsuario;
  }

  List validateLogin(String username, String password) {
    bool loginState = false;
    Usuario? loggedUser;
    for (var usuario in usuarios) {
      print(usuario.nomusuario);
      if (usuario.nomusuario == username && usuario.clave == password) {
        loginState = true;
        loggedUser = usuario;
        _usuario = loggedUser;
        break;
      } else {
        print("No se encontró usuario");
        loginState = false;
        loggedUser = usuario;
      }
    }
    return [loginState, loggedUser];
  }
}
