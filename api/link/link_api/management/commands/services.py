from link_api.models import User, Applet, ParamApplet, Github, Intra, Slack, Google
from django.core.management.base import BaseCommand
from time import sleep
from link_api import settings, util


class Command(BaseCommand):
    help = 'Verify all service'

    def handle(self, *args, **options):

        def verify_value(app):
            if app.action_service == settings.SERVICE_NAME[0]:
                if util.verify_github(app):
                    return True
            
            if app.action_service == settings.SERVICE_NAME[1]:
                if util.verify_intra(app):
                    return True
            
            if app.action_service == settings.SERVICE_NAME[2]:
                if util.verify_slack(app):
                    return True
            
            if app.action_service == settings.SERVICE_NAME[3]:
                if util.verify_currency(app):
                    return True
            
            if app.action_service == settings.SERVICE_NAME[4]:
                if util.verify_weather(app):
                    return True
            
            if app.action_service == settings.SERVICE_NAME[5]:
                if util.verify_googlemail(app):
                    return True
    
            return False


        def start_reaction(app):
            if app.reaction_service == settings.SERVICE_NAME[2]:
                util.reaction_slack(app)
            elif app.reaction_service == settings.SERVICE_NAME[5]:
                util.reaction_email(app)
            elif app.reaction_service == settings.SERVICE_NAME[6]:
                util.reaction_notify(app)


        def choose_service(app):
            if verify_value(app):
                start_reaction(app)


        while True:
            sleep(5)
            print("Start check applets")
            users = User.objects.all()
            for user in users:
                print("User: " + str(user.id))
                for app in Applet.objects.filter(user_id=user.user_id, enable=True):
                    choose_service(app)
