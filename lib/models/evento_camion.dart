class Camion {
  final id;
  final id_contratista;
  final patente;
  final capacidad;
  final litros_minuto;
  final id_usuario_camion;
  final fecha_mod_xygo;
  final tipo_mod_xygo;

  Camion({
    required this.id,
    required this.id_contratista,
    required this.patente,
    required this.capacidad,
    required this.litros_minuto,
    required this.id_usuario_camion,
    required this.fecha_mod_xygo,
    required this.tipo_mod_xygo
  });

  factory Camion.fromJson(Map<String, dynamic> json) {
    return Camion(
        id: json['ID']== null ? 'Sin datos' : json['ID'],
        id_contratista: json['ID_CONTRATISTA']== null ? 'Sin datos' : json['ID_CONTRATISTA'],
        patente: json['PATENTE']== null ? 'Sin datos' : json['PATENTE'],
        capacidad: json['CAPACIDAD']== null ? 'Sin datos' : json['CAPACIDAD'],
        litros_minuto: json['LITROS_MINUTO']== null ? 'Sin datos' : json['LITROS_MINUTO'],
        id_usuario_camion: json['ID_USUARIO_CAMION']== null ? 'Sin datos' : json['ID_USUARIO_CAMION'],
        fecha_mod_xygo: json['FECHA_MOD_XYGO']== null ? 'Sin datos' : json['FECHA_MOD_XYGO'],
        tipo_mod_xygo: json['TIPO_MOD_XYGO']== null ? 'Sin datos' : json['TIPO_MOD_XYGO']);
  }
  dynamic toJson() => {
        'ID': id,
        'ID_CONTRATISTA': id_contratista,
        'PATENTE': patente,
        'CAPACIDAD': capacidad,
        'LITROS_MINUTO': litros_minuto,
        'ID_USUARIO_CAMION': id_usuario_camion,
        'FECHA_MOD_XYGO': fecha_mod_xygo,
        'TIPO_MOD_XYGO': tipo_mod_xygo
      };
}
