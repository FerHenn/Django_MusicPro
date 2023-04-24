from django.db import router
from django.urls import path, include
from .views import index,contacto
from rest_framework import routers
# from django.conf import settings #media
# from django.conf.urls.static import static #media

router = routers.DefaultRouter()


urlpatterns = [
    path('', index, name='index'), #le quite el nombre aca para que se acceda directamente.
    path('contacto', contacto, name='contacto'), #le quite el nombre aca para que se acceda directamente.
    
]

#if settings.DEBUG:
#    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
