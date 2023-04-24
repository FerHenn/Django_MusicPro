from django.shortcuts import render, HttpResponse
from requests import post
# Create your views here.



def index(request):
    return render(request, 'core/index.html')
def contacto(request):
    return render(request, 'core/contacto.html')
