from django.shortcuts import render
from rest_framework import viewsets
from rest_framework import generics
from .models import usuarios
from .serializers import UsuarioSerializer
class UsuarioView(viewsets.ModelViewSet):
	queryset = usuarios.objects.all()
	serializer_class = UsuarioSerializer

class DetailUsuario(generics.RetrieveUpdateDestroyAPIView):
	queryset = usuarios.objects.all()
	serializer_class = UsuarioSerializer

