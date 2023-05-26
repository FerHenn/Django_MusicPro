from django.shortcuts import render, redirect, get_object_or_404
from requests import post
from django.http import HttpResponse
from .models import Producto
from .serializers import ProductoSerializer
from rest_framework import viewsets
from .forms import  ProductoForm
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.contrib.auth import logout
from .forms import CustomUserCreationForm
from django.contrib.auth import authenticate, login
from .models import Coupon
from django.core.mail import send_mail

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
            
            # Generar cupón de descuento
            coupon = Coupon.objects.create(
            code='BIENVENIDO23',  # Genera un código único para el cupón
            discount_amount=10,  # Establece el monto de descuento deseado
            expiration_date='2023-12-31',  # Establece la fecha de vencimiento del cupón
            email=request.POST['email'],  # Obtén el correo electrónico del formulario
        )
            # Enviar cupón por correo electrónico al cliente
            send_mail(
            '¡Cupón de descuento!',
            f'¡Hola! Aquí tienes tu cupón de descuento de bienvenida:) : {coupon.code}',
            'MusicPro@mail.com',
            [request.POST['email']],
            fail_silently=False,
        )
        return redirect('index')
    return render(request, 'registration/register.html', data)

def productito(request):
    #accedo al objeto que contiene los datos de la base 
    #el metodo all traera todos los productos que esten en la tablita
    productos= Producto.objects.all()
    #ahora crearemos una variable que le pase los datos del producto al template
    datos = {
        'productos': productos
    }
    #ahora se le agrega para que se envie al template de html
    return render(request,'core/Productito.html', datos)

###def roles(request):
    rol = None
    if request.user.is_superuser:
        rol = 'administrador'
    elif request.user.is_authenticated:
        rol = 'cliente'
    elif request.user.is_authenticated:
        rol = 'bodeguero'
    elif request.user.is_authenticated:
        rol = 'tesorero'
    elif request.user.is_authenticated:
        rol = 'vendedor'    
    else:
        rol = 'invitado'
    return render(request, '')