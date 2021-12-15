from django.urls import path, include
from . import views
from rest_framework import routers

router = routers.DefaultRouter()
router.register('ot_fase_instalacion', views.FaseInstalacionView)
router.register('ot_fase_abastecimiento', views.FaseAbastecimientoView)
router.register('ot_fase_abast_medicion', views.FaseAbastMedicionView)
router.register('ot_fase_retiro', views.FaseRetiroView)

urlpatterns = [
    path('', include(router.urls))
]