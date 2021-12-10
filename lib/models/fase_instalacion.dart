class FaseInstalacion {
  final int id;
  final int ubicacion;
  final int estado_terreno;
  final int contratista;
  final String comentario_instalacion;
  final String rotulo_tk;
  final int id_ot;
  final int tipo_mod_xygo;
  final String fecha_mod_xygo;
  final String archivo_adjunto;
  final String ir_mapa;

  FaseInstalacion({
    required this.id,
    required this.ubicacion,
    required this.estado_terreno,
    required this.contratista,
    required this.comentario_instalacion,
    required this.rotulo_tk,
    required this.id_ot,
    required this.tipo_mod_xygo,
    required this.fecha_mod_xygo,
    required this.archivo_adjunto,
    required this.ir_mapa
  });

  factory FaseInstalacion.fromJson(Map<String, dynamic> json) {
    return FaseInstalacion(
        id: json['ID']== null ? 0 : json['ID'],
        ubicacion: json['UBICACION']== null ? 0 : json['UBICACION'],
        estado_terreno: json['ESTADO_TERRENO']== null ? 0 : json['ESTADO_TERRENO'],
        contratista: json['CONTRATISTA']== null ? 0 : json['CONTRATISTA'],
        comentario_instalacion: json['COMENTARIO_INSTALACION']== null ? 'Sin datos' : json['COMENTARIO_INSTALACION'],
        rotulo_tk: json['ROTULO_TK']== null ? 'Sin datos' : json['ROTULO_TK'],
        id_ot: json['ID_OT']== null ? 0 : json['ID_OT'],
        tipo_mod_xygo: json['TIPO_MOD_XYGO']== null ? 0 : json['TIPO_MOD_XYGO'],
        fecha_mod_xygo: json['FECHA_MOD_XYGO']== null ? 'Sin datos' : json['FECHA_MOD_XYGO'],
        archivo_adjunto: json['ARCHIVO_ADJUNTO']== null ? 'Sin datos' : json['ARCHIVO_ADJUNTO'],
        ir_mapa: json['IR_MAPA']== null ? 'Sin datos' : json['IR_MAPA']);
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
        'IR_MAPA': ir_mapa
      };
}
