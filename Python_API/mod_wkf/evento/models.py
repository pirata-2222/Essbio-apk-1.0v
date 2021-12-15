from django.db import models

class data_tk_sector(models.Model):
    ID = models.IntegerField(primary_key=True, blank=True)
    ID_EVENTO = models.IntegerField(blank=True)
    ID_SECTOR = models.IntegerField(blank=True)
    ID_POR_EVENTO = models.IntegerField(blank=True)
    NOMBRE_SECTOR = models.CharField(max_length=100, blank=True)
    NOMBRE_SECTOR_CORTO = models.CharField(max_length=200, blank=True)
    ID_TK = models.IntegerField(blank=True)
    NOMBRE = models.CharField(max_length=100, blank=True)
    DESCRIPCION = models.CharField(max_length=200, blank=True)
    FECHA_CREACION = models.CharField(max_length=20, blank=True)
    X = models.CharField(max_length=20, blank=True)
    Y = models.CharField(max_length=20, blank=True)
    LATITUD = models.CharField(max_length=20, blank=True)
    LONGITUD = models.CharField(max_length=20, blank=True)
    ID_USUARIO = models.CharField(max_length=10, blank=True)
    ID_PERFIL = models.CharField(max_length=10, blank=True)
    LOGIN = models.CharField(max_length=50, blank=True)
    NOMBRE_USUARIO = models.CharField(max_length=50, blank=True)
    APELLIDOS_USUARIO = models.CharField(max_length=50, blank=True)
    NOMBRE_PERFIL = models.CharField(max_length=50, blank=True)
    CALLE_1 = models.CharField(max_length=100, blank=True)
    CALLE_2 = models.CharField(max_length=100, blank=True)
    ESTADO = models.IntegerField(blank=True)
    LON = models.DecimalField(max_digits=11, decimal_places=8,blank=True)
    LAT = models.DecimalField(max_digits=11, decimal_places=8, blank=True)
    #GEOM = models.TextField(blank=True)
    FECHA_MOD_XYGO = models.DateTimeField(blank=True)
    TIPO_MOD_XYGO = models.IntegerField(blank=True)
    
    def __str__(self):
        name = self.NOMBRE + " " + "ID: " + str(self.ID)
        return name

class contratista(models.Model):

    ID = models.DecimalField(max_digits=18, decimal_places=0)
    RUT = models.CharField(max_length=20, blank=True)
    NOMBRE_COMPLETO = models.CharField(max_length=200, blank=True)
    TELEFONO = models.CharField(max_length=50, blank=True)
    EMAIL = models.CharField(max_length=200, blank=True)
    SERVICIO = models.CharField(max_length=200, blank=True)
    IDUSUARIO = models.DecimalField(max_digits=18, decimal_places=0, blank=True)
    SERV_INSTALACION = models.CharField(max_length=2, blank=True)
    SERV_ABASTECIMIENTO = models.CharField(max_length=2, blank=True)
    SERV_RETIRO = models.CharField(max_length=2, blank=True)
    FECHA_MOD_XYGO = models.DateTimeField(blank=True)
    TIPO_MOD_XYGO = models.DecimalField(max_digits=18, decimal_places=0, blank=True)
        
    def __str__(self):
        name = self.NOMBRE
        return name

class camion(models.Model):

    ID = models.DecimalField(max_digits=18, decimal_places=0, blank=True, primary_key=True)
    ID_CONTRATISTA = models.DecimalField(max_digits=18, decimal_places=0, blank=True)
    PATENTE = models.CharField(max_length=10, blank=True)
    CAPACIDAD = models.CharField(max_length=100, blank=True)
    LITROS_MINUTO = models.CharField(max_length=100, blank=True)
    ID_USUARIO_CAMION = models.DecimalField(max_digits=18, decimal_places=0, blank=True)
    FECHA_MOD_XYGO = models.DateTimeField(blank=True)
    TIPO_MOD_XYGO = models.DecimalField(max_digits=18, decimal_places=0, blank=True)
    
    def __str__(self):
        name = self.PATENTE
        return name

class data_eventos(models.Model):
    ID_EVENTO = models.IntegerField(blank=True, primary_key=True)
    NUM_SISDA = models.IntegerField(blank=True)
    ESTADO = models.CharField(max_length=5, blank=True)
    X = models.CharField(max_length=20, blank=True)
    Y = models.CharField(max_length=20, blank=True)
    LATITUD = models.CharField(max_length=20, blank=True)
    LONGITUD = models.CharField(max_length=20, blank=True)
    LOCALIDAD = models.CharField(max_length=100, blank=True)
    COD_LOCALIDAD = models.CharField(max_length=10, blank=True)
    NOMBRE_COMUNA = models.CharField(max_length=100, blank=True)
    ID_DIRECCION = models.CharField(max_length=10, blank=True)
    DIRECCION = models.CharField(max_length=150, blank=True)
    SECTOR_CERRO = models.CharField(max_length=150, blank=True)
    COD_AREA = models.CharField(max_length=10, blank=True)
    TIPO_RED = models.CharField(max_length=10, blank=True)
    TIPO_EVENTO_DETALLE = models.CharField(max_length=50, blank=True)
    FECHA_INICIO_SISDA = models.CharField(max_length=10, blank=True)
    HORA_INICIO_SISDA = models.CharField(max_length=5, blank=True)
    FECHA_INICIO = models.CharField(max_length=10, blank=True)
    HORA_INICIO = models.CharField(max_length=5, blank=True)
    FECHA_TERMINO = models.CharField(max_length=10, blank=True)
    HORA_TERMINO = models.CharField(max_length=5, blank=True)
    DURACION_DE_LA_OPERACION = models.CharField(max_length=10, blank=True)
    DURACION = models.CharField(max_length=10, blank=True)
    FECHA_AVISO_USUARIO = models.CharField(max_length=10, blank=True)
    ID_EMPRESA = models.CharField(max_length=10, blank=True)
    EMPRESA = models.CharField(max_length=50, blank=True)
    RUT_EMPRESA = models.CharField(max_length=15, blank=True)
    SUBGERENCIA_ZONAL_EMPRESA = models.CharField(max_length=100, blank=True)
    CATEGORIA_CORTE = models.CharField(max_length=100, blank=True)
    MOTIVO_CORTE = models.CharField(max_length=100, blank=True)
    CON_SUMINISTRO_ALTERNATIVO = models.CharField(max_length=5, blank=True)
    USAR_POLIGONO_UNICO = models.CharField(max_length=5, blank=True)
    CAPA_ESTANQUES = models.CharField(max_length=5, blank=True)
    DONDE = models.CharField(max_length=150, blank=True)
    TIPO_EVENTO = models.CharField(max_length=20, blank=True)
    ZONALES_EVENTO = models.TextField(blank=True)
    COMUNAS_EVENTO = models.TextField(blank=True)
    SECTORES_EVENTO = models.TextField(blank=True)
    FECHA_MOD_XYGO = models.DateTimeField(blank=True)
    TIPO_MOD_XYGO = models.IntegerField(blank=True)
