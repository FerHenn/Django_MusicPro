from django.contrib import admin
from .models import Categoria, Producto, DetalleVenta, Venta,subcategoria
# Register your models here.

admin.site.register(Categoria)
admin.site.register(Producto)
admin.site.register(DetalleVenta)
admin.site.register(Venta)
admin.site.register(subcategoria)