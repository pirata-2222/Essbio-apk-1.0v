class Fase {
  final id_fase;
  final desc_fase;
  final id_flujo;
  final id_orden;
  final id_icono;
  final fecha_ini;
  final fecha_fin;
  final fecha_mod_xygo;
  final tipo_mod_xygo;
  final habilita_ver_fase;

  Fase({
    required this.id_fase,
    required this.desc_fase,
    required this.id_flujo,
    required this.id_orden,
    required this.id_icono,
    required this.fecha_ini,
    required this.fecha_fin,
    required this.fecha_mod_xygo,
    required this.tipo_mod_xygo,
    required this.habilita_ver_fase
    });

  factory Fase.fromJson(Map<String, dynamic> json) {
    return Fase(
        id_fase: json['ID_FASE']== null ? 'Sin datos' : json['ID_FASE'],
        desc_fase: json['DESC_FASE']== null ? 'Sin datos' : json['DESC_FASE'],
        id_flujo: json['ID_FLUJO']== null ? 'Sin datos' : json['ID_FLUJO'],
        id_orden: json['ID_ORDEN']== null ? 'Sin datos' : json['ID_ORDEN'],
        id_icono: json['ID_ICONO']== null ? 'Sin datos' : json['ID_ICONO'],
        fecha_ini: json['FECHA_INI']== null ? 'Sin datos' : json['FECHA_INI'],
        fecha_fin: json['FECHA_FIN']== null ? 'Sin datos' : json['FECHA_FIN'],
        fecha_mod_xygo: json['FECHA_MOD_XYGO']== null ? 'Sin datos' : json['FECHA_MOD_XYGO'],
        tipo_mod_xygo: json['TIPO_MOD_XYGO']== null ? 'Sin datos' : json['TIPO_MOD_XYGO'],
        habilita_ver_fase: json['HABILITA_VER_FASE']== null ? 'Sin datos' : json['HABILITA_VER_FASE']);
  }
  dynamic toJson() => {
        'ID_FASE': id_fase,
        'DESC_FASE': desc_fase,
        'ID_FLUJO': id_flujo,
        'ID_ORDEN': id_orden,
        'ID_ICONO': id_icono,
        'FECHA_INI': fecha_ini,
        'FECHA_FIN': fecha_fin,
        'FECHA_MOD_XYGO': fecha_mod_xygo,
        'TIPO_MOD_XYGO': tipo_mod_xygo,
        'HABILITA_VER_FASE': habilita_ver_fase
      };
}
