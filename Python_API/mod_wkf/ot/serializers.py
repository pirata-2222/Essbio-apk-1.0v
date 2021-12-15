from rest_framework import serializers
from .models import fase_abast_medicion, fase_instalacion, fase_abastecimiento, fase_retiro

class FaseInstalacionSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
            model = fase_instalacion
            #db_table = ""
            fields = ('ID','UBICACION','ESTADO_TERRENO','CONTRATISTA','COMENTARIO_INSTALACION','ROTULO_TK','ID_OT','TIPO_MOD_XYGO','FECHA_MOD_XYGO','ARCHIVO_ADJUNTO','IR_MAPA')

class FaseAbastecimientoSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
            model = fase_abastecimiento
            #db_table = ""
            fields = ('ID','UBICACION','CONTRATISTA','ESTADO_OT','PATENTE_CAMION_OT','CAPACIDAD_LITROS','CANTIDAD_CARGAS_EFECT','COMENTARIO','ID_OT','TIPO_MOD_XYGO','FECHA_MOD_XYGO','IR_MAPA')

class FaseAbastMedicionSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
            model = fase_abast_medicion
            #db_table = ""
            fields = ('ID','PERSONAL','UBICACION','COMENTARIO','ID_OT','TIPO_MOD_XYGO','FECHA_MOD_XYGO','NIVEL_AGUA','NIVEL_AGUA_CUMPLE_NORMA','NIVEL_CLORO','NIVEL_CLORO_CUMPLE_NORMA','ACOMPANADO_POR','MEDICION_REALIZADA_POR','IMAGEN','NIVEL_TURBIEDAD','NIVEL_TURBIEDAD_CUMPLE_NORMA','E_COLI','E_COLI_CUMPLE_NORMA','HORA_MEDICION','IR_MAPA')

class FaseRetiroSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
            model = fase_retiro
            #db_table = ""
            fields = ('ID','CONTRATISTA','UBICACION','ESTADO_TERRENO','NUMERO_ESTANQUE','COMENTARIO','ID_OT','FECHA_MOD_XYGO','TIPO_MOD_XYGO','ARCHIVO_ADJUNTO','IR_MAPA')