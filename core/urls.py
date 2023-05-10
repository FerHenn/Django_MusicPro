from django.db import router
from django.urls import path, include
from .views import index,contacto,productos,crud, mod_prod, eliminar_prod, formulario, ProductoViewset, exit
from rest_framework import routers
# from django.conf import settings #media
# from django.conf.urls.static import static #media

router = routers.DefaultRouter()
router.register('producto', ProductoViewset)

urlpatterns = [
    path('', index, name='index'), #le quite el nombre aca para que se acceda directamente.
    path('contacto', contacto, name='contacto'),
    path('productos', productos, name='productos'),
    path('api/', include(router.urls)),
    path('crud', crud, name='crud'),
    path('mod_prod/<id>',mod_prod, name='mod'),
    path('eliminar_prod/<id>',eliminar_prod, name='eliminar'),
    path('formulario', formulario, name='formulario'),
    path('logout/', exit, name='exit'),
]

#if settings.DEBUG:
#    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
