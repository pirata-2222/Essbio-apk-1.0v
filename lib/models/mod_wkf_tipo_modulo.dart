class TipoModulo {
  final int id_tipo_modulo;
  final String nombre;
  final int id_modulo;

  TipoModulo({
    required this.id_tipo_modulo,
    required this.nombre,
    required this.id_modulo
    });

  factory TipoModulo.fromJson(Map<String, dynamic> json) {
    return TipoModulo(
        id_tipo_modulo: json['ID_TIPO_MODULO']== null ? 0 : json['ID_TIPO_MODULO'],
        nombre: json['NOMBRE']== null ? 'Sin datos' : json['NOMBRE'],
        id_modulo: json['ID_MODULO']== null ? 0 : json['ID_MODULO']);
  }
  dynamic toJson() => {
        'ID_TIPO_MODULO': id_tipo_modulo,
        'NOMBRE': nombre,
        'ID_MODULO': id_modulo
      };
}
