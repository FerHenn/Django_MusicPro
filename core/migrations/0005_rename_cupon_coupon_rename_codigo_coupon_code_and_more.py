# Generated by Django 4.2.1 on 2023-05-26 21:30

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0004_cupon'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='Cupon',
            new_name='Coupon',
        ),
        migrations.RenameField(
            model_name='coupon',
            old_name='codigo',
            new_name='code',
        ),
        migrations.RenameField(
            model_name='coupon',
            old_name='descuento',
            new_name='discount_amount',
        ),
        migrations.RenameField(
            model_name='coupon',
            old_name='fecha_vencimiento',
            new_name='expiration_date',
        ),
    ]
