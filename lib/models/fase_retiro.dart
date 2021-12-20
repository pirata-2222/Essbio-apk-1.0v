class FaseRetiro {
  var id;
  var contratista;
  var ubicacion;
  var estado_terreno;
  var numero_estanque;
  var comentario;
  var id_ot;
  var fecha_mod_xygo;
  var tipo_mod_xygo;
  var archivo_adjunto;
  var ir_mapa;
  var fecha_inicio;
  var fecha_termino;
  var id_tipo_status;
  var nombre_ot;
  var lat;
  var lon;
  var tipo_evento;
  FaseRetiro(
      {required this.id,
      required this.contratista,
      required this.ubicacion,
      required this.estado_terreno,
      required this.numero_estanque,
      required this.comentario,
      required this.id_ot,
      required this.fecha_mod_xygo,
      required this.tipo_mod_xygo,
      required this.archivo_adjunto,
      required this.ir_mapa,
      required this.fecha_inicio,
      required this.fecha_termino,
      required this.id_tipo_status,
      required this.nombre_ot,
      required this.lat,
      required this.lon,
      required this.tipo_evento});

  factory FaseRetiro.fromJson(Map<String, dynamic> json) {
    return FaseRetiro(
        id: json['ID'] == null ? 0 : json['ID'],
        contratista: json['CONTRATISTA'] == null ? 0 : json['CONTRATISTA'],
        ubicacion: json['UBICACION'] == null ? 0 : json['UBICACION'],
        estado_terreno: json['ESTADO_TERRENO'] == null
            ? 'Sin datos'
            : json['ESTADO_TERRENO'],
        numero_estanque: json['NUMERO_ESTANQUE'] == null
            ? 'Sin datos'
            : json['NUMERO_ESTANQUE'],
        comentario:
            json['COMENTARIO'] == null ? 'Sin datos' : json['COMENTARIO'],
        id_ot: json['ID_OT'] == null ? 0 : json['ID_OT'],
        fecha_mod_xygo: json['FECHA_MOD_XYGO'] == null
            ? 'Sin datos'
            : json['FECHA_MOD_XYGO'],
        tipo_mod_xygo:
            json['TIPO_MOD_XYGO'] == null ? 0 : json['TIPO_MOD_XYGO'],
        archivo_adjunto: json['ARCHIVO_ADJUNTO'] == null
            ? 'Sin datos'
            : json['ARCHIVO_ADJUNTO'],
        ir_mapa: json['IR_MAPA'] == null ? 'Sin datos' : json['IR_MAPA'],
        fecha_inicio: json['FECHA_INI'] == null ? 'Sin datos' : json['FECHA_INI'],
        fecha_termino: json['FECHA_FIN'] == null? 'sin datos':json['FECHA_FIN'],
        id_tipo_status: json['ID_TIPO_STATUS'] == null? 'Sin datos':json['ID_TIPO_STATUS'],
        nombre_ot: json["NOMBRE_OT"] == null
            ? 'Sin datos'
            : json["NOMBRE_OT"],
        lat: json["LAT"] == null ? '0.0' : json["LAT"],
        lon: json["LON"] == null ? '0.0' : json["LON"],
        tipo_evento: json["TIPO_EVENTO"] == null ? '0.0' : json["TIPO_EVENTO"]
        );
  }
  dynamic toJson() => {
        'ID': id,
        'CONTRATISTA': contratista,
        'UBICACION': ubicacion,
        'ESTADO_TERRENO': estado_terreno,
        'NUMERO_ESTANQUE': numero_estanque,
        'COMENTARIO': comentario,
        'ID_OT': id_ot,
        'FECHA_MOD_XYGO': fecha_mod_xygo,
        'TIPO_MOD_XYGO': tipo_mod_xygo,
        'ARCHIVO_ADJUNTO': archivo_adjunto,
        'IR_MAPA': ir_mapa,
        'FECHA_INI': fecha_inicio,
        'FECHA_FIN': fecha_termino,
        'ID_TIPO_STATUS': id_tipo_status,
        "NOMBRE_OT": nombre_ot,
        "LAT": lat,
        'LON': lon,
        "TIPO_EVENTO": tipo_evento
      };
}
