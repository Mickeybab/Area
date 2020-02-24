from link_api.models import User, Applet, ParamApplet, Github, Intra, Slack, Microsoft
from django.core.management.base import BaseCommand


class Command(BaseCommand):
    help = 'Verify all service'

    def handle(self, *args, **options):
        
        print("Start check applets")

        def verify_value(app, param):
            return False


        def start_reaction(app, param):
            app = app


        def choose_service(app):
            param_action = ParamApplet.objects.filter(applet_id=app.id, side=True)
            param_reaction = ParamApplet.objects.filter(applet_id=app.id, side=False)
            if verify_value(app, param_action):
                start_reaction(app, param_reaction)

        
        users = User.objects.all()
        for user in users:
            print("User: " + str(user.id))
            apps = Applet.objects.filter(user_id=user.id, enable=True)
            for app in apps:
                choose_service(app)