class Proceso {
  final id_proceso;
  final nombre_proceso;
  final descripcion_proceso;
  final fecha_ini;
  final fecha_fin;
  final id_flujo;
  final id_tipo_status;
  final fecha_mod_xygo;
  final tipo_mod_xygo;
  final nom_tabla_entidad;
  final mostrar_fecha_ini;
  final mostrar_fecha_fin;
  final campo_orden;
  final tipo_orden;

  Proceso({
    required this.id_proceso,
    required this.nombre_proceso,
    required this.descripcion_proceso,
    required this.fecha_ini,
    required this.fecha_fin,
    required this.id_flujo,
    required this.id_tipo_status,
    required this.fecha_mod_xygo,
    required this.tipo_mod_xygo,
    required this.nom_tabla_entidad,
    required this.mostrar_fecha_ini,
    required this.mostrar_fecha_fin,
    required this.campo_orden,
    required this.tipo_orden
    });

  factory Proceso.fromJson(Map<String, dynamic> json) {
    return Proceso(
        id_proceso: json['ID_PROCESO']== null ? 'Sin datos' : json['ID_PROCESO'],
        nombre_proceso: json['NOMBRE_PROCESO']== null ? 'Sin datos' : json['NOMBRE_PROCESO'],
        descripcion_proceso: json['DESCRIPCION_PROCESO']== null ? 'Sin datos' : json['DESCRIPCION_PROCESO'],
        fecha_ini: json['FECHA_INI']== null ? 'Sin datos' : json['FECHA_INI'],
        fecha_fin: json['FECHA_FIN']== null ? 'Sin datos' : json['FECHA_FIN'],
        id_flujo: json['ID_FLUJO']== null ? 'Sin datos' : json['ID_FLUJO'],
        id_tipo_status: json['ID_TIPO_STATUS']== null ? 'Sin datos' : json['ID_TIPO_STATUS'],
        fecha_mod_xygo: json['FECHA_MOD_XYGO']== null ? 'Sin datos' : json['FECHA_MOD_XYGO'],
        tipo_mod_xygo: json['TIPO_MOD_XYGO']== null ? 'Sin datos' : json['TIPO_MOD_XYGO'],
        nom_tabla_entidad: json['NOM_TABLA_ENTIDAD']== null ? 'Sin datos' : json['NOM_TABLA_ENTIDAD'],
        mostrar_fecha_ini: json['MOSTRAR_FECHA_INI']== null ? 'Sin datos' : json['MOSTRAR_FECHA_INI'],
        mostrar_fecha_fin: json['MOSTRAR_FECHA_FIN']== null ? 'Sin datos' : json['MOSTRAR_FECHA_FIN'],
        campo_orden: json['CAMPO_ORDEN']== null ? 'Sin datos' : json['CAMPO_ORDEN'],
        tipo_orden: json['TIPO_ORDEN']== null ? 'Sin datos' : json['TIPO_ORDEN']);
  }
  dynamic toJson() => {
        'ID_PROCESO': id_proceso,
        'NOMBRE_PROCESO': nombre_proceso,
        'DESCRIPCION_PROCESO': descripcion_proceso,
        'FECHA_INI': fecha_ini,
        'FECHA_FIN': fecha_fin,
        'ID_FLUJO': id_flujo,
        'ID_TIPO_STATUS': id_tipo_status,
        'FECHA_MOD_XYGO': fecha_mod_xygo,
        'TIPO_MOD_XYGO': tipo_mod_xygo,
        'NOM_TABLA_ENTIDAD': nom_tabla_entidad,
        'MOSTRAR_FECHA_INI': mostrar_fecha_ini,
        'MOSTRAR_FECHA_FIN': mostrar_fecha_fin,
        'CAMPO_ORDEN': campo_orden,
        'TIPO_ORDEN': tipo_orden
      };
}
