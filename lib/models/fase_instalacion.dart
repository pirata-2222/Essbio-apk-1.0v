class FaseInstalacion {
  var id;
  var ubicacion;
  var estado_terreno;
  var contratista;
  var comentario_instalacion;
  var rotulo_tk;
  var id_ot;
  var tipo_mod_xygo;
  var fecha_mod_xygo;
  var archivo_adjunto;
  var ir_mapa;
  var fecha_inicio;
  var fecha_termino;
  var id_tipo_status;
  var nombre_ot;
  var lat;
  var lon;
  var tipo_evento;

  FaseInstalacion(
      {required this.id,
      required this.ubicacion,
      required this.estado_terreno,
      required this.contratista,
      required this.comentario_instalacion,
      required this.rotulo_tk,
      required this.id_ot,
      required this.tipo_mod_xygo,
      required this.fecha_mod_xygo,
      required this.archivo_adjunto,
      required this.ir_mapa,
      required this.fecha_inicio,
      required this.fecha_termino,
      required this.id_tipo_status,
      required this.nombre_ot,
      required this.lat,
      required this.lon,
      required this.tipo_evento});

  factory FaseInstalacion.fromJson(Map<String, dynamic> json) {
    return FaseInstalacion(
        id: json['ID'] == null ? 0 : json['ID'],
        ubicacion: json['UBICACION'] == null ? 0 : json['UBICACION'],
        estado_terreno:
            json['ESTADO_TERRENO'] == null ? 0 : json['ESTADO_TERRENO'],
        contratista: json['CONTRATISTA'] == null ? 0 : json['CONTRATISTA'],
        comentario_instalacion: json['COMENTARIO_INSTALACION'] == null
            ? 'Sin datos'
            : json['COMENTARIO_INSTALACION'],
        rotulo_tk: json['ROTULO_TK'] == null ? 'Sin datos' : json['ROTULO_TK'],
        id_ot: json['ID_OT'] == null ? 0 : json['ID_OT'],
        tipo_mod_xygo:
            json['TIPO_MOD_XYGO'] == null ? 0 : json['TIPO_MOD_XYGO'],
        fecha_mod_xygo: json['FECHA_MOD_XYGO'] == null
            ? 'Sin datos'
            : json['FECHA_MOD_XYGO'],
        archivo_adjunto: json['ARCHIVO_ADJUNTO'] == null
            ? 'Sin datos'
            : json['ARCHIVO_ADJUNTO'],
        ir_mapa: json['IR_MAPA'] == null ? 'Sin datos' : json['IR_MAPA'],
        fecha_inicio:
            json['FECHA_INI'] == null ? '1993-12-09' : json['FECHA_INI'],
        fecha_termino:
            json['FECHA_FIN'] == null ? '1993-12-09' : json['FECHA_FIN'],
        id_tipo_status: json['ID_TIPO_STATUS'] == null
            ? 'Sin datos'
            : json['ID_TIPO_STATUS'],
        nombre_ot: json["NOMBRE_OT"] == null ? 'Sin datos' : json["NOMBRE_OT"],
        lat: json["LAT"] == null ? '0.0' : json["LAT"],
        lon: json["LON"] == null ? '0.0' : json["LON"],
        tipo_evento: json["TIPO_EVENTO"] == null ? '0.0' : json["TIPO_EVENTO"]);
  }
  dynamic toJson() => {
        'ID': id,
        'UBICACION': ubicacion,
        'ESTADO_TERRENO': estado_terreno,
        'CONTRATISTA': contratista,
        'COMENTARIO_INSTALACION': comentario_instalacion,
        'ROTULO_TK': rotulo_tk,
        'ID_OT': id_ot,
        'TIPO_MOD_XYGO': tipo_mod_xygo,
        'FECHA_MOD_XYGO': fecha_mod_xygo,
        'ARCHIVO_ADJUNTO': archivo_adjunto,
        'IR_MAPA': ir_mapa,
        'FECHA_INI': fecha_inicio,
        'FECHA_FIN': fecha_termino,
        'ID_TIPO_STATUS': id_tipo_status,
        "NOMBRE_OT": nombre_ot,
        "LAT": lat,
        'LON': lon,
        'TIPO_EVENTO': tipo_evento
      };
}
