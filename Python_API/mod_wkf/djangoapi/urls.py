from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('mod_wkf.urls')),
    path('', include('ot.urls')),
    path('', include('xygo.urls')),
    path('', include('evento.urls')),    
]
