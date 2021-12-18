class DataTKSector {
  final id;
  final id_evento;
  final id_sector;
  final id_por_evento;
  final nombre_sector;
  final nombre_sector_corto;
  final id_tk;
  final nombre;
  final descripcion;
  final fecha_creacion;
  final x;
  final y;
  final latitud;
  final longitud;
  final id_usuario;
  final id_perfil;
  final login;
  final nombre_usuario;
  final apellidos_usuario;
  final nombre_perfil;
  final calle_1;
  final calle_2;
  final estado;
  final lon;
  final lat;
  final geom;
  final fecha_mod_xygo;
  final tipo_mod_xygo;

  DataTKSector({
    required this.id,
    required this.id_evento,
    required this.id_sector,
    required this.id_por_evento,
    required this.nombre_sector,
    required this.nombre_sector_corto,
    required this.id_tk,
    required this.nombre,
    required this.descripcion,
    required this.fecha_creacion,
    required this.x,
    required this.y,
    required this.latitud,
    required this.longitud,
    required this.id_usuario,
    required this.id_perfil,
    required this.login,
    required this.nombre_usuario,
    required this.apellidos_usuario,
    required this.nombre_perfil,
    required this.calle_1,
    required this.calle_2,
    required this.estado,
    required this.lon,
    required this.lat,
    required this.geom,
    required this.fecha_mod_xygo,
    required this.tipo_mod_xygo
  });

  factory DataTKSector.fromJson(Map<String, dynamic> json) {
    return DataTKSector(
        id: json['ID']== null ? 0 : json['ID'],
        id_evento: json['ID_EVENTO']== null ? 0 : json['ID_EVENTO'],
        id_sector: json['ID_SECTOR']== null ? 0 : json['ID_SECTOR'],
        id_por_evento: json['ID_POR_EVENTO']== null ? 0 : json['ID_POR_EVENTO'],
        nombre_sector: json['NOMBRE_SECTOR']== null ? 'Sin datos' : json['NOMBRE_SECTOR'],
        nombre_sector_corto: json['NOMBRE_SECTOR_CORTO']== null ? 'Sin datos' : json['NOMBRE_SECTOR_CORTO'],
        id_tk: json['ID_TK']== null ? 'Sin datos' : json['ID_TK'],
        nombre: json['NOMBRE']== null ? 'Sin datos' : json['NOMBRE'],
        descripcion: json['DESCRIPCION']== null ? 'Sin datos' : json['DESCRIPCION'],
        fecha_creacion: json['FECHA_CREACION']== null ? 'Sin datos' : json['FECHA_CREACION'],
        x: json['X']== null ? 'Sin datos' : json['X'],
        y: json['Y']== null ? 'Sin datos' : json['Y'],
        latitud: json['LATITUD']== null ? 'Sin datos' : json['LATITUD'],
        longitud: json['LONGITUD']== null ? 'Sin datos' : json['LONGITUD'],
        id_usuario: json['ID_USUARIO']== null ? 'Sin datos' : json['ID_USUARIO'],
        id_perfil: json['ID_PERFIL']== null ? 'Sin datos' : json['ID_PERFIL'],
        login: json['LOGIN']== null ? 'Sin datos' : json['LOGIN'],
        nombre_usuario: json['NOMBRE_USUARIO']== null ? 'Sin datos' : json['NOMBRE_USUARIO'],
        apellidos_usuario: json['APELLIDOS_USUARIO']== null ? 'Sin datos' : json['APELLIDOS_USUARIO'],
        nombre_perfil: json['NOMBRE_PERFIL']== null ? 'Sin datos' : json['NOMBRE_PERFIL'],
        calle_1: json['CALLE_1']== null ? 'Sin datos' : json['CALLE_1'],
        calle_2: json['CALLE_2']== null ? 'Sin datos' : json['CALLE_2'],
        estado: json['ESTADO']== null ? 0 : json['ESTADO'],
        lon: json['LON']== null ? 0.0 : json['LON'],
        lat: json['LAT']== null ? 0.0 : json['LAT'],
        geom: json['GEOM']== null ? 'Sin datos' : json['GEOM'],
        fecha_mod_xygo: json['FECHA_MOD_XYGO']== null ? 'Sin datos' : json['FECHA_MOD_XYGO'],
        tipo_mod_xygo: json['TIPO_MOD_XYGO']== null ? 0 : json['TIPO_MOD_XYGO']);
  }
  dynamic toJson() => {
        'ID': id,
        'ID_EVENTO': id_evento,
        'ID_SECTOR': id_sector,
        'ID_POR_EVENTO': id_por_evento,
        'NOMBRE_SECTOR': nombre_sector,
        'NOMBRE_SECTOR_CORTO': nombre_sector_corto,
        'ID_TK': id_tk,
        'NOMBRE': nombre,
        'DESCRIPCION': descripcion,
        'FECHA_CREACION': fecha_creacion,
        'X': x,
        'Y': y,
        'LATITUD': latitud,
        'LONGITUD': longitud,
        'ID_USUARIO': id_usuario,
        'ID_PERFIL': id_perfil,
        'LOGIN': login,
        'NOMBRE_USUARIO': nombre_usuario,
        'APELLIDOS_USUARIO': apellidos_usuario,
        'NOMBRE_PERFIL': nombre_perfil,
        'CALLE_1': calle_1,
        'CALLE_2': calle_2,
        'ESTADO': estado,
        'LON': lon,
        'LAT': lat,
        'GEOM': geom,
        'FECHA_MOD_XYGO': fecha_mod_xygo,
        'TIPO_MOD_XYGO': tipo_mod_xygo
      };
}
