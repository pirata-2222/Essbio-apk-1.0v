from django.contrib import admin
from .models import fase_abast_medicion, fase_abastecimiento, fase_instalacion, fase_retiro

admin.site.register(fase_instalacion)
admin.site.register(fase_abastecimiento)
admin.site.register(fase_abast_medicion)
admin.site.register(fase_retiro)
# Register your models here.
