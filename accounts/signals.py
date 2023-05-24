from django.contrib.auth.models import Group
from django.dispatch import receiver
from django.db.models.signals import post_save
from .models import Profile

@receiver(post_save, sender=Profile)
def add_user_to_usuario_group(sender, instance, created, **kwargs):
    if created:
        try:
            usuario = Group.objects.get(name='cliente')
        except Group.DoesNotExist:
            usuario = Group.objects.create(name='estudiante')
            usuario = Group.objects.create(name='vendedor')
            usuario = Group.objects.create(name='bodeguero')
            usuario = Group.objects.create(name='tesorero')
            usuario = Group.objects.create(name='administrador')
        instance.user.groups.add(usuario)