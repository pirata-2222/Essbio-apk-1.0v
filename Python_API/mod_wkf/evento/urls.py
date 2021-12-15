from django.urls import path, include
from . import views
from rest_framework import routers

router = routers.DefaultRouter()
router.register('evento_data_tk_sector', views.DataTKSectorView)
router.register('evento_contratista', views.ContratistaView)
router.register('evento_camion', views.CamionView)
router.register('evento_data_eventos', views.DataEventosView)

urlpatterns = [
    path('', include(router.urls))
]