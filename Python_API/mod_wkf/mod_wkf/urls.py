from django.urls import path, include
from . import views
from rest_framework import routers

router = routers.DefaultRouter()
router.register('mod_wkf_orden_trabajo', views.ModWkfOrdenTrabajoView)
router.register('mod_wkf_tipo_modulo', views.TipoModuloView)
router.register('mod_wkf_status', views.StatusView)
router.register('mod_wkf_fase', views.FaseView)


urlpatterns = [
    path('', include(router.urls))
]