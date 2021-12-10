class FaseAbastMedicion {
  final int id;
  final int personal;
  final int ubicacion;
  final String comentario;
  final int id_ot;
  final int tipo_mod_xygo;
  final String fecha_mod_xygo;
  final String nivel_agua;
  final String nivel_agua_cumple_norma;
  final String nivel_cloro;
  final String nivel_cloro_cumple_norma;
  final String acompanado_por;
  final String medicion_realizada_por;
  final String imagen;
  final int nivel_turbiedad;
  final String nivel_turbiedad_cumple_norma;
  final int e_coli;
  final String e_coli_cumple_norma;
  final String hora_medicion;
  final String ir_mapa;

  FaseAbastMedicion({
    required this.id,
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
    required this.ir_mapa
  });

  factory FaseAbastMedicion.fromJson(Map<String, dynamic> json) {
    return FaseAbastMedicion(
        id: json['ID']== null ? 0 : json['ID'],
        personal: json['PERSONAL']== null ? 0 : json['PERSONAL'],
        ubicacion: json['UBICACION']== null ? 0 : json['UBICACION'],
        comentario: json['COMENTARIO']== null ? 'Sin datos' : json['COMENTARIO'],
        id_ot: json['ID_OT']== null ? 0 : json['ID_OT'],
        tipo_mod_xygo: json['TIPO_MOD_XYGO']== null ? 0 : json['TIPO_MOD_XYGO'],
        fecha_mod_xygo: json['FECHA_MOD_XYGO']== null ? 'Sin datos' : json['FECHA_MOD_XYGO'],
        nivel_agua: json['NIVEL_AGUA']== null ? 'Sin datos' : json['NIVEL_AGUA'],
        nivel_agua_cumple_norma: json['NIVEL_AGUA_CUMPLE_NORMA']== null ? 'Sin datos' : json['NIVEL_AGUA_CUMPLE_NORMA'],
        nivel_cloro: json['NIVEL_CLORO']== null ? 'Sin datos' : json['NIVEL_CLORO'],
        nivel_cloro_cumple_norma: json['NIVEL_CLORO_CUMPLE_NORMA']== null ? 'Sin datos' : json['NIVEL_CLORO_CUMPLE_NORMA'],
        acompanado_por: json['ACOMPANADO_POR']== null ? 'Sin datos' : json['ACOMPANADO_POR'],
        medicion_realizada_por: json['MEDICION_REALIZADA_POR']== null ? 'Sin datos' : json['MEDICION_REALIZADA_POR'],
        imagen: json['IMAGEN']== null ? 'Sin datos' : json['IMAGEN'],
        nivel_turbiedad: json['NIVEL_TURBIEDAD']== null ? 0 : json['NIVEL_TURBIEDAD'],
        nivel_turbiedad_cumple_norma: json['NIVEL_TURBIEDAD_CUMPLE_NORMA']== null ? 'Sin datos' : json['NIVEL_TURBIEDAD_CUMPLE_NORMA'],
        e_coli: json['E_COLI']== null ? 0 : json['E_COLI'],
        e_coli_cumple_norma: json['E_COLI_CUMPLE_NORMA']== null ? 'Sin datos' : json['E_COLI_CUMPLE_NORMA'],
        hora_medicion: json['HORA_MEDICION']== null ? 'Sin datos' : json['HORA_MEDICION'],
        ir_mapa: json['IR_MAPA']== null ? 'Sin datos' : json['IR_MAPA']);
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
        'IR_MAPA': ir_mapa
      };
}
