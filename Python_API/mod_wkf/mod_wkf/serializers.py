from rest_framework import serializers
from .models import fase, orden_trabajo, status, tipo_modulo

class ModWkfOrdenTrabajoSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
            model = orden_trabajo
            fields = (
                'ID_OT', 
                'NOMBRE_OT', 
                'NOMBRE_RESUMEN', 
                'ID_FASE', 
                'ID_RESPONSABLE', 
                'ID_ICONO', 
                'ID_STATUS', 
                'ORDEN', 
                'FECHA_MOD_XYGO', 
                'TIPO_MOD_XYGO', 
                'ID_REPORTE_HISTORICO', 
                'HABILITA_VER_ORDEN', 
                'ES_OT_INICIAL'
                )

class TipoModuloSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
            model = tipo_modulo
            #db_table = ""
            fields = ('ID_TIPO_MODULO','NOMBRE','ID_MODULO')

class StatusSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
            model = status
            #db_table = ""
            fields = ('ID_STATUS','ID_OT','ID_ORDEN_STATUS','ID_EVENTO','ID_TIPO_STATUS','FECHA_MOD_XYGO','TIPO_MOD_XYGO')


class FaseSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
            model = fase
            #db_table = ""
            fields = ('ID_FASE','DESC_FASE','ID_FLUJO','ID_ORDEN','ID_ICONO','FECHA_INI','FECHA_FIN','FECHA_MOD_XYGO','TIPO_MOD_XYGO','HABILITA_VER_FASE')