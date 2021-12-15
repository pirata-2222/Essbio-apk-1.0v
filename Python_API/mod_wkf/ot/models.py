from django.db import models

class fase_instalacion(models.Model):
    ID = models.IntegerField(primary_key=True, blank=True)
    UBICACION = models.IntegerField(blank=True)
    ESTADO_TERRENO = models.IntegerField(blank=True)
    CONTRATISTA = models.IntegerField(blank=True)
    COMENTARIO_INSTALACION = models.CharField(max_length=2000, blank=True)
    ROTULO_TK = models.TextField(max_length=2000, blank=True)
    ID_OT = models.IntegerField(blank=True)
    TIPO_MOD_XYGO = models.IntegerField(blank=True)
    FECHA_MOD_XYGO = models.DateTimeField(blank=True)
    ARCHIVO_ADJUNTO = models.TextField(blank=True)
    IR_MAPA = models.CharField(max_length=100, blank=True)

    def __str__(self):
        name = self.ID
        return name

class fase_abastecimiento(models.Model):
    ID = models.IntegerField(primary_key=True, blank=True)
    UBICACION = models.IntegerField(blank=True)
    CONTRATISTA = models.IntegerField(blank=True)
    ESTADO_OT = models.IntegerField(blank=True)
    PATENTE_CAMION_OT = models.CharField(max_length=50, blank=True)
    CAPACIDAD_LITROS = models.CharField(max_length=50, blank=True)
    CANTIDAD_CARGAS_EFECT = models.IntegerField(blank=True)
    COMENTARIO = models.CharField(max_length=2000, blank=True)
    ID_OT = models.IntegerField(blank=True)
    TIPO_MOD_XYGO = models.IntegerField(blank=True)
    FECHA_MOD_XYGO = models.DateTimeField(blank=True)
    IR_MAPA = models.CharField(max_length=100, blank=True)

    def __str__(self):
        name = self.ID
        return name

class fase_abast_medicion(models.Model):
    ID = models.IntegerField(primary_key=True, blank=True)
    PERSONAL = models.IntegerField(blank=True)
    UBICACION = models.IntegerField(blank=True)
    COMENTARIO = models.CharField(max_length=2000, blank=True)
    ID_OT = models.IntegerField(blank=True)
    TIPO_MOD_XYGO = models.IntegerField(blank=True)
    FECHA_MOD_XYGO = models.DateTimeField(blank=True)
    NIVEL_AGUA = models.CharField(max_length=200, blank=True)
    NIVEL_AGUA_CUMPLE_NORMA = models.CharField(max_length=2, blank=True)
    NIVEL_CLORO = models.CharField(max_length=200, blank=True)
    NIVEL_CLORO_CUMPLE_NORMA = models.CharField(max_length=2, blank=True)
    ACOMPANADO_POR = models.CharField(max_length=200, blank=True)
    MEDICION_REALIZADA_POR = models.CharField(max_length=200, blank=True)
    IMAGEN = models.TextField(blank=True)
    NIVEL_TURBIEDAD = models.IntegerField(blank=True)
    NIVEL_TURBIEDAD_CUMPLE_NORMA = models.CharField(max_length=2, blank=True)
    E_COLI = models.IntegerField(blank=True)
    E_COLI_CUMPLE_NORMA = models.CharField(max_length=2, blank=True)
    HORA_MEDICION = models.CharField(max_length=10, blank=True)
    IR_MAPA = models.CharField(max_length=100, blank=True)

    def __str__(self):
        name = self.ID
        return name

class fase_retiro(models.Model):
    ID = models.IntegerField(primary_key=True, blank=True)
    CONTRATISTA = models.IntegerField(blank=True)
    UBICACION = models.IntegerField(blank=True)
    ESTADO_TERRENO = models.CharField(max_length=20, blank=True)
    NUMERO_ESTANQUE = models.CharField(max_length=20, blank=True)
    COMENTARIO = models.CharField(max_length=200, blank=True)
    ID_OT = models.IntegerField(blank=True)
    FECHA_MOD_XYGO = models.DateTimeField(blank=True)
    TIPO_MOD_XYGO = models.IntegerField(blank=True)
    ARCHIVO_ADJUNTO = models.TextField(blank=True)
    IR_MAPA = models.CharField(max_length=100, blank=True)

    def __str__(self):
        name = self.ID
        return name