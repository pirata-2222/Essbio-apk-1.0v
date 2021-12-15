from django.shortcuts import render
from rest_framework import viewsets
from rest_framework import generics
from .models import data_eventos, data_tk_sector, contratista, camion
from .serializers import CamionSerializer, ContratistaSerializer, DataEventoSerializer, DataTKSectorSerializer

class DataTKSectorView(viewsets.ModelViewSet):
	queryset = data_tk_sector.objects.all()
	serializer_class = DataTKSectorSerializer

class DetailDataTKSector(generics.RetrieveUpdateDestroyAPIView):
	queryset = data_tk_sector.objects.all()
	serializer_class = DataTKSectorSerializer

class ContratistaView(viewsets.ModelViewSet):
	queryset = contratista.objects.all()
	serializer_class = ContratistaSerializer

class DetailContratista(generics.RetrieveUpdateDestroyAPIView):
	queryset = contratista.objects.all()
	serializer_class = ContratistaSerializer

class CamionView(viewsets.ModelViewSet):
	queryset = camion.objects.all()
	serializer_class = CamionSerializer

class DetailCamion(generics.RetrieveUpdateDestroyAPIView):
	queryset = camion.objects.all()
	serializer_class = CamionSerializer

class DataEventosView(viewsets.ModelViewSet):
	queryset = data_eventos.objects.all()
	serializer_class = DataEventoSerializer

class DetailDataEventos(generics.RetrieveUpdateDestroyAPIView):
	queryset = data_eventos.objects.all()
	serializer_class = DataEventoSerializer