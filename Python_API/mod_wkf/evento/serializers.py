from rest_framework import serializers
from .models import camion, contratista, data_eventos, data_tk_sector

class DataTKSectorSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
            model = data_tk_sector
            fields = ('ID','ID_EVENTO','ID_SECTOR','ID_POR_EVENTO','NOMBRE_SECTOR','NOMBRE_SECTOR_CORTO','ID_TK','NOMBRE','DESCRIPCION','FECHA_CREACION','X','Y','LATITUD','LONGITUD','ID_USUARIO','ID_PERFIL','LOGIN','NOMBRE_USUARIO','APELLIDOS_USUARIO','NOMBRE_PERFIL','CALLE_1','CALLE_2','ESTADO','LON','LAT',
            #'GEOM',
            'FECHA_MOD_XYGO','TIPO_MOD_XYGO')

class ContratistaSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
            model = contratista
            #db_table = ""
            fields = ('ID','RUT','NOMBRE_COMPLETO','TELEFONO','EMAIL','SERVICIO','IDUSUARIO','SERV_INSTALACION','SERV_ABASTECIMIENTO','SERV_RETIRO','FECHA_MOD_XYGO','TIPO_MOD_XYGO')

class CamionSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
            model = camion
            #db_table = ""
            fields = ('ID','ID_CONTRATISTA','PATENTE','CAPACIDAD','LITROS_MINUTO','ID_USUARIO_CAMION','FECHA_MOD_XYGO','TIPO_MOD_XYGO')

class DataEventoSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
            model = data_eventos
            fields = ('ID_EVENTO','NUM_SISDA','ESTADO','X','Y','LATITUD','LONGITUD','LOCALIDAD','COD_LOCALIDAD','NOMBRE_COMUNA','ID_DIRECCION','DIRECCION','SECTOR_CERRO','COD_AREA','TIPO_RED','TIPO_EVENTO_DETALLE','FECHA_INICIO_SISDA','HORA_INICIO_SISDA','FECHA_INICIO','HORA_INICIO','FECHA_TERMINO','HORA_TERMINO','DURACION_DE_LA_OPERACION','DURACION','FECHA_AVISO_USUARIO','ID_EMPRESA','EMPRESA','RUT_EMPRESA','SUBGERENCIA_ZONAL_EMPRESA','CATEGORIA_CORTE','MOTIVO_CORTE','CON_SUMINISTRO_ALTERNATIVO','USAR_POLIGONO_UNICO','CAPA_ESTANQUES','DONDE','TIPO_EVENTO','ZONALES_EVENTO','COMUNAS_EVENTO','SECTORES_EVENTO','FECHA_MOD_XYGO','TIPO_MOD_XYGO')