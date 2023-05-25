from django.contrib.auth.models import Group
from django.dispatch import receiver
from django.db.models.signals import post_save
from .models import Profile

@receiver(post_save, sender=Profile)
def add_user_to_students_group(sender, instance, created, **kwargs):
    if created:
        try:
            students = Group.objects.get(name='cliente')
        except Group.DoesNotExist:
            students = Group.objects.create(name='cliente')
            students = Group.objects.create(name='bodeguero')
            students = Group.objects.create(name='vendedor')
            students = Group.objects.create(name='contador')
            students = Group.objects.create(name='administrador')
        instance.user.groups.add(students)