# Generated by Django 3.0.3 on 2020-02-25 19:05

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('link_api', '0010_auto_20200225_1843'),
    ]

    operations = [
        migrations.RenameField(
            model_name='notif',
            old_name='name',
            new_name='message',
        ),
    ]
