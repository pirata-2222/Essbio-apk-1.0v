from django.shortcuts import render
from rest_framework import viewsets
from rest_framework import generics
from .models import fase_abast_medicion, fase_abastecimiento, fase_instalacion, fase_retiro
from .serializers import FaseAbastMedicionSerializer, FaseAbastecimientoSerializer, FaseInstalacionSerializer, FaseRetiroSerializer

#Instalación
class FaseInstalacionView(viewsets.ModelViewSet):
	queryset = fase_instalacion.objects.all()
	serializer_class = FaseInstalacionSerializer

class DetailFaseInstalacion(generics.RetrieveUpdateDestroyAPIView):
	queryset = fase_instalacion.objects.all()
	serializer_class = FaseInstalacionSerializer

#Abastecimiento
class FaseAbastecimientoView(viewsets.ModelViewSet):
	queryset = fase_abastecimiento.objects.all()
	serializer_class = FaseAbastecimientoSerializer

class DetailFaseAbastecimientoView(generics.RetrieveUpdateDestroyAPIView):
	queryset = fase_abastecimiento.objects.all()
	serializer_class = FaseAbastecimientoSerializer

#Abast_Medicion
class FaseAbastMedicionView(viewsets.ModelViewSet):
	queryset = fase_abast_medicion.objects.all()
	serializer_class = FaseAbastMedicionSerializer

class DetailFaseAbastMedicionView(generics.RetrieveUpdateDestroyAPIView):
	queryset = fase_abast_medicion.objects.all()
	serializer_class = FaseAbastMedicionSerializer

#Retiro
class FaseRetiroView(viewsets.ModelViewSet):
	queryset = fase_retiro.objects.all()
	serializer_class = FaseRetiroSerializer

class DetailFaseRetiroView(generics.RetrieveUpdateDestroyAPIView):
	queryset = fase_retiro.objects.all()
	serializer_class = FaseRetiroSerializer