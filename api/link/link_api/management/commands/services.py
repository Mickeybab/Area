from link_api.models import User, Applet, ParamApplet, Github, Intra, Slack, Google
from django.core.management.base import BaseCommand
from time import sleep
from link_api import settings, util


class Command(BaseCommand):
    help = 'Verify all service'

    def handle(self, *args, **options):

        def verify_value(app):
            if app.action == settings.SERVICE_NAME[0]:
                if util.verify_github(app):
                    return True
            
            if app.action == settings.SERVICE_NAME[1]:
                if util.verify_intra():
                    return True
            
            if app.action == settings.SERVICE_NAME[2]:
                if util.verify_slack():
                    return True
            
            if app.action == settings.SERVICE_NAME[3]:
                if util.verify_currency():
                    return True
            
            if app.action == settings.SERVICE_NAME[4]:
                if util.verify_weather():
                    return True
            
            if app.action == settings.SERVICE_NAME[5]:
                if util.verify_googlemail():
                    return True
    
            return False


        def start_reaction(app):
            util.reaction_slack()
            util.reaction_email()
            util.reaction_notify()


        def choose_service(app):
            if verify_value(app):
                start_reaction(app)


        while True:
            sleep(30)
            print("Start check applets")
            users = User.objects.all()
            for user in users:
                print("User: " + str(user.id))
                apps = Applet.objects.filter(user_id=user.id, enable=True)
                for app in apps:
                    choose_service(app)
