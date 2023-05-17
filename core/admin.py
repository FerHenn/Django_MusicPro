from django.contrib import admin
from .models import Categoria, Producto, DetalleVenta, Venta
# Register your models here.

admin.site.register(Categoria)
admin.site.register(Producto)
admin.site.register(DetalleVenta)
admin.site.register(Venta)