class OrdenTrabajo {
  final int id_ot;
  final String nombre_ot;
  final String nombre_resumen;
  final int id_fase;
  final int id_responsable;
  final int id_icono;
  final int id_status;
  final int orden;
  final String fecha_mod_xygo;
  final int tipo_mod_xygo;
  final int id_reporte_historico;
  final int habilita_ver_orden;
  final int es_ot_inicial;

  OrdenTrabajo({
    required this.id_ot,
    required this.nombre_ot,
    required this.nombre_resumen,
    required this.id_fase,
    required this.id_responsable,
    required this.id_icono,
    required this.id_status,
    required this.orden,
    required this.fecha_mod_xygo,
    required this.tipo_mod_xygo,
    required this.id_reporte_historico,
    required this.habilita_ver_orden,
    required this.es_ot_inicial,
  });

  factory OrdenTrabajo.fromJson(Map<String, dynamic> json) {
    return OrdenTrabajo(
        id_ot: json["ID_OT"] == null ? 0 : json["ID_OT"],
        nombre_ot: json["NOMBRE_OT"] == null ? "Sin datos" : json["NOMBRE_OT"],
        nombre_resumen: json["NOMBRE_RESUMEN"] == null
            ? "Sin datos"
            : json["NOMBRE_RESUMEN"],
        id_fase: json["ID_FASE"] == null ? 0 : json["ID_FASE"],
        id_responsable:
            json["ID_RESPONSABLE"] == null ? 0 : json["ID_RESPONSABLE"],
        id_icono: json["ID_ICONO"] == null ? 0 : json["ID_ICONO"],
        id_status: json["ID_STATUS"] == null ? 0 : json["ID_STATUS"],
        orden: json["ORDEN"] == null ? 0 : json["ORDEN"],
        fecha_mod_xygo:
            json["FECHA_MOD_XYGO"] == null ? "" : json["FECHA_MOD_XYGO"],
        tipo_mod_xygo:
            json["TIPO_MOD_XYGO"] == null ? 0 : json["TIPO_MOD_XYGO"],
        id_reporte_historico: json["ID_REPORTE_HISTORICO"] == null
            ? 0
            : json["ID_REPORTE_HISTORICO"],
        habilita_ver_orden:
            json["HABILITA_VER_ORDEN"] == null ? 0 : json["HABILITA_VER_ORDEN"],
        es_ot_inicial:
            json["ES_OT_INICIAL"] == null ? 0 : json["ES_OT_INICIAL"]);
  }
  dynamic toJson() => {
        "ID_OT": id_ot,
        "NOMBRE_OT": nombre_ot,
        "NOMBRE_RESUMEN": nombre_resumen,
        "ID_FASE": id_fase,
        "ID_RESPONSABLE": id_responsable,
        "ID_ICONO": id_icono,
        "ID_STATUS": id_status,
        "ORDEN": orden,
        "FECHA_MOD_XYGO": fecha_mod_xygo,
        "TIPO_MOD_XYGO": tipo_mod_xygo,
        "ID_RESPORTE_HISTORICO": id_reporte_historico,
        "HABILITA_VER_ORDEN": habilita_ver_orden,
        "ES_OT_INICIAL": es_ot_inicial
      };
}
