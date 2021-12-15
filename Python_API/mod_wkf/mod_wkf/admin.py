from django.contrib import admin
from .models import fase, orden_trabajo, status, tipo_modulo

admin.site.register(orden_trabajo)
admin.site.register(tipo_modulo)
admin.site.register(status)
admin.site.register(fase)
# Register your models here.
