from django.db import models

class usuarios(models.Model):
    IDUSUARIO = models.IntegerField(primary_key=True, blank=True)
    NOMUSUARIO = models.CharField(max_length=50, blank=True)
    CLAVE = models.CharField(max_length=50, blank=True)
    NOMBRES = models.CharField(max_length=150, blank=True)
    APELLIDOS = models.CharField(max_length=150, blank=True)
    RUT = models.CharField(max_length=20, blank=True)
    TELEFONOS = models.CharField(max_length=50, blank=True)
    EMAIL = models.CharField(max_length=50, blank=True)
    FECHANACIMIENTO = models.CharField(max_length=32, blank=True)
    ACTIVO = models.CharField(max_length=1, blank=True)
    FECHACREACION = models.CharField(max_length=32, blank=True)
    FECHAULTIMOINGRESO = models.CharField(max_length=32, blank=True)
    FECHAEXPIRA = models.CharField(max_length=32, blank=True)
    PERFIL_IDPERFIL = models.IntegerField(blank=True)
    ELIMINADO = models.IntegerField(blank=True)
    MOBILE = models.CharField(max_length=1, blank=True)
    COMUNA = models.CharField(max_length=10, blank=True)
    REGION = models.CharField(max_length=10, blank=True)
    TIPO_MOD_XYGO = models.IntegerField(blank=True)
    FECHA_MOD_XYGO = models.DateTimeField(blank=True)

    def __str__(self):
        name = self.NOMUSUARIO
        return name
