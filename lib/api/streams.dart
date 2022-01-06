import 'dart:async';
import "dart:convert";
import 'package:essbio_apk/api/api.dart';
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
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/mod_wkf_orden_trabajo.dart';

class Streams {
  /*Streams() {
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
  }*/

  // final server = "http://10.0.2.2:8000";
  final server = "https://djangorestessbio.herokuapp.com";
  bool boolUsuarios = false;
  bool boolOrdenesTrabajo = false;
  bool boolStatus = false;
  bool boolFases = false;
  bool boolCamiones = false;
  bool boolContratistas = false;
  bool boolDataTKSectores = false;
  bool boolTiposModulo = false;
  bool boolFasesInstalacion = false;
  bool boolFasesAbastMedicion = false;
  bool boolFasesAbastecimiento = false;
  bool boolFasesRetiro = false;
  bool boolDataEventos = false;
  bool boolProcesos = false;
  bool boolMensajes = false;
  bool completado = false;
  int modificador = 0;
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
      var data = json.decode(response.body) as List;
      _procesos = data.map<Proceso>((json) => Proceso.fromJson(json)).toList();
      print("Procesos obtenidos");
      boolProcesos = true;
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
      boolOrdenesTrabajo = true;
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
      boolTiposModulo = true;
    }
  }

  fetchCamiones() async {
    final url = '${server}/evento_camion/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _camiones = data.map<Camion>((json) => Camion.fromJson(json)).toList();
      print("Camiones obtenidos");
      boolCamiones = true;
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
      boolContratistas = true;
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
      boolDataTKSectores = true;
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
      boolFasesInstalacion = true;
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
      boolFasesAbastMedicion = true;
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
      boolFasesAbastecimiento = true;
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
      boolFasesRetiro = true;
    }
  }

  fetchUsuarios() async {
    final url = '${server}/xygo_usuarios/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _usuarios = data.map<Usuario>((json) => Usuario.fromJson(json)).toList();
      print("Usuarios obtenidos");
      boolUsuarios = true;
    }
  }

  fetchStatus() async {
    final url = '${server}/mod_wkf_status/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _status = data.map<Status>((json) => Status.fromJson(json)).toList();
      print("Status obtenidos");
      boolStatus = true;
    }
  }

  fetchFases() async {
    final url = '${server}/mod_wkf_fase/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _fases = data.map<Fase>((json) => Fase.fromJson(json)).toList();
      print("Fases obtenidas");
      boolFases = true;
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
      boolDataEventos = true;
    }
  }

  fetchMensajes() async {
    final url = '${server}/mod_mensaje/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _mensajes = data.map<Mensaje>((json) => Mensaje.fromJson(json)).toList();
      print("Mensajes obtenidos");
      boolMensajes = true;
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
              instalacion.statuses[status.id_status] = status.id_tipo_status;
              instalacion.id_tipo_status = instalacion.statuses[orden.id_status];
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
              abastecimiento.id_tipo_status = abastecimiento.statuses[orden.id_status];
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

  Stream<Map> workflowStream() async* {
    while (true) {
      //  await Future.delayed(Duration(seconds: 5));
      await fetchUsuarios();
      await fetchOrdenesTrabajo();
      await fetchStatus();
      await fetchFases();
      await fetchCamiones();
      await fetchContratistas();
      await fetchDataTKSectores();
      await fetchTiposModulo();
      await fetchFasesInstalacion();
      await fetchFasesAbastMedicion();
      await fetchFasesAbastecimiento();
      await fetchFasesRetiro();
      await fetchDataEventos();
      await fetchProcesos();
      await fetchMensajes();
      modificador = 0;
      var fasesUsuario = getFasesUsuario(
          ordenesTrabajo: _ordenesTrabajo,
          fasesInstalacion: _fasesInstalacion,
          fasesMedicion: _fasesAbastMedicion,
          fasesAbastecimiento: _fasesAbastecimiento,
          fasesRetiro: _fasesRetiro,
          fases: _fases,
          statuses: _status,
          sectores: _dataTKSectores,
          procesos: _procesos,
          eventos: _dataEventos,
          mensajes: _mensajes,
          id_usuario: 4);
      yield {
        "fasesInstalacion": fasesUsuario[0],
        "fasesAbastMedicion": fasesUsuario[1],
        "fasesAbastecimiento": fasesUsuario[2],
        "fasesRetiro": fasesUsuario[3],
        "mensajes": fasesUsuario[4]
      };
      /*{
        "ordenesTrabajo": _ordenesTrabajo,
        "fasesInstalacion": _fasesInstalacion,
        "fasesAbastMedicion": _fasesAbastMedicion,
        "fasesAbastecimiento": _fasesAbastecimiento,
        "fasesRetiro": _fasesRetiro,
        "fases": _fases,
        "status": _status,
        "dataTKSectores": _dataTKSectores,
        "procesos": _procesos,
        "dataEventos": _dataEventos,
        "mensajes": _mensajes,
      };*/
    }
  }
}
