class FaseAbastecimiento {
  var id;
  var ubicacion;
  var contratista;
  var estado_ot;
  var patente_camion_ot;
  var capacidad_litros;
  var cantidad_cargas_efect;
  var comentario;
  var id_ot;
  var tipo_mod_xygo;
  var fecha_mod_xygo;
  var ir_mapa;
  var fecha_inicio;
  var fecha_termino;
  var id_tipo_status;
  var nombre_ot;
  var lat;
  var lon;
  var tipo_evento;
  String nombre_corte = "";
  String ods = "";
  List statuses = [];

  FaseAbastecimiento(
      {required this.id,
      required this.ubicacion,
      required this.contratista,
      required this.estado_ot,
      required this.patente_camion_ot,
      required this.capacidad_litros,
      required this.cantidad_cargas_efect,
      required this.comentario,
      required this.id_ot,
      required this.tipo_mod_xygo,
      required this.fecha_mod_xygo,
      required this.ir_mapa,
      required this.fecha_inicio,
      required this.fecha_termino,
      required this.id_tipo_status,
      required this.nombre_ot,
      required this.lat,
      required this.lon,
      required this.tipo_evento});

  factory FaseAbastecimiento.fromJson(Map<String, dynamic> json) {
    return FaseAbastecimiento(
        id: json['ID'] == null ? 0 : json['ID'],
        ubicacion: json['UBICACION'] == null ? 0 : json['UBICACION'],
        contratista: json['CONTRATISTA'] == null ? 0 : json['CONTRATISTA'],
        estado_ot: json['ESTADO_OT'] == null ? 0 : json['ESTADO_OT'],
        patente_camion_ot: json['PATENTE_CAMION_OT'] == null
            ? 'Sin datos'
            : json['PATENTE_CAMION_OT'],
        capacidad_litros: json['CAPACIDAD_LITROS'] == null
            ? 'Sin datos'
            : json['CAPACIDAD_LITROS'],
        cantidad_cargas_efect: json['CANTIDAD_CARGAS_EFECT'] == null
            ? 0
            : json['CANTIDAD_CARGAS_EFECT'],
        comentario:
            json['COMENTARIO'] == null ? 'Sin datos' : json['COMENTARIO'],
        id_ot: json['ID_OT'] == null ? 0 : json['ID_OT'],
        tipo_mod_xygo:
            json['TIPO_MOD_XYGO'] == null ? 0 : json['TIPO_MOD_XYGO'],
        fecha_mod_xygo: json['FECHA_MOD_XYGO'] == null
            ? 'Sin datos'
            : json['FECHA_MOD_XYGO'],
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
        'CONTRATISTA': contratista,
        'ESTADO_OT': estado_ot,
        'PATENTE_CAMION_OT': patente_camion_ot,
        'CAPACIDAD_LITROS': capacidad_litros,
        'CANTIDAD_CARGAS_EFECT': cantidad_cargas_efect,
        'COMENTARIO': comentario,
        'ID_OT': id_ot,
        'TIPO_MOD_XYGO': tipo_mod_xygo,
        'FECHA_MOD_XYGO': fecha_mod_xygo,
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
