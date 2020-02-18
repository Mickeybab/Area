from link_api.models import Intra, Applet, ParamApplet, Github, Intra, Slack, Microsoft, User
from firebase_admin import auth
from django.shortcuts import get_object_or_404
from link_api import settings


def applet_id_to_name(id):
    return ["A",
            "B",
            "C",
            "D",
            "E",
            "F",
            "G",
            "H"][id]


def applet_id_to_description(id):
    return ["AA",
            "BB",
            "CC",
            "DD",
            "EE",
            "FF",
            "GG",
            "HH"][id]


def applet_id_to_color(id):
    return ["0xffb74093",
            "0xffb74093",
            "0xffb74093",
            "0xffb74093",
            "0xffb74093",
            "0xffb74093",
            "0xffb74093",
            "0xffb74093"][id]


def firebase_get_user_id(token):
    decoded_token = auth.verify_id_token(token.split(' ')[1])
    uid = decoded_token['uid']
    if not User.objects.filter(user_id=uid).exists():
        create_user(uid)
    return uid


def create_user(user_id):
    print("Create new user {}".format(user_id))
    User(user_id=user_id).save()
    app = Applet(id_applet=0, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[0], action='test', action_logo=settings.MY_IP + 'statics/logo.png', reaction_service=settings.SERVICE_NAME[5], reaction='test', reaction_logo=settings.MY_IP + 'statics/logo.png').save()
    ParamApplet(name="Param", type=True, side=True, value="1", applet_id=Applet.objects.filter(user_id=user_id, id_applet=0).get().id).save()
    ParamApplet(name="Param2", type=True, side=False, value="2", applet_id=Applet.objects.filter(user_id=user_id, id_applet=0).get().id).save()
    app = Applet(id_applet=1, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action='test', action_logo=settings.MY_IP + 'statics/logo.png', reaction_service=settings.SERVICE_NAME[4], reaction='test', reaction_logo=settings.MY_IP + 'statics/logo.png').save()
    ParamApplet(name="Param", type=True, side=True, value="1", applet_id=Applet.objects.filter(user_id=user_id, id_applet=1).get().id).save()
    ParamApplet(name="Param2", type=True, side=False, value="2", applet_id=Applet.objects.filter(user_id=user_id, id_applet=1).get().id).save()
    app = Applet(id_applet=2, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[2], action='test', action_logo=settings.MY_IP + 'statics/logo.png', reaction_service=settings.SERVICE_NAME[3], reaction='test', reaction_logo=settings.MY_IP + 'statics/logo.png').save()
    ParamApplet(name="Param", type=True, side=True, value="1", applet_id=Applet.objects.filter(user_id=user_id, id_applet=2).get().id).save()
    ParamApplet(name="Param2", type=True, side=False, value="2", applet_id=Applet.objects.filter(user_id=user_id, id_applet=2).get().id).save()
    app = Applet(id_applet=3, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[3], action='test', action_logo=settings.MY_IP + 'statics/logo.png', reaction_service=settings.SERVICE_NAME[2], reaction='test', reaction_logo=settings.MY_IP + 'statics/logo.png').save()
    ParamApplet(name="Param", type=True, side=True, value="1", applet_id=Applet.objects.filter(user_id=user_id, id_applet=3).get().id).save()
    ParamApplet(name="Param2", type=True, side=False, value="2", applet_id=Applet.objects.filter(user_id=user_id, id_applet=3).get().id).save()
    app = Applet(id_applet=4, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[4], action='test', action_logo=settings.MY_IP + 'statics/logo.png', reaction_service=settings.SERVICE_NAME[1], reaction='test', reaction_logo=settings.MY_IP + 'statics/logo.png').save()
    ParamApplet(name="Param", type=True, side=True, value="1", applet_id=Applet.objects.filter(user_id=user_id, id_applet=4).get().id).save()
    ParamApplet(name="Param2", type=True, side=False, value="2", applet_id=Applet.objects.filter(user_id=user_id, id_applet=4).get().id).save()
    app = Applet(id_applet=5, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[5], action='test', action_logo=settings.MY_IP + 'statics/logo.png', reaction_service=settings.SERVICE_NAME[0], reaction='test', reaction_logo=settings.MY_IP + 'statics/logo.png').save()
    ParamApplet(name="Param", type=True, side=True, value="1", applet_id=Applet.objects.filter(user_id=user_id, id_applet=5).get().id).save()
    ParamApplet(name="Param2", type=True, side=False, value="2", applet_id=Applet.objects.filter(user_id=user_id, id_applet=5).get().id).save()
    Github(user_id=user_id).save()
    Intra(user_id=user_id).save()
    Slack(user_id=user_id).save()
    Microsoft(user_id=user_id).save()
