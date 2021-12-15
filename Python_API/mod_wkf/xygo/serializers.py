from rest_framework import serializers
from .models import usuarios
class UsuarioSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
            model = usuarios
            fields = ('IDUSUARIO','NOMUSUARIO','CLAVE','NOMBRES','APELLIDOS','RUT','TELEFONOS','EMAIL','FECHANACIMIENTO','ACTIVO','FECHACREACION','FECHAULTIMOINGRESO','FECHAEXPIRA','PERFIL_IDPERFIL','ELIMINADO','MOBILE','COMUNA','REGION','TIPO_MOD_XYGO','FECHA_MOD_XYGO')