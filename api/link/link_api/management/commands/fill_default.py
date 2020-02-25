from link_api.models import Service
from django.core.management.base import BaseCommand
from link_api import settings


class Command(BaseCommand):
    help = 'Verify all service'

    def handle(self, *args, **options):
        if Service.objects.all().count() == 0:
            Service(name=settings.SERVICE_NAME[0]).save()
            Service(name=settings.SERVICE_NAME[1]).save()
            Service(name=settings.SERVICE_NAME[2]).save()
            Service(name=settings.SERVICE_NAME[3]).save()
            Service(name=settings.SERVICE_NAME[4]).save()
            Service(name=settings.SERVICE_NAME[5]).save()
