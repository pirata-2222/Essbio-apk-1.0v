class Contratista {
  final id;
  final rut;
  final nombre_completo;
  final telefono;
  final email;
  final servicio;
  final idusuario;
  final serv_instalacion;
  final serv_abastecimiento;
  final serv_retiro;
  final fecha_mod_xygo;
  final tipo_mod_xygo;

  Contratista(
      {required this.id,
      required this.rut,
      required this.nombre_completo,
      required this.telefono,
      required this.email,
      required this.servicio,
      required this.idusuario,
      required this.serv_instalacion,
      required this.serv_abastecimiento,
      required this.serv_retiro,
      required this.fecha_mod_xygo,
      required this.tipo_mod_xygo});

  factory Contratista.fromJson(Map<String, dynamic> json) {
    return Contratista(
        id: json['ID'] == null ? 'Sin datos' : json['ID'],
        rut: json['RUT'] == null ? 'Sin datos' : json['RUT'],
        nombre_completo: json['NOMBRE_COMPLETO'] == null
            ? 'Sin datos'
            : json['NOMBRE_COMPLETO'],
        telefono: json['TELEFONO'] == null ? 'Sin datos' : json['TELEFONO'],
        email: json['EMAIL'] == null ? 'Sin datos' : json['EMAIL'],
        servicio: json['SERVICIO'] == null ? 'Sin datos' : json['SERVICIO'],
        idusuario: json['IDUSUARIO'] == null ? 'Sin datos' : json['IDUSUARIO'],
        serv_instalacion: json['SERV_INSTALACION'] == null
            ? 'Sin datos'
            : json['SERV_INSTALACION'],
        serv_abastecimiento: json['SERV_ABASTECIMIENTO'] == null
            ? 'Sin datos'
            : json['SERV_ABASTECIMIENTO'],
        serv_retiro:
            json['SERV_RETIRO'] == null ? 'Sin datos' : json['SERV_RETIRO'],
        fecha_mod_xygo: json['FECHA_MOD_XYGO'] == null
            ? 'Sin datos'
            : json['FECHA_MOD_XYGO'],
        tipo_mod_xygo: json['TIPO_MOD_XYGO'] == null
            ? 'Sin datos'
            : json['TIPO_MOD_XYGO']);
  }
  dynamic toJson() => {
        'ID': id,
        'RUT': rut,
        'NOMBRE_COMPLETO': nombre_completo,
        'TELEFONO': telefono,
        'EMAIL': email,
        'SERVICIO': servicio,
        'IDUSUARIO': idusuario,
        'SERV_INSTALACION': serv_instalacion,
        'SERV_ABASTECIMIENTO': serv_abastecimiento,
        'SERV_RETIRO': serv_retiro,
        'FECHA_MOD_XYGO': fecha_mod_xygo,
        'TIPO_MOD_XYGO': tipo_mod_xygo
      };
}
