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

class Producto(models.Model):
    idProducto = models.AutoField(primary_key=True,verbose_name='id de Producto')
    nombre_prod = models.CharField(max_length=40,verbose_name='Nombre_prod')
    imagen_prod = models.ImageField(upload_to="Productos", null=True, blank=True) #python -m pip install Pillow   eso me lo pidio
    descripcion_prod = models.TextField(verbose_name='Descripcion')
    cantidad_prod = models.IntegerField(verbose_name='Cantidad de productos')
    precio_prod = models.IntegerField(verbose_name='Precio')
    categoria = models.ForeignKey(Categoria, null=True, blank=True, on_delete=models.CASCADE)

    def __str__(self):
        return self.nombre_prod