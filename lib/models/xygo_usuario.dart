class Usuario {
  final int idusuario;
  final String nomusuario;
  final String clave;
  final String nombres;
  final String apellidos;
  final String rut;
  final String telefonos;
  final String email;
  final String fechanacimiento;
  final String activo;
  final String fechacreacion;
  final String fechaultimoingreso;
  final String fechaexpira;
  final int perfil_idperfil;
  final int eliminado;
  final String mobile;
  final String comuna;
  final String region;
  final int tipo_mod_xygo;
  final String fecha_mod_xygo;

  Usuario({
    required this.idusuario,
    required this.nomusuario,
    required this.clave,
    required this.nombres,
    required this.apellidos,
    required this.rut,
    required this.telefonos,
    required this.email,
    required this.fechanacimiento,
    required this.activo,
    required this.fechacreacion,
    required this.fechaultimoingreso,
    required this.fechaexpira,
    required this.perfil_idperfil,
    required this.eliminado,
    required this.mobile,
    required this.comuna,
    required this.region,
    required this.tipo_mod_xygo,
    required this.fecha_mod_xygo
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
        idusuario: json['IDUSUARIO']== null ? 0 : json['IDUSUARIO'],
        nomusuario: json['NOMUSUARIO']== null ? 'Sin datos' : json['NOMUSUARIO'],
        clave: json['CLAVE']== null ? 'Sin datos' : json['CLAVE'],
        nombres: json['NOMBRES']== null ? 'Sin datos' : json['NOMBRES'],
        apellidos: json['APELLIDOS']== null ? 'Sin datos' : json['APELLIDOS'],
        rut: json['RUT']== null ? 'Sin datos' : json['RUT'],
        telefonos: json['TELEFONOS']== null ? 'Sin datos' : json['TELEFONOS'],
        email: json['EMAIL']== null ? 'Sin datos' : json['EMAIL'],
        fechanacimiento: json['FECHANACIMIENTO']== null ? 'Sin datos' : json['FECHANACIMIENTO'],
        activo: json['ACTIVO']== null ? 'Sin datos' : json['ACTIVO'],
        fechacreacion: json['FECHACREACION']== null ? 'Sin datos' : json['FECHACREACION'],
        fechaultimoingreso: json['FECHAULTIMOINGRESO']== null ? 'Sin datos' : json['FECHAULTIMOINGRESO'],
        fechaexpira: json['FECHAEXPIRA']== null ? 'Sin datos' : json['FECHAEXPIRA'],
        perfil_idperfil: json['PERFIL_IDPERFIL']== null ? 0 : json['PERFIL_IDPERFIL'],
        eliminado: json['ELIMINADO']== null ? 0 : json['ELIMINADO'],
        mobile: json['MOBILE']== null ? 'Sin datos' : json['MOBILE'],
        comuna: json['COMUNA']== null ? 'Sin datos' : json['COMUNA'],
        region: json['REGION']== null ? 'Sin datos' : json['REGION'],
        tipo_mod_xygo: json['TIPO_MOD_XYGO']== null ? 0 : json['TIPO_MOD_XYGO'],
        fecha_mod_xygo: json['FECHA_MOD_XYGO']== null ? 'Sin datos' : json['FECHA_MOD_XYGO']);
  }
  dynamic toJson() => {
        'IDUSUARIO': idusuario,
        'NOMUSUARIO': nomusuario,
        'CLAVE': clave,
        'NOMBRES': nombres,
        'APELLIDOS': apellidos,
        'RUT': rut,
        'TELEFONOS': telefonos,
        'EMAIL': email,
        'FECHANACIMIENTO': fechanacimiento,
        'ACTIVO': activo,
        'FECHACREACION': fechacreacion,
        'FECHAULTIMOINGRESO': fechaultimoingreso,
        'FECHAEXPIRA': fechaexpira,
        'PERFIL_IDPERFIL': perfil_idperfil,
        'ELIMINADO': eliminado,
        'MOBILE': mobile,
        'COMUNA': comuna,
        'REGION': region,
        'TIPO_MOD_XYGO': tipo_mod_xygo,
        'FECHA_MOD_XYGO': fecha_mod_xygo
      };
}
