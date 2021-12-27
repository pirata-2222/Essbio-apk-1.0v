class Mensaje {
  final id_mensaje;
  final id_modulo;
  final id_objeto;
  final id_usuario;
  final tipo_mensaje;
  final prioridad;
  final confirmacion;
  final mensaje;
  final mensaje_respuesta;
  final fecha_creacion;
  final fecha_confirmacion;
  final fecha_lectura;
  final id_usuario_creacion;
  final activo;
  final estado;
  final fecha_mod_xygo;
  final tipo_mod_xygo;

  Mensaje({
    required this.id_mensaje,
    required this.id_modulo,
    required this.id_objeto,
    required this.id_usuario,
    required this.tipo_mensaje,
    required this.prioridad,
    required this.confirmacion,
    required this.mensaje,
    required this.mensaje_respuesta,
    required this.fecha_creacion,
    required this.fecha_confirmacion,
    required this.fecha_lectura,
    required this.id_usuario_creacion,
    required this.activo,
    required this.estado,
    required this.fecha_mod_xygo,
    required this.tipo_mod_xygo,
    });

  factory Mensaje.fromJson(Map<String, dynamic> json) {
    return Mensaje(
        id_mensaje: json['ID_MENSAJE']== null ? 'Sin datos' : json['ID_MENSAJE'],
        id_modulo: json['ID_MODULO']== null ? 'Sin datos' : json['ID_MODULO'],
        id_objeto: json['ID_OBJETO']== null ? 'Sin datos' : json['ID_OBJETO'],
        id_usuario: json['ID_USUARIO']== null ? 'Sin datos' : json['ID_USUARIO'],
        tipo_mensaje: json['TIPO_MENSAJE']== null ? 'Sin datos' : json['TIPO_MENSAJE'],
        prioridad: json['PRIORIDAD']== null ? 'Sin datos' : json['PRIORIDAD'],
        confirmacion: json['CONFIRMACION']== null ? 'Sin datos' : json['CONFIRMACION'],
        mensaje: json['MENSAJE']== null ? 'Sin datos' : json['MENSAJE'],
        mensaje_respuesta: json['MENSAJE_RESPUESTA']== null ? 'Sin datos' : json['MENSAJE_RESPUESTA'],
        fecha_creacion: json['FECHA_CREACION']== null ? 'Sin datos' : json['FECHA_CREACION'],
        fecha_confirmacion: json['FECHA_CONFIRMACION']== null ? 'Sin datos' : json['FECHA_CONFIRMACION'],
        fecha_lectura: json['FECHA_LECTURA']== null ? 'Sin datos' : json['FECHA_LECTURA'],
        id_usuario_creacion: json['ID_USUARIO_CREACION']== null ? 'Sin datos' : json['ID_USUARIO_CREACION'],
        activo: json['ACTIVO']== null ? 'Sin datos' : json['ACTIVO'],
        estado: json['ESTADO']== null ? 'Sin datos' : json['ESTADO'],
        fecha_mod_xygo: json['FECHA_MOD_XYGO']== null ? 'Sin datos' : json['FECHA_MOD_XYGO'],
        tipo_mod_xygo: json['TIPO_MOD_XYGO']== null ? 'Sin datos' : json['TIPO_MOD_XYGO'],);
  }
  dynamic toJson() => {
        'ID_MENSAJE': id_mensaje,
        'ID_MODULO': id_modulo,
        'ID_OBJETO': id_objeto,
        'ID_USUARIO': id_usuario,
        'TIPO_MENSAJE': tipo_mensaje,
        'PRIORIDAD': prioridad,
        'CONFIRMACION': confirmacion,
        'MENSAJE': mensaje,
        'MENSAJE_RESPUESTA': mensaje_respuesta,
        'FECHA_CREACION': fecha_creacion,
        'FECHA_CONFIRMACION': fecha_confirmacion,
        'FECHA_LECTURA': fecha_lectura,
        'ID_USUARIO_CREACION': id_usuario_creacion,
        'ACTIVO': activo,
        'ESTADO': estado,
        'FECHA_MOD_XYGO': fecha_mod_xygo,
        'TIPO_MOD_XYGO': tipo_mod_xygo,
      };
}
