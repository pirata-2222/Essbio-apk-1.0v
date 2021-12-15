class DataEventos {
  final id_evento;
  final num_sisda;
  final estado;
  final x;
  final y;
  final latitud;
  final longitud;
  final localidad;
  final cod_localidad;
  final nombre_comuna;
  final id_direccion;
  final direccion;
  final sector_cerro;
  final cod_area;
  final tipo_red;
  final tipo_evento_detalle;
  final fecha_inicio_sisda;
  final hora_inicio_sisda;
  final fecha_inicio;
  final hora_inicio;
  final fecha_termino;
  final hora_termino;
  final duracion_de_la_operacion;
  final duracion;
  final fecha_aviso_usuario;
  final id_empresa;
  final empresa;
  final rut_empresa;
  final subgerencia_zonal_empresa;
  final categoria_corte;
  final motivo_corte;
  final con_suministro_alternativo;
  final usar_poligono_unico;
  final capa_estanques;
  final donde;
  final tipo_evento;
  final zonales_evento;
  final comunas_evento;
  final sectores_evento;
  final fecha_mod_xygo;
  final tipo_mod_xygo;

  DataEventos({
    required this.id_evento,
    required this.num_sisda,
    required this.estado,
    required this.x,
    required this.y,
    required this.latitud,
    required this.longitud,
    required this.localidad,
    required this.cod_localidad,
    required this.nombre_comuna,
    required this.id_direccion,
    required this.direccion,
    required this.sector_cerro,
    required this.cod_area,
    required this.tipo_red,
    required this.tipo_evento_detalle,
    required this.fecha_inicio_sisda,
    required this.hora_inicio_sisda,
    required this.fecha_inicio,
    required this.hora_inicio,
    required this.fecha_termino,
    required this.hora_termino,
    required this.duracion_de_la_operacion,
    required this.duracion,
    required this.fecha_aviso_usuario,
    required this.id_empresa,
    required this.empresa,
    required this.rut_empresa,
    required this.subgerencia_zonal_empresa,
    required this.categoria_corte,
    required this.motivo_corte,
    required this.con_suministro_alternativo,
    required this.usar_poligono_unico,
    required this.capa_estanques,
    required this.donde,
    required this.tipo_evento,
    required this.zonales_evento,
    required this.comunas_evento,
    required this.sectores_evento,
    required this.fecha_mod_xygo,
    required this.tipo_mod_xygo,
  });

  factory DataEventos.fromJson(Map<String, dynamic> json) {
    return DataEventos(
        id_evento: json['ID_EVENTO']== null ? 0 : json['ID_EVENTO'],
        num_sisda: json['NUM_SISDA']== null ? 0 : json['NUM_SISDA'],
        estado: json['ESTADO']== null ? 'Sin datos' : json['ESTADO'],
        x: json['X']== null ? 'Sin datos' : json['X'],
        y: json['Y']== null ? 'Sin datos' : json['Y'],
        latitud: json['LATITUD']== null ? 'Sin datos' : json['LATITUD'],
        longitud: json['LONGITUD']== null ? 'Sin datos' : json['LONGITUD'],
        localidad: json['LOCALIDAD']== null ? 'Sin datos' : json['LOCALIDAD'],
        cod_localidad: json['COD_LOCALIDAD']== null ? 'Sin datos' : json['COD_LOCALIDAD'],
        nombre_comuna: json['NOMBRE_COMUNA']== null ? 'Sin datos' : json['NOMBRE_COMUNA'],
        id_direccion: json['ID_DIRECCION']== null ? 'Sin datos' : json['ID_DIRECCION'],
        direccion: json['DIRECCION']== null ? 'Sin datos' : json['DIRECCION'],
        sector_cerro: json['SECTOR_CERRO']== null ? 'Sin datos' : json['SECTOR_CERRO'],
        cod_area: json['COD_AREA']== null ? 'Sin datos' : json['COD_AREA'],
        tipo_red: json['TIPO_RED']== null ? 'Sin datos' : json['TIPO_RED'],
        tipo_evento_detalle: json['TIPO_EVENTO_DETALLE']== null ? 'Sin datos' : json['TIPO_EVENTO_DETALLE'],
        fecha_inicio_sisda: json['FECHA_INICIO_SISDA']== null ? 'Sin datos' : json['FECHA_INICIO_SISDA'],
        hora_inicio_sisda: json['HORA_INICIO_SISDA']== null ? 'Sin datos' : json['HORA_INICIO_SISDA'],
        fecha_inicio: json['FECHA_INICIO']== null ? 'Sin datos' : json['FECHA_INICIO'],
        hora_inicio: json['HORA_INICIO']== null ? 'Sin datos' : json['HORA_INICIO'],
        fecha_termino: json['FECHA_TERMINO']== null ? 'Sin datos' : json['FECHA_TERMINO'],
        hora_termino: json['HORA_TERMINO']== null ? 'Sin datos' : json['HORA_TERMINO'],
        duracion_de_la_operacion: json['DURACION_DE_LA_OPERACION']== null ? 'Sin datos' : json['DURACION_DE_LA_OPERACION'],
        duracion: json['DURACION']== null ? 'Sin datos' : json['DURACION'],
        fecha_aviso_usuario: json['FECHA_AVISO_USUARIO']== null ? 'Sin datos' : json['FECHA_AVISO_USUARIO'],
        id_empresa: json['ID_EMPRESA']== null ? 'Sin datos' : json['ID_EMPRESA'],
        empresa: json['EMPRESA']== null ? 'Sin datos' : json['EMPRESA'],
        rut_empresa: json['RUT_EMPRESA']== null ? 'Sin datos' : json['RUT_EMPRESA'],
        subgerencia_zonal_empresa: json['SUBGERENCIA_ZONAL_EMPRESA']== null ? 'Sin datos' : json['SUBGERENCIA_ZONAL_EMPRESA'],
        categoria_corte: json['CATEGORIA_CORTE']== null ? 'Sin datos' : json['CATEGORIA_CORTE'],
        motivo_corte: json['MOTIVO_CORTE']== null ? 'Sin datos' : json['MOTIVO_CORTE'],
        con_suministro_alternativo: json['CON_SUMINISTRO_ALTERNATIVO']== null ? 'Sin datos' : json['CON_SUMINISTRO_ALTERNATIVO'],
        usar_poligono_unico: json['USAR_POLIGONO_UNICO']== null ? 'Sin datos' : json['USAR_POLIGONO_UNICO'],
        capa_estanques: json['CAPA_ESTANQUES']== null ? 'Sin datos' : json['CAPA_ESTANQUES'],
        donde: json['DONDE']== null ? 'Sin datos' : json['DONDE'],
        tipo_evento: json['TIPO_EVENTO']== null ? 'Sin datos' : json['TIPO_EVENTO'],
        zonales_evento: json['ZONALES_EVENTO']== null ? 'Sin datos' : json['ZONALES_EVENTO'],
        comunas_evento: json['COMUNAS_EVENTO']== null ? 'Sin datos' : json['COMUNAS_EVENTO'],
        sectores_evento: json['SECTORES_EVENTO']== null ? 'Sin datos' : json['SECTORES_EVENTO'],
        fecha_mod_xygo: json['FECHA_MOD_XYGO']== null ? 'Sin datos' : json['FECHA_MOD_XYGO'],
        tipo_mod_xygo: json['TIPO_MOD_XYGO']== null ? 0 : json['TIPO_MOD_XYGO']);
  }
  dynamic toJson() => {
        'ID_EVENTO': id_evento,
        'NUM_SISDA': num_sisda,
        'ESTADO': estado,
        'X': x,
        'Y': y,
        'LATITUD': latitud,
        'LONGITUD': longitud,
        'LOCALIDAD': localidad,
        'COD_LOCALIDAD': cod_localidad,
        'NOMBRE_COMUNA': nombre_comuna,
        'ID_DIRECCION': id_direccion,
        'DIRECCION': direccion,
        'SECTOR_CERRO': sector_cerro,
        'COD_AREA': cod_area,
        'TIPO_RED': tipo_red,
        'TIPO_EVENTO_DETALLE': tipo_evento_detalle,
        'FECHA_INICIO_SISDA': fecha_inicio_sisda,
        'HORA_INICIO_SISDA': hora_inicio_sisda,
        'FECHA_INICIO': fecha_inicio,
        'HORA_INICIO': hora_inicio,
        'FECHA_TERMINO': fecha_termino,
        'HORA_TERMINO': hora_termino,
        'DURACION_DE_LA_OPERACION': duracion_de_la_operacion,
        'DURACION': duracion,
        'FECHA_AVISO_USUARIO': fecha_aviso_usuario,
        'ID_EMPRESA': id_empresa,
        'EMPRESA': empresa,
        'RUT_EMPRESA': rut_empresa,
        'SUBGERENCIA_ZONAL_EMPRESA': subgerencia_zonal_empresa,
        'CATEGORIA_CORTE': categoria_corte,
        'MOTIVO_CORTE': motivo_corte,
        'CON_SUMINISTRO_ALTERNATIVO': con_suministro_alternativo,
        'USAR_POLIGONO_UNICO': usar_poligono_unico,
        'CAPA_ESTANQUES': capa_estanques,
        'DONDE': donde,
        'TIPO_EVENTO': tipo_evento,
        'ZONALES_EVENTO': zonales_evento,
        'COMUNAS_EVENTO': comunas_evento,
        'SECTORES_EVENTO': sectores_evento,
        'FECHA_MOD_XYGO': fecha_mod_xygo,
        'TIPO_MOD_XYGO': tipo_mod_xygo
      };
}
