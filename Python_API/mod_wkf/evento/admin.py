from django.contrib import admin
from .models import data_eventos, data_tk_sector, contratista, camion

admin.site.register(data_tk_sector)
admin.site.register(contratista)
admin.site.register(camion)
admin.site.register(data_eventos)
# Register your models here.
