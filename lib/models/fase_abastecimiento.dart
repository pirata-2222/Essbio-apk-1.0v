class FaseAbastecimiento {
  final int id;
  final int ubicacion;
  final int contratista;
  final int estado_ot;
  final String patente_camion_ot;
  final String capacidad_litros;
  final int cantidad_cargas_efect;
  final String comentario;
  final int id_ot;
  final int tipo_mod_xygo;
  final String fecha_mod_xygo;
  final String ir_mapa;

  FaseAbastecimiento({
    required this.id,
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
    required this.ir_mapa
  });

  factory FaseAbastecimiento.fromJson(Map<String, dynamic> json) {
    return FaseAbastecimiento(
        id: json['ID']== null ? 0 : json['ID'],
        ubicacion: json['UBICACION']== null ? 0 : json['UBICACION'],
        contratista: json['CONTRATISTA']== null ? 0 : json['CONTRATISTA'],
        estado_ot: json['ESTADO_OT']== null ? 0 : json['ESTADO_OT'],
        patente_camion_ot: json['PATENTE_CAMION_OT']== null ? 'Sin datos' : json['PATENTE_CAMION_OT'],
        capacidad_litros: json['CAPACIDAD_LITROS']== null ? 'Sin datos' : json['CAPACIDAD_LITROS'],
        cantidad_cargas_efect: json['CANTIDAD_CARGAS_EFECT']== null ? 0 : json['CANTIDAD_CARGAS_EFECT'],
        comentario: json['COMENTARIO']== null ? 'Sin datos' : json['COMENTARIO'],
        id_ot: json['ID_OT']== null ? 0 : json['ID_OT'],
        tipo_mod_xygo: json['TIPO_MOD_XYGO']== null ? 0 : json['TIPO_MOD_XYGO'],
        fecha_mod_xygo: json['FECHA_MOD_XYGO']== null ? 'Sin datos' : json['FECHA_MOD_XYGO'],
        ir_mapa: json['IR_MAPA']== null ? 'Sin datos' : json['IR_MAPA']);
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
        'IR_MAPA': ir_mapa
      };
}
