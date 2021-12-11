class Status {
  final id_status;
  final id_ot;
  final id_orden_status;
  final id_evento;
  final id_tipo_status;
  final fecha_mod_xygo;
  final tipo_mod_xygo;

  Status({
    required this.id_status,
    required this.id_ot,
    required this.id_orden_status,
    required this.id_evento,
    required this.id_tipo_status,
    required this.fecha_mod_xygo,
    required this.tipo_mod_xygo
    });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
        id_status: json['ID_STATUS']== null ? 'Sin datos' : json['ID_STATUS'],
        id_ot: json['ID_OT']== null ? 'Sin datos' : json['ID_OT'],
        id_orden_status: json['ID_ORDEN_STATUS']== null ? 'Sin datos' : json['ID_ORDEN_STATUS'],
        id_evento: json['ID_EVENTO']== null ? 'Sin datos' : json['ID_EVENTO'],
        id_tipo_status: json['ID_TIPO_STATUS']== null ? 'Sin datos' : json['ID_TIPO_STATUS'],
        fecha_mod_xygo: json['FECHA_MOD_XYGO']== null ? 'Sin datos' : json['FECHA_MOD_XYGO'],
        tipo_mod_xygo: json['TIPO_MOD_XYGO']== null ? 'Sin datos' : json['TIPO_MOD_XYGO']);
  }
  dynamic toJson() => {
        'ID_STATUS': id_status,
        'ID_OT': id_ot,
        'ID_ORDEN_STATUS': id_orden_status,
        'ID_EVENTO': id_evento,
        'ID_TIPO_STATUS': id_tipo_status,
        'FECHA_MOD_XYGO': fecha_mod_xygo,
        'TIPO_MOD_XYGO': tipo_mod_xygo
      };
}
