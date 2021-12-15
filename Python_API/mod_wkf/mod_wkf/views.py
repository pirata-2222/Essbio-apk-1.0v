from django.shortcuts import render
from rest_framework import viewsets
from rest_framework import generics
from .models import fase, orden_trabajo, status, tipo_modulo
from .serializers import FaseSerializer, ModWkfOrdenTrabajoSerializer, StatusSerializer, TipoModuloSerializer

class ModWkfOrdenTrabajoView(viewsets.ModelViewSet):
	queryset = orden_trabajo.objects.all()
	serializer_class = ModWkfOrdenTrabajoSerializer

class DetailModWkfOrdenTrabajo(generics.RetrieveUpdateDestroyAPIView):
	queryset = orden_trabajo.objects.all()
	serializer_class = ModWkfOrdenTrabajoSerializer

class TipoModuloView(viewsets.ModelViewSet):
	queryset = tipo_modulo.objects.all()
	serializer_class = TipoModuloSerializer

class DetailTipoModulo(generics.RetrieveUpdateDestroyAPIView):
	queryset = tipo_modulo.objects.all()
	serializer_class = TipoModuloSerializer

class StatusView(viewsets.ModelViewSet):
	queryset = status.objects.all()
	serializer_class = StatusSerializer

class DetailStatus(generics.RetrieveUpdateDestroyAPIView):
	queryset = status.objects.all()
	serializer_class = StatusSerializer

class FaseView(viewsets.ModelViewSet):
	queryset = fase.objects.all()
	serializer_class = FaseSerializer

class DetailFase(generics.RetrieveUpdateDestroyAPIView):
	queryset = fase.objects.all()
	serializer_class = FaseSerializer