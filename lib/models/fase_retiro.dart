class FaseRetiro {
  final int id;
  final int contratista;
  final int ubicacion;
  final String estado_terreno;
  final String numero_estanque;
  final String comentario;
  final int id_ot;
  final String fecha_mod_xygo;
  final int tipo_mod_xygo;
  final String archivo_adjunto;
  final String ir_mapa;

  FaseRetiro({
    required this.id,
    required this.contratista,
    required this.ubicacion,
    required this.estado_terreno,
    required this.numero_estanque,
    required this.comentario,
    required this.id_ot,
    required this.fecha_mod_xygo,
    required this.tipo_mod_xygo,
    required this.archivo_adjunto,
    required this.ir_mapa
    });

  factory FaseRetiro.fromJson(Map<String, dynamic> json) {
    return FaseRetiro(
        id: json['ID']== null ? 0 : json['ID'],
        contratista: json['CONTRATISTA']== null ? 0 : json['CONTRATISTA'],
        ubicacion: json['UBICACION']== null ? 0 : json['UBICACION'],
        estado_terreno: json['ESTADO_TERRENO']== null ? 'Sin datos' : json['ESTADO_TERRENO'],
        numero_estanque: json['NUMERO_ESTANQUE']== null ? 'Sin datos' : json['NUMERO_ESTANQUE'],
        comentario: json['COMENTARIO']== null ? 'Sin datos' : json['COMENTARIO'],
        id_ot: json['ID_OT']== null ? 0 : json['ID_OT'],
        fecha_mod_xygo: json['FECHA_MOD_XYGO']== null ? 'Sin datos' : json['FECHA_MOD_XYGO'],
        tipo_mod_xygo: json['TIPO_MOD_XYGO']== null ? 0 : json['TIPO_MOD_XYGO'],
        archivo_adjunto: json['ARCHIVO_ADJUNTO']== null ? 'Sin datos' : json['ARCHIVO_ADJUNTO'],
        ir_mapa: json['IR_MAPA']== null ? 'Sin datos' : json['IR_MAPA']);
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
        'IR_MAPA': ir_mapa
      };
}
