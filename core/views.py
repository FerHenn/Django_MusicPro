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
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
import requests
from transbank.webpay.webpay_plus.transaction import Transaction
from transbank.webpay.webpay_plus.transaction import WebpayOptions,IntegrationApiKeys,IntegrationCommerceCodes
import datetime as dt
from django.template.loader import render_to_string


from collections.abc import Mapping

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
    

def webpay_plus_create(request):
    # Valores de prueba
    print("Webpay Plus Transaction.create")
    buy_order = "ordenCompra12345678"
    session_id = "sesion1234557545"
    amount = 999492       #request.POST.get('total')
    return_url = request.build_absolute_uri(location='commit-pay/')
#  version 3.0.1 sdk
    tx = Transaction(WebpayOptions(IntegrationCommerceCodes.WEBPAY_PLUS, IntegrationApiKeys.WEBPAY))
    response  = tx.create(buy_order, session_id, amount, return_url)

    print(response)

    return render(request, 'core/send-pay.html', {'response': response ,'amount':amount}) #context

def cart(request):
    print('cart')

    control = { 'image' : 'img/product/control-xbox.jpg',
                'product': 'XBOX GAMEPAD',
                'description': 'BLACK COLOR',
                'price' : 59000,
                'quantity': 1
                }
    gabinete = {'image' : 'img/product/gabinete.jpg',
                'product': 'CABINET',
                'description': 'BLACK MATE COLOR',    
                'price' : 69000,
                'quantity': 1
                }
    notebook = {'image' : 'img/product/notebook.jpg',
                'product': 'GAMER LAPTOP',
                'description': 'WHITE COLOR',    
                'price' : 2150000,
                'quantity': 1
                }                   

    products = [control, gabinete, notebook]
    total = control.get('price') + gabinete.get('price') + notebook.get('price')

    return render(request, 'core/cart.html', {'products' : products, 'total': total})

@csrf_exempt 
def commitpay(request):
    print('commitpay')
    print("request: {0}".format(request.POST))    
    token = request.POST.get('token_ws')

    TBK_TOKEN = request.POST.get('TBK_TOKEN')
    TBK_ID_SESION = request.POST.get('TBK_ID_SESION')
    TBK_ORDEN_COMPRA = request.POST.get('TBK_ORDEN_COMPRA')

    #TRANSACCIÓN REALIZADA
    if TBK_TOKEN is None and TBK_ID_SESION is None and TBK_ORDEN_COMPRA is None and token is not None:

        #APROBAR TRANSACCIÓN
        response = Transaction.commit(token=token)
        print("response: {}".format(response)) 

        status = response.status
        print("status: {0}".format(status))
        response_code = response.response_code
        print("response_code: {0}".format(response_code)) 
        #TRANSACCIÓN APROBADA
        if status == 'AUTHORIZED' and response_code == 0:

            state = ''
            if response.status == 'AUTHORIZED':
                state = 'Aceptado'
            pay_type = ''
            if response.payment_type_code == 'VD':
                pay_type = 'Tarjeta de Débito'
            amount = int(response.amount)
            amount = f'{amount:,.0f}'.replace(',', '.')
            transaction_date = dt.datetime.strptime(response.transaction_date, '%Y-%m-%dT%H:%M:%S.%fZ')
            transaction_date = '{:%d-%m-%Y %H:%M:%S}'.format(transaction_date)
            transaction_detail = {  'card_number': response.card_detail.card_number,
                                    'transaction_date': transaction_date,
                                    'state': state,
                                    'pay_type': pay_type,
                                    'amount': amount,
                                    'authorization_code': response.authorization_code,
                                    'buy_order': response.buy_order, }
            return render(request, 'commit-pay/', {'transaction_detail': transaction_detail})
        else:
        #TRANSACCIÓN RECHAZADA
            navbar_html = render_to_string('core/navBar.html')
            error_message = '<div class="error-message-container">ERROR EN LA TRANSACCIÓN, SE RECHAZA LA TRANSACCIÓN.</div>'
        return HttpResponse(f'{navbar_html}<div class="content-container">{error_message}</div>')
    else:
    #TRANSACCIÓN CANCELADA
        navbar_html = render_to_string('core/navBar.html')
        error_message = '<div class="error-message-container">ERROR EN LA TRANSACCIÓN, SE CANCELO EL PAGO.</div>'
    return HttpResponse(f'{navbar_html}<div class="content-container">{error_message}</div>')


def index(request):
    return render(request, 'core/index.html')
def contacto(request):
    return render(request, 'core/contacto.html')
# @login_required
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
            code='DESCUENTO10',  # Genera un código único para el cupón
            discount_amount=10,  # Establece el monto de descuento deseado
            expiration_date='2023-12-31',  # Establece la fecha de vencimiento del cupón
            email=request.POST['email'],  # Obtén el correo electrónico del formulario
        )
            # Enviar cupón por correo electrónico al cliente
            send_mail(
            '¡Cupón de descuento!',
            f'¡Hola! Aquí tienes tu cupón de descuento de bienvenida:) : {coupon.code}',
            'contacto@MusicPro.cl',
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

from django.http import JsonResponse

def obtener_correo_usuario(request):
    if request.user.is_authenticated:
        correo = request.user.email
        return JsonResponse({'correo': correo})
    else:
        return JsonResponse({'correo': None})
    
@csrf_exempt
def enviar_cupon(request):
    if request.method == 'POST':

        # Configurar los datos del correo
        asunto = '¡Cupón de descuento especial!'
        mensaje = '''
        Estimado cliente,

        Gracias por tu compra. Aquí tienes un cupón de descuento especial: DESCUENTO123.

        ¡Disfrútalo y vuelve pronto!

        Saludos,
        Tu tienda online
        '''
        remitente = 'contacto@MusicPro.cl'
        destinatario = 'cliente@cliente.com'

        # Enviar el correo
        send_mail(asunto, mensaje, remitente, [destinatario] )

        # Retornar la respuesta adecuada (por ejemplo, una respuesta JSON)
        return JsonResponse({'mensaje': 'El cupón ha sido enviado correctamente'})
    else:
        return JsonResponse({'mensaje': 'Método no permitido'}, status=405)
        # return JsonResponse({'mensaje': 'Cupón enviado correctamente'})