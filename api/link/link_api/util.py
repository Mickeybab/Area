from link_api.models import Intra, Applet, ParamApplet, Github, Intra, Slack, Microsoft, User
from firebase_admin import auth
from django.shortcuts import get_object_or_404
from link_api import settings


def applet_id_to_name(id):
    return ["Notifer son GPA sur Slack",
            "B",
            "C",
            "D",
            "E",
            "F",
            "G",
            "H"][id]


def applet_id_to_description(id):
    return ["Envoyer un méssage sur slack en fonction de son GPA",
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
    Applet(id_applet=0, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action='get the GPA', action_logo=settings.MY_IP + 'static/logo.png', reaction_service=settings.SERVICE_NAME[2], reaction='message', reaction_logo=settings.MY_IP + 'static/logo.png').save()
    ParamApplet(name="GPA", type=True, side=True, value=">2", applet_id=Applet.objects.filter(user_id=user_id, id_applet=0).get().id).save()
    ParamApplet(name="message", type=True, side=False, value="Mon GPA est passer au dessus de 2 !", applet_id=Applet.objects.filter(user_id=user_id, id_applet=0).get().id).save()
    Github(user_id=user_id).save()
    Intra(user_id=user_id).save()
    Slack(user_id=user_id).save()
    Microsoft(user_id=user_id).save()
