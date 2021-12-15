from django.db import models

class orden_trabajo(models.Model):
    ID_OT = models.IntegerField(primary_key=True, blank=True)
    NOMBRE_OT = models.CharField(max_length=80, blank=True)
    NOMBRE_RESUMEN = models.CharField(max_length=50, blank=True)
    ID_FASE = models.IntegerField(blank=True)
    ID_RESPONSABLE = models.IntegerField(blank=True)
    ID_ICONO = models.IntegerField(blank=True)
    ID_STATUS = models.IntegerField(blank=True)
    ORDEN = models.IntegerField(blank=True) 
    FECHA_MOD_XYGO = models.DateTimeField(blank=True)
    TIPO_MOD_XYGO = models.IntegerField(blank=True)
    ID_REPORTE_HISTORICO = models.IntegerField(blank=True)
    HABILITA_VER_ORDEN = models.IntegerField(blank=True)
    ES_OT_INICIAL = models.IntegerField(blank=True)

    def __str__(self):
        name = self.NOMBRE_OT + " " + "ID: " + str(self.ID_OT)
        return name

class tipo_modulo(models.Model):
    ID_TIPO_MODULO = models.IntegerField(primary_key=True, blank=True)
    NOMBRE = models.CharField(max_length=100, blank=True)
    ID_MODULO = models.IntegerField(blank=True)

    def __str__(self):
        name = self.NOMBRE
        return name

class status(models.Model):
    ID_STATUS = models.IntegerField(primary_key=True, blank=True)
    ID_OT = models.IntegerField(blank=True) 
    ID_ORDEN_STATUS = models.IntegerField(blank=True) 
    ID_EVENTO = models.IntegerField(blank=True) 
    ID_TIPO_STATUS = models.IntegerField(blank=True) 
    FECHA_MOD_XYGO = models.DateTimeField(blank=True)
    TIPO_MOD_XYGO = models.IntegerField(blank=True) 

    def __str__(self):
        name = "ID_OT: " + self.ID_OT + " ID_STATUS: " + self.ID_STATUS
        return name

class fase(models.Model):
    ID_FASE = models.IntegerField(primary_key=True, blank=True)
    DESC_FASE = models.CharField(max_length=100, blank=True)
    ID_FLUJO = models.IntegerField(blank=True) 
    ID_ORDEN = models.IntegerField(blank=True) 
    ID_ICONO = models.IntegerField(blank=True) 
    FECHA_INI = models.DateTimeField(blank=True)
    FECHA_FIN = models.DateTimeField(blank=True)
    FECHA_MOD_XYGO = models.DateTimeField(blank=True)
    TIPO_MOD_XYGO = models.IntegerField(blank=True) 
    HABILITA_VER_FASE = models.IntegerField(blank=True) 

    def __str__(self):
        name = "ID_FASE: " + self.ID_FASE
        return name