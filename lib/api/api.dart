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

  Usuario? _usuario;
  Usuario? get usuario {
    return _usuario;
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
    final url = '${server}/xygo_usuarios/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _usuarios = data.map<Usuario>((json) => Usuario.fromJson(json)).toList();
    }
  }

  fetchStatus() async {
    final url = '${server}/mod_wkf_status/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _status = data.map<Status>((json) => Status.fromJson(json)).toList();
    }
  }

  fetchFases() async {
    final url = '${server}/mod_wkf_fase/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _fases = data.map<Fase>((json) => Fase.fromJson(json)).toList();
    }
  }

  fetchDataEventos() async {
    final url = '${server}/evento_data_eventos/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      _dataEventos =
          data.map<DataEventos>((json) => DataEventos.fromJson(json)).toList();
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
