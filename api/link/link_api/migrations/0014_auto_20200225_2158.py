# Generated by Django 3.0.3 on 2020-02-25 21:58

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('link_api', '0013_service_user_id'),
    ]

    operations = [
        migrations.RenameField(
            model_name='service',
            old_name='activate',
            new_name='enable',
        ),
    ]
