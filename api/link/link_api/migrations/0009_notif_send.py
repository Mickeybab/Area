# Generated by Django 3.0.3 on 2020-02-25 18:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('link_api', '0008_notif'),
    ]

    operations = [
        migrations.AddField(
            model_name='notif',
            name='send',
            field=models.BooleanField(default=True),
        ),
    ]
