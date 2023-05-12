from django.shortcuts import render, redirect, get_object_or_404
from requests import post
from .models import Producto
from .serializers import ProductoSerializer
from rest_framework import viewsets
from .forms import  ProductoForm
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.contrib.auth import logout
from .forms import CustomUserCreationForm
from django.contrib.auth import authenticate, login

# Create your views here.

class ProductoViewset(viewsets.ModelViewSet):
    queryset = Producto.objects.all()
    serializer_class = ProductoSerializer


    def get_queryset(self):
        productos = Producto.objects.all()

        nombre = self.request.GET.get('nombre')

        if nombre:
            productos = productos.filter(nombre_prod__contains=nombre)
        
        return productos


def index(request):
    return render(request, 'core/index.html')
def contacto(request):
    return render(request, 'core/contacto.html')
@login_required
def productos(request):
    #accedo al objeto que contiene los datos de la base 
    #el metodo all traera todos los productos que esten en la tablita
    productos= Producto.objects.all()
    #ahora crearemos una variable que le pase los datos del producto al template
    datos = {
        'productos': productos
    }
    #ahora se le agrega para que se envie al template de html
    return render(request, 'core/Productos.html', datos)
def crud(request):
    #accedo al objeto que contiene los datos de la base 
    #el metodo all traera todos los productos que esten en la tablita
    productos= Producto.objects.all()
    #ahora crearemos una variable que le pase los datos del producto al template
    datos = {
        'productos': productos
    }
    #ahora se le agrega para que se envie al template de html
    return render(request, 'core/Crud.html', datos) #claro esto es solo una prueba la pagina puede cambiar

def mod_prod(request, id):
    producto = get_object_or_404(Producto, idProducto=id)
    #ahora crearemos una variable que le pase los datos del producto al template
    datos = {
        'form': ProductoForm(instance=producto)
    }
    
    if request.method == 'POST':
        formulario = ProductoForm(data=request.POST, instance=producto, files=request.FILES)
        if formulario.is_valid():
            formulario.save()
            messages.success(request, "Modificado Correctamente")
            return redirect(to="crud")
        datos["form"] = formulario

    return render(request, 'core/mod.html', datos)

def eliminar_prod(request, id):
    producto = get_object_or_404(Producto, idProducto=id)
    producto.delete()
    messages.success(request, "eliminado correctamente")
    return redirect(to="crud")

def formulario(request):
    data = {
        'form': ProductoForm()
    }
    # if this is a POST request we need to process the form data
    if request.method == 'POST':
        # create a form instance and populate it with data from the request:
        form = ProductoForm(data=request.POST, files=request.FILES) 
        # check whether it's valid:
        if form.is_valid():
            form.save()
            messages.success(request, "Agregado Correctamente")
        else:
            data["form"] = formulario
    return render(request, 'core/formulario.html', data)

def exit(request):
    logout(request)
    return redirect('index')

def register(request):
    data = {
        'form': CustomUserCreationForm()
    }

    if request.method == 'POST':
        user_creation_form = CustomUserCreationForm(data=request.POST)

        if user_creation_form.is_valid():
            user_creation_form.save()

            user = authenticate(username=user_creation_form.cleaned_data['username'], password=user_creation_form.cleaned_data['password1'])
            login(request, user)
            return redirect('index')

    return render(request, 'registration/register.html', data)