# Generated by Django 3.0.3 on 2020-02-25 21:43

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('link_api', '0012_services'),
    ]

    operations = [
        migrations.AddField(
            model_name='service',
            name='user_id',
            field=models.CharField(default='', max_length=255),
            preserve_default=False,
        ),
    ]
