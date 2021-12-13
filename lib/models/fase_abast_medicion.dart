class FaseAbastMedicion {
  var id;
  var personal;
  var ubicacion;
  var comentario;
  var id_ot;
  var tipo_mod_xygo;
  var fecha_mod_xygo;
  var nivel_agua;
  var nivel_agua_cumple_norma;
  var nivel_cloro;
  var nivel_cloro_cumple_norma;
  var acompanado_por;
  var medicion_realizada_por;
  var imagen;
  var nivel_turbiedad;
  var nivel_turbiedad_cumple_norma;
  var e_coli;
  var e_coli_cumple_norma;
  var hora_medicion;
  var ir_mapa;
  var fecha_inicio;
  var fecha_termino;
  var id_tipo_status;
  var nombre_ot;
  FaseAbastMedicion(
      {required this.id,
      required this.personal,
      required this.ubicacion,
      required this.comentario,
      required this.id_ot,
      required this.tipo_mod_xygo,
      required this.fecha_mod_xygo,
      required this.nivel_agua,
      required this.nivel_agua_cumple_norma,
      required this.nivel_cloro,
      required this.nivel_cloro_cumple_norma,
      required this.acompanado_por,
      required this.medicion_realizada_por,
      required this.imagen,
      required this.nivel_turbiedad,
      required this.nivel_turbiedad_cumple_norma,
      required this.e_coli,
      required this.e_coli_cumple_norma,
      required this.hora_medicion,
      required this.ir_mapa,
      required this.fecha_inicio,
      required this.fecha_termino,
      required this.id_tipo_status,
      required this.nombre_ot});

  factory FaseAbastMedicion.fromJson(Map<String, dynamic> json) {
    return FaseAbastMedicion(
        id: json['ID'] == null ? 0 : json['ID'],
        personal: json['PERSONAL'] == null ? 0 : json['PERSONAL'],
        ubicacion: json['UBICACION'] == null ? 0 : json['UBICACION'],
        comentario:
            json['COMENTARIO'] == null ? 'Sin datos' : json['COMENTARIO'],
        id_ot: json['ID_OT'] == null ? 0 : json['ID_OT'],
        tipo_mod_xygo:
            json['TIPO_MOD_XYGO'] == null ? 0 : json['TIPO_MOD_XYGO'],
        fecha_mod_xygo: json['FECHA_MOD_XYGO'] == null
            ? 'Sin datos'
            : json['FECHA_MOD_XYGO'],
        nivel_agua:
            json['NIVEL_AGUA'] == null ? 'Sin datos' : json['NIVEL_AGUA'],
        nivel_agua_cumple_norma: json['NIVEL_AGUA_CUMPLE_NORMA'] == null
            ? 'Sin datos'
            : json['NIVEL_AGUA_CUMPLE_NORMA'],
        nivel_cloro:
            json['NIVEL_CLORO'] == null ? 'Sin datos' : json['NIVEL_CLORO'],
        nivel_cloro_cumple_norma: json['NIVEL_CLORO_CUMPLE_NORMA'] == null
            ? 'Sin datos'
            : json['NIVEL_CLORO_CUMPLE_NORMA'],
        acompanado_por: json['ACOMPANADO_POR'] == null
            ? 'Sin datos'
            : json['ACOMPANADO_POR'],
        medicion_realizada_por: json['MEDICION_REALIZADA_POR'] == null
            ? 'Sin datos'
            : json['MEDICION_REALIZADA_POR'],
        imagen: json['IMAGEN'] == null ? 'Sin datos' : json['IMAGEN'],
        nivel_turbiedad:
            json['NIVEL_TURBIEDAD'] == null ? 0 : json['NIVEL_TURBIEDAD'],
        nivel_turbiedad_cumple_norma:
            json['NIVEL_TURBIEDAD_CUMPLE_NORMA'] == null
                ? 'Sin datos'
                : json['NIVEL_TURBIEDAD_CUMPLE_NORMA'],
        e_coli: json['E_COLI'] == null ? 0 : json['E_COLI'],
        e_coli_cumple_norma: json['E_COLI_CUMPLE_NORMA'] == null
            ? 'Sin datos'
            : json['E_COLI_CUMPLE_NORMA'],
        hora_medicion:
            json['HORA_MEDICION'] == null ? 'Sin datos' : json['HORA_MEDICION'],
        ir_mapa: json['IR_MAPA'] == null ? 'Sin datos' : json['IR_MAPA'],
        fecha_inicio: json['FECHA_INI'] == null ? 'Sin datos' : json['FECHA_INI'],
        fecha_termino: json['FECHA_FIN'] == null? 'sin datos':json['FECHA_FIN'],
        id_tipo_status: json['ID_TIPO_STATUS'] == null? 'Sin datos':json['ID_TIPO_STATUS'],
        nombre_ot: json["NOMBRE_OT"] == null
            ? 'Sin datos'
            : json["NOMBRE_OT"]);
  }
  dynamic toJson() => {
        'ID': id,
        'PERSONAL': personal,
        'UBICACION': ubicacion,
        'COMENTARIO': comentario,
        'ID_OT': id_ot,
        'TIPO_MOD_XYGO': tipo_mod_xygo,
        'FECHA_MOD_XYGO': fecha_mod_xygo,
        'NIVEL_AGUA': nivel_agua,
        'NIVEL_AGUA_CUMPLE_NORMA': nivel_agua_cumple_norma,
        'NIVEL_CLORO': nivel_cloro,
        'NIVEL_CLORO_CUMPLE_NORMA': nivel_cloro_cumple_norma,
        'ACOMPANADO_POR': acompanado_por,
        'MEDICION_REALIZADA_POR': medicion_realizada_por,
        'IMAGEN': imagen,
        'NIVEL_TURBIEDAD': nivel_turbiedad,
        'NIVEL_TURBIEDAD_CUMPLE_NORMA': nivel_turbiedad_cumple_norma,
        'E_COLI': e_coli,
        'E_COLI_CUMPLE_NORMA': e_coli_cumple_norma,
        'HORA_MEDICION': hora_medicion,
        'IR_MAPA': ir_mapa,
        'FECHA_INI': fecha_inicio,
        'FECHA_FIN': fecha_termino,
        'ID_TIPO_STATUS': id_tipo_status,
        "NOMBRE_OT": nombre_ot,
      };
}
