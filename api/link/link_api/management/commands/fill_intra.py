from link_api.models import Intra
from django.core.management.base import BaseCommand


class Command(BaseCommand):
    help = 'Fill database with default data'

    def handle(self, *args, **options):
        i = Intra()
        i.user_id = 'pedaXNKJRdW8uJ9BpfPrkDRFzPI2'
        i.token = 'auth-14zufheriufen70473434bjnbiubfa197764516'
        i.save()
