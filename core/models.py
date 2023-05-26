from django.conf import settings
from django.db import models
from django.utils import timezone


# Create your models here.

class Post(models.Model):
    author = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    title = models.CharField(max_length=200)
    text = models.TextField()
    created_date = models.DateTimeField(
            default=timezone.now)
    published_date = models.DateTimeField(
            blank=True, null=True)

    def publish(self):
        self.published_date = timezone.now()
        self.save()

    def __str__(self):
        return self.title

#modelo para el producto(cosas de musica)
class Categoria(models.Model):
    idCategoria = models.IntegerField(primary_key=True, verbose_name='Id de categoria')
    nombreCategoria = models.CharField(max_length=50, verbose_name='Nombre de la Categoria')

    def __str__(self):
        return self.nombreCategoria

class subcategoria(models.Model):
    idSubCategoria = models.IntegerField(primary_key=True, verbose_name='Id de SubCategoria')
    nombreSubCategoria = models.CharField(max_length=50, verbose_name='Nombre de la SubCategoria')
    categoria = models.ForeignKey(Categoria, null=True, blank=True, on_delete=models.CASCADE)

    def __str__(self):
        return self.nombreSubCategoria

class Producto(models.Model):
    idProducto = models.AutoField(primary_key=True,verbose_name='id de Producto')
    nombre_prod = models.CharField(max_length=40,verbose_name='Nombre de producto')
    imagen_prod = models.ImageField(upload_to="Productos", null=True, blank=True,verbose_name='Imagen') #python -m pip install Pillow   eso me lo pidio
    descripcion_prod = models.TextField(verbose_name='Descripcion')
    marca_prod = models.CharField(null=True, blank=True,max_length=30,verbose_name='marca')
    modelo_prod = models.CharField(null=True, blank=True,max_length=30,verbose_name='modelo')
    cantidad_prod = models.IntegerField(verbose_name='Cantidad de productos')
    precio_prod = models.IntegerField(verbose_name='Precio')
    categoria = models.ForeignKey(Categoria, null=True, blank=True, on_delete=models.CASCADE)
    subcategoria = models.ForeignKey(subcategoria, null=True, blank=True, on_delete=models.CASCADE)

    def __str__(self):
        return self.nombre_prod
    
class DetalleVenta(models.Model):
    idDetVenta = models.IntegerField(primary_key=True,verbose_name='id Detalle Venta')
    cantidad_prod_venta = models.IntegerField(verbose_name='Cantidad de productos')
    subtotal = models.IntegerField(verbose_name='Subtotal')

    def __str__(self):
        return self.idDetVenta


class Venta(models.Model):
    idVenta = models.IntegerField(primary_key=True,verbose_name='id Venta')
    fech_venta = models.DateField(verbose_name='FechaVenta')
    descuento = models.IntegerField(verbose_name='Descuento Venta')
    subtotal = models.IntegerField(verbose_name='Subtotal')
    iva = models.IntegerField(verbose_name='Iva')
    total = models.IntegerField(verbose_name='Total')

    def __str__(self):
        return self.idVenta
    
class Coupon(models.Model):
    code = models.CharField(max_length=50, unique=True)
    discount_amount = models.DecimalField(max_digits=5, decimal_places=2)
    expiration_date = models.DateField()
    email = models.EmailField()
    
    def save(self, *args, **kwargs):
        # Verificar la unicidad del código de cupón antes de guardar
        if Coupon.objects.filter(code=self.code).exists():
            raise ValueError("El código de cupón ya existe.")

    def is_valid(self):
        return self.expiration_date >= timezone.now().date()

    def __str__(self):
        return self.code