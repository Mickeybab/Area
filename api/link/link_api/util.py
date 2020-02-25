from link_api.models import Intra, Applet, ParamApplet, Github, Intra, Slack, Google, User, Notif
from firebase_admin import auth
from django.shortcuts import get_object_or_404
from link_api import settings
import requests
import urllib
from sys import stderr
import json


def applet_id_to_name(id):
    return ["Notifier un commit sur slack", # 0
            "Notifier un commit par email", # 1
            "Notifier un commit par notification", # 2
            "Notifier l'augmentation de la température sur slack", # 3
            "Notifier l'augmentation de la température sur email", # 4
            "Notifier l'augmentation de la température sur notification", # 5
            "Notifier la diminution de la température sur slack", # 6
            "Notifier la diminution de la température sur email", # 7
            "Notifier la diminution de la température sur notification", # 8
            "Notifier la reception d'une email sur slack", # 9
            "Notifier la reception d'une email sur email", # 10
            "Notifier la reception d'une email sur notification", # 11
            "Notifier une note sur slack", # 12
            "Notifier une note sur email", # 13
            "Notifier une note sur notification", # 14
            "Notifier une crédit sur slack", # 15
            "Notifier une crédit sur email", # 16
            "Notifier une crédit sur notification", #17
            "Notifier une baise de gpa sur slack", # 18
            "Notifier une baise de gpa sur email", # 19
            "Notifier une baise de gpa sur notification", #20
            "Notifier une augmentation de gpa sur slack", # 21
            "Notifier une augmentation de gpa sur email", # 22
            "Notifier une augmentation de gpa sur notification", #23
            "Notifier la baise du bitcoin sur slack", # 24
            "Notifier la baise du bitcoin sur email", # 25
            "Notifier la baise du bitcoin sur notification", #26
            "Notifier l'augmentation du bitcoin sur slack", # 27
            "Notifier l'augmentation du bitcoin sur email", # 28
            "Notifier l'augmentation du bitcoin sur notification", #29
            "Notifier une notification slack sur slack", # 30
            "Notifier une notification slack sur email", # 31
            "Notifier une notification slack sur notification", #32
            "H"][id]


def applet_id_to_description(id):
    return ["Envoyer un méssage sur slack lors de l'arrivé d'un nouveau commit sur un repository à spécifier", # 0
            "Envoyer un email sur slack lors de l'arrivé d'un nouveau commit sur un repository à spécifier", # 1
            "Envoyer une notification sur slack lors de l'arrivé d'un nouveau commit sur un repository à spécifier", # 2
            "Envoyer un méssage sur slack lors que la température dépasse un seuil donné", # 3
            "Envoyer un email via google mail lors que la température dépasse un seuil donné", # 4
            "Envoyer une notification lors que la température dépasse un seuil donné", # 5
            "Envoyer un méssage sur slack lors que la température descent en dessous d'un seuil donné", # 6
            "Envoyer un email via google mail lors que la température descent en dessous d'un seuil donné", # 7
            "Envoyer une notification lors que la température descent en dessous d'un seuil donné", # 8
            "Envoyer un méssage sur slack lors de la reception d'un email sur gmail", # 9
            "Envoyer un email via google mail lors de la reception d'un email sur gmail", # 10
            "Envoyer une notification lors de la reception d'un email sur gmail", # 11
            "Envoyer un méssage sur slack lors qu'une note venant de l'intra epitech est en dessous d'un seuil donné", # 12
            "Envoyer un email via google mail lors qu'une note venant de l'intra epitech est en dessous d'un seuil donné", # 13
            "Envoyer une notification lors qu'une note venant de l'intra epitech est en dessous d'un seuil donné", # 14
            "Envoyer un méssage sur slack lors que un crédit de l'intra epitech est au dessus d'un seuil donné", # 15
            "Envoyer un email via google mail lors que un crédit de l'intra epitech est au dessus d'un seuil donné", # 16
            "Envoyer une notification lors que un crédit de l'intra epitech est au dessus d'un seuil donné", # 17
            "Envoyer un méssage sur slack lors que le GPA de l'intra epitech en dessous d'un seuil donné", # 18
            "Envoyer un email via google mail lors que le GPA de l'intra epitech en dessous d'un seuil donné", # 19
            "Envoyer une notification lors que le GPA de l'intra epitech en dessous d'un seuil donné", # 20
            "Envoyer un méssage sur slack lors que le GPA de l'intra epitech au dessus d'un seuil donné", # 21
            "Envoyer un email via google mail lors que le GPA de l'intra epitech au dessus d'un seuil donné", # 22
            "Envoyer une notification lors que le GPA de l'intra epitech au dessus d'un seuil donné", # 23
            "Envoyer un méssage sur slack lors que le bitcoin passe en dessous d'un seuil donné", # 24
            "Envoyer un email via google mail lors que le bitcoin passe en dessous d'un seuil donné", # 25
            "Envoyer une notification lors que le bitcoin passe en dessous d'un seuil donné", # 26
            "Envoyer un méssage sur slack lors que le bitcoin passe au dessus d'un seuil donné", # 27
            "Envoyer un email via google mail lors que le bitcoin passe au dessus d'un seuil donné", # 28
            "Envoyer une notification lors que le bitcoin passe au dessus d'un seuil donné", # 29
            "Envoyer un méssage sur slack lors de la reception d'une nouvelle notification slack", # 30
            "Envoyer un email via google mail lors de la reception d'une nouvelle notification slack", # 31
            "Envoyer une notification lors de la reception d'une nouvelle notification slack", # 32
            "HH"][id]


def applet_id_to_color(id):
    return ["0xffb74093", # 0
            "0xffb74093", # 1
            "0xffb74093", # 2
            "0xff32a83e", # 3
            "0xff32a83e", # 4
            "0xff32a83e", # 5
            "0xff76ff61", # 6
            "0xff76ff61", # 7
            "0xff76ff61", # 8
            "0xff4294ff", # 9
            "0xff4294ff", # 10
            "0xff4294ff", # 11
            "0xff0040ff", # 12
            "0xff0040ff", # 13
            "0xff0040ff", # 14
            "0xffff2e9d", # 15
            "0xffff2e9d", # 16
            "0xffff2e9d", # 17
            "0xfffcff45", # 18
            "0xfffcff45", # 19
            "0xfffcff45", # 20
            "0xffffa947", # 21
            "0xffffa947", # 22
            "0xffffa947", # 23
            "0xffff615e", # 24
            "0xffff615e", # 25
            "0xffff615e", # 26
            "0xff5eff8e", # 27
            "0xff5eff8e", # 28
            "0xff5eff8e", # 29
            "0xff9c72b3", # 30
            "0xff9c72b3", # 31
            "0xff9c72b3", # 32
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

    #### Github New Commit ####
    ## Slack
    Applet(id_applet=0, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[0], action='new commit', action_logo='http://' + settings.MY_IP + 'static/github.png',
        reaction_service=settings.SERVICE_NAME[2], reaction='Slack Message', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Owner Name", type=True, side=True, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=0).get().id).save()
    ParamApplet(name="Repository Name", type=True, side=True, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=0).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="Nouveau commit sur ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=0).get().id).save()

    ## Exchange
    Applet(id_applet=1, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[0], action='new commit', action_logo='http://' + settings.MY_IP + 'static/github.png',
        reaction_service=settings.SERVICE_NAME[5], reaction='Google Mail', reaction_logo='http://' + settings.MY_IP + 'static/googlemail.png').save()
    ParamApplet(name="Owner Name", type=True, side=True, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=1).get().id).save()
    ParamApplet(name="Repository Name", type=True, side=True, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=1).get().id).save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=1).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="Nouveau commit", applet_id=Applet.objects.filter(user_id=user_id, id_applet=1).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="Nouveau commit sur ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=1).get().id).save()

    ## Notify
    Applet(id_applet=2, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[0], action='new commit', action_logo='http://' + settings.MY_IP + 'static/github.png',
        reaction_service=settings.SERVICE_NAME[6], reaction='Notification', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Owner Name", type=True, side=True, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=2).get().id).save()
    ParamApplet(name="Repository Name", type=True, side=True, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=2).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="Nouveau commit sur ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=2).get().id).save()


    #### The temperature exceeds a threshold ####
    ## Slack
    Applet(id_applet=3, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[4], action='exceeds a threshold', action_logo='http://' + settings.MY_IP + 'static/weather.png',
        reaction_service=settings.SERVICE_NAME[2], reaction='Slack Message', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Temperature", type=False, side=True, value="20", applet_id=Applet.objects.filter(user_id=user_id, id_applet=3).get().id).save()
    ParamApplet(name="City", type=True, side=True, value="Toulouse", applet_id=Applet.objects.filter(user_id=user_id, id_applet=3).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="La température dépasse ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=3).get().id).save()

    ## Exchange
    Applet(id_applet=4, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[4], action='exceeds a threshold', action_logo='http://' + settings.MY_IP + 'static/weather.png',
        reaction_service=settings.SERVICE_NAME[5], reaction='Google Mail', reaction_logo='http://' + settings.MY_IP + 'static/googlemail.png').save()
    ParamApplet(name="Temperature", type=False, side=True, value="20", applet_id=Applet.objects.filter(user_id=user_id, id_applet=4).get().id).save()
    ParamApplet(name="City", type=True, side=True, value="Toulouse", applet_id=Applet.objects.filter(user_id=user_id, id_applet=4).get().id).save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=4).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="Température", applet_id=Applet.objects.filter(user_id=user_id, id_applet=4).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="La température dépasse ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=4).get().id).save()

    ## Notify
    Applet(id_applet=5, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[4], action='exceeds a threshold', action_logo='http://' + settings.MY_IP + 'static/weather.png',
        reaction_service=settings.SERVICE_NAME[6], reaction='Notification', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Temperature", type=False, side=True, value="20", applet_id=Applet.objects.filter(user_id=user_id, id_applet=5).get().id).save()
    ParamApplet(name="City", type=True, side=True, value="Toulouse", applet_id=Applet.objects.filter(user_id=user_id, id_applet=5).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="La température dépasse ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=5).get().id).save()


    #### The temperature is below a threshold ####
    ## Slack
    Applet(id_applet=6, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[4], action='below a threshold', action_logo='http://' + settings.MY_IP + 'static/weather.png',
        reaction_service=settings.SERVICE_NAME[2], reaction='Slack Message', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Temperature", type=False, side=True, value="20", applet_id=Applet.objects.filter(user_id=user_id, id_applet=6).get().id).save()
    ParamApplet(name="City", type=True, side=True, value="Toulouse", applet_id=Applet.objects.filter(user_id=user_id, id_applet=6).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="La température est en dessous de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=6).get().id).save()

    ## Exchange
    Applet(id_applet=7, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[4], action='below a threshold', action_logo='http://' + settings.MY_IP + 'static/weather.png',
        reaction_service=settings.SERVICE_NAME[5], reaction='Google Mail', reaction_logo='http://' + settings.MY_IP + 'static/googlemail.png').save()
    ParamApplet(name="Temperature", type=False, side=True, value="20", applet_id=Applet.objects.filter(user_id=user_id, id_applet=7).get().id).save()
    ParamApplet(name="City", type=True, side=True, value="Toulouse", applet_id=Applet.objects.filter(user_id=user_id, id_applet=7).get().id).save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=7).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="Température", applet_id=Applet.objects.filter(user_id=user_id, id_applet=7).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="La température est en dessous de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=7).get().id).save()

    ## Notify
    Applet(id_applet=8, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[4], action='below a threshold', action_logo='http://' + settings.MY_IP + 'static/weather.png',
        reaction_service=settings.SERVICE_NAME[6], reaction='Notification', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Temperature", type=False, side=True, value="20", applet_id=Applet.objects.filter(user_id=user_id, id_applet=8).get().id).save()
    ParamApplet(name="City", type=True, side=True, value="Toulouse", applet_id=Applet.objects.filter(user_id=user_id, id_applet=8).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="La température est en dessous de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=8).get().id).save()


    #### Receive an email ####
    ## Slack
    Applet(id_applet=9, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[5], action='receive email', action_logo='http://' + settings.MY_IP + 'static/googlemail.png',
        reaction_service=settings.SERVICE_NAME[2], reaction='Slack Message', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Message", type=True, side=False, value="Vous avez reçu un email", applet_id=Applet.objects.filter(user_id=user_id, id_applet=9).get().id).save()

    ## Exchange
    Applet(id_applet=10, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[5], action='receive email', action_logo='http://' + settings.MY_IP + 'static/googlemail.png',
        reaction_service=settings.SERVICE_NAME[5], reaction='Google Mail', reaction_logo='http://' + settings.MY_IP + 'static/googlemail.png').save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=10).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="Reception d'email", applet_id=Applet.objects.filter(user_id=user_id, id_applet=10).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="Vous avez reçu un email", applet_id=Applet.objects.filter(user_id=user_id, id_applet=10).get().id).save()

    ## Notify
    Applet(id_applet=11, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[5], action='receive email', action_logo='http://' + settings.MY_IP + 'static/googlemail.png',
        reaction_service=settings.SERVICE_NAME[6], reaction='Notification', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Message", type=True, side=False, value="Vous avez reçu un email", applet_id=Applet.objects.filter(user_id=user_id, id_applet=11).get().id).save()


    #### Report a mark below a limit ####
    ## Slack
    Applet(id_applet=12, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action='mark below a limit', action_logo='http://' + settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[2], reaction='Slack Message', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='10', applet_id=Applet.objects.filter(user_id=user_id, id_applet=12).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="Une note a était ajouté en dessous de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=12).get().id).save()

    ## Exchange
    Applet(id_applet=13, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action='mark below a limit', action_logo='http://' + settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[5], reaction='Google Mail', reaction_logo='http://' + settings.MY_IP + 'static/googlemail.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='10', applet_id=Applet.objects.filter(user_id=user_id, id_applet=13).get().id).save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=13).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="Une note a etait ajouté", applet_id=Applet.objects.filter(user_id=user_id, id_applet=13).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="Une note a était ajouté en dessous de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=13).get().id).save()

    ## Notify
    Applet(id_applet=14, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action='mark below a limit', action_logo='http://' + settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[6], reaction='Notification', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='10', applet_id=Applet.objects.filter(user_id=user_id, id_applet=14).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="Une note a était ajouté en dessous de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=14).get().id).save()


    #### Report a credit number that exceeds a target ####
    ## Slack
    Applet(id_applet=15, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action='credit number that exceeds', action_logo='http://' + settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[2], reaction='Slack Message', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='120', applet_id=Applet.objects.filter(user_id=user_id, id_applet=15).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="Un crédit à était ajouté au dessus de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=15).get().id).save()

    ## Exchange
    Applet(id_applet=16, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action='credit number that exceeds', action_logo='http://' + settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[5], reaction='Google Mail', reaction_logo='http://' + settings.MY_IP + 'static/googlemail.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='120', applet_id=Applet.objects.filter(user_id=user_id, id_applet=16).get().id).save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=16).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="Nouveau crédit", applet_id=Applet.objects.filter(user_id=user_id, id_applet=16).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="Un crédit à était ajouté au dessus de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=16).get().id).save()

    ## Notify
    Applet(id_applet=17, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action='credit number that exceeds', action_logo='http://' + settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[6], reaction='Notification', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='120', applet_id=Applet.objects.filter(user_id=user_id, id_applet=17).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="Un crédit à était ajouté au dessus de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=17).get().id).save()


    #### The GPA drops below a threshold ####
    ## Slack
    Applet(id_applet=18, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action='gpa drop below', action_logo='http://' + settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[2], reaction='Slack Message', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='2', applet_id=Applet.objects.filter(user_id=user_id, id_applet=18).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="Le GPA est passé en dessous de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=18).get().id).save()

    ## Exchange
    Applet(id_applet=19, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action='gpa drop below', action_logo='http://' + settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[5], reaction='Google Mail', reaction_logo='http://' + settings.MY_IP + 'static/googlemail.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='2', applet_id=Applet.objects.filter(user_id=user_id, id_applet=19).get().id).save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=19).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="Nouveau GPA", applet_id=Applet.objects.filter(user_id=user_id, id_applet=19).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="Le GPA est passé en dessous de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=19).get().id).save()

    ## Notify
    Applet(id_applet=20, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action='gpa drop below', action_logo='http://' + settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[6], reaction='Notification', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='2', applet_id=Applet.objects.filter(user_id=user_id, id_applet=20).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="Le GPA est passé en dessous de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=20).get().id).save()


    #### The GPA exceeds a threshold ####
    ## Slack
    Applet(id_applet=21, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action='gpa exceeds', action_logo='http://' + settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[2], reaction='Slack Message', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='3', applet_id=Applet.objects.filter(user_id=user_id, id_applet=21).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="Le GPA est passé au dessus de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=21).get().id).save()

    ## Exchange
    Applet(id_applet=22, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action='gpa exceeds', action_logo='http://' + settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[5], reaction='Google Mail', reaction_logo='http://' + settings.MY_IP + 'static/googlemail.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='3', applet_id=Applet.objects.filter(user_id=user_id, id_applet=22).get().id).save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=22).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="Nouveau GPA", applet_id=Applet.objects.filter(user_id=user_id, id_applet=22).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="Le GPA est passé au dessus de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=22).get().id).save()

    ## Notify
    Applet(id_applet=23, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action='gpa exceeds', action_logo='http://' + settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[6], reaction='Notification', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='3', applet_id=Applet.objects.filter(user_id=user_id, id_applet=23).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="Le GPA est passé au dessus de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=23).get().id).save()


    #### The value of a currency drops below a threshold ####
    ## Slack
    Applet(id_applet=24, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[3], action='bitcoin drop', action_logo='http://' + settings.MY_IP + 'static/bitcoin.png',
        reaction_service=settings.SERVICE_NAME[2], reaction='Slack Message', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Bitcoin value", type=False, side=True, value="200", applet_id=Applet.objects.filter(user_id=user_id, id_applet=24).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="La bitcoin est passé en dessous de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=24).get().id).save()

    ## Exchange
    Applet(id_applet=25, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[3], action='bitcoin drop', action_logo='http://' + settings.MY_IP + 'static/bitcoin.png',
        reaction_service=settings.SERVICE_NAME[5], reaction='Google Mail', reaction_logo='http://' + settings.MY_IP + 'static/googlemail.png').save()
    ParamApplet(name="Bitcoin value", type=False, side=True, value="200", applet_id=Applet.objects.filter(user_id=user_id, id_applet=25).get().id).save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=25).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="Bitcoin changement de valeur", applet_id=Applet.objects.filter(user_id=user_id, id_applet=25).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="La bitcoin est passé en dessous de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=25).get().id).save()

    ## Notify
    Applet(id_applet=26, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[3], action='bitcoin drop', action_logo='http://' + settings.MY_IP + 'static/bitcoin.png',
        reaction_service=settings.SERVICE_NAME[6], reaction='Notification', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Bitcoin value", type=False, side=True, value="200", applet_id=Applet.objects.filter(user_id=user_id, id_applet=26).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="La bitcoin est passé en dessous de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=26).get().id).save()


    #### The value of a currency exceeds a threshold ####
    ## Slack
    Applet(id_applet=27, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[3], action='bitcoin up', action_logo='http://' + settings.MY_IP + 'static/bitcoin.png',
        reaction_service=settings.SERVICE_NAME[2], reaction='Slack Message', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Bitcoin value", type=False, side=True, value="200", applet_id=Applet.objects.filter(user_id=user_id, id_applet=27).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="La bitcoin est passé en dessous de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=27).get().id).save()

    ## Exchange
    Applet(id_applet=28, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[3], action='bitcoin up', action_logo='http://' + settings.MY_IP + 'static/bitcoin.png',
        reaction_service=settings.SERVICE_NAME[5], reaction='Google Mail', reaction_logo='http://' + settings.MY_IP + 'static/googlemail.png').save()
    ParamApplet(name="Bitcoin value", type=False, side=True, value="200", applet_id=Applet.objects.filter(user_id=user_id, id_applet=28).get().id).save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=28).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="Bitcoin changement de valeur", applet_id=Applet.objects.filter(user_id=user_id, id_applet=28).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="La bitcoin est passé en dessous de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=28).get().id).save()

    ## Notify
    Applet(id_applet=29, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[3], action='bitcoin up', action_logo='http://' + settings.MY_IP + 'static/bitcoin.png',
        reaction_service=settings.SERVICE_NAME[6], reaction='Notification', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Bitcoin value", type=False, side=True, value="200", applet_id=Applet.objects.filter(user_id=user_id, id_applet=29).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="La bitcoin est passé en dessous de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=29).get().id).save()


    #### Receive a slack notification ####
    ## Slack
    Applet(id_applet=30, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[2], action='receive notification', action_logo='http://' + settings.MY_IP + 'static/slack.png',
        reaction_service=settings.SERVICE_NAME[2], reaction='Slack Message', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Message", type=True, side=False, value="Le GPA est passé en dessous de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=30).get().id).save()

    ## Exchange
    Applet(id_applet=31, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[2], action='receive notification', action_logo='http://' + settings.MY_IP + 'static/slack.png',
        reaction_service=settings.SERVICE_NAME[5], reaction='Google Mail', reaction_logo='http://' + settings.MY_IP + 'static/googlemail.png').save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=31).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="Nouveau GPA", applet_id=Applet.objects.filter(user_id=user_id, id_applet=31).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="Le GPA est passé en dessous de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=31).get().id).save()

    ## Notify
    Applet(id_applet=32, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[2], action='receive notification', action_logo='http://' + settings.MY_IP + 'static/slack.png',
        reaction_service=settings.SERVICE_NAME[6], reaction='Notification', reaction_logo='http://' + settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Message", type=True, side=False, value="Le GPA est passé en dessous de ...", applet_id=Applet.objects.filter(user_id=user_id, id_applet=32).get().id).save()


    Github(user_id=user_id).save()
    Intra(user_id=user_id).save()
    Slack(user_id=user_id).save()
    Google(user_id=user_id).save()


def request_create(user_id, url):
    hed = {'Authorization': user_id}
    response = requests.get(url, headers=hed)
    return response


######## ACTION ########
def verify_github(app):
    if app.action == 'new commit':
        print("Start test Github", file=stderr)
        token = Github.objects.get(user_id=app.user_id).token
        if not token:
            return False
        owner = ParamApplet.objects.filter(applet_id=app.id, name='Owner Name', side=True).get().value
        repo = ParamApplet.objects.filter(applet_id=app.id, name='Repository Name', side=True).get().value
        r = request_create(token, settings.SERVICE_GITHUB + 'v1/github/' + owner + '/' + repo + '/last/commit')
        j = json.loads(r.text)
        if j['data']['commit'][0] != app.data:
            Applet.objects.filter(id=app.id).update(data=j['data']['commit'][0])
            return True
    return False


def verify_intra(app):
    limit = ParamApplet.objects.filter(applet_id=app.id, side=True, name="Limit").get().value
    token = Intra.objects.get(user_id=app.user_id).token
    if token == None:
        return False
    if app.action == 'mark below a limit':
        print('Start verif mark below a limit', file=stderr)
        r = request_create(token, settings.SERVICE_INTRA + 'v1/intra/marks')
        j = json.loads(r.text)
        if len(j['data']) > 0 and j['data'][0]['title_link'] != app.data:
            Applet.objects.filter(id=app.id).update(data=j['data'][0]['title_link'])
            return True
    elif app.action == 'credit number that exceeds':
        print('Start verif credit number that exceeds', file=stderr)
        r = request_create(token, settings.SERVICE_INTRA + 'v1/intra/grade/bachelor')
        j = json.loads(r.text)
        if float(j['data']['credits']) > float(limit):
            ParamApplet.objects.filter(applet_id=app.id, name="Limit").update(value=j['data']['credits'])
            return True
    elif app.action == 'gpa drop below':
        print('Start verif gpa drop below', file=stderr)
        r = request_create(token, settings.SERVICE_INTRA + 'v1/intra/grade/bachelor')
        j = json.loads(r.text)
        if float(j['data']['gpa']) < float(limit):
            ParamApplet.objects.filter(applet_id=app.id, name='Limit').update(value=j['data']['gpa'])
            return True
    elif app.action == 'gpa exceeds':
        print('Start verif gpa exceeds', file=stderr)
        r = request_create(token, settings.SERVICE_INTRA + 'v1/intra/grade/bachelor')
        j = json.loads(r.text)
        if float(j['data']['gpa']) > float(limit):
            ParamApplet.objects.filter(applet_id=app.id, name='Limit').update(value=j['data']['gpa'])
            return True
    return False


def verify_slack(app):
    app = app


def verify_currency(app):
    app = app


def verify_weather(app):
    temperature = ParamApplet.objects.get(applet_id=app.id, name='Temperature').value
    city = ParamApplet.objects.get(applet_id=app.id, name='City').value
    r = request_create('', settings.SERVICE_WEATHER + 'v1/weather/city?city=' + str(city))
    j = json.loads(r.text)
    if app.action == 'exceeds a threshold':
        print("Start test Weather exceeds")
        if float(j['data']['temp']) > float(temperature) and not app.data:
            Applet.objects.filter(id=app.id).update(data=j['data']['temp'])
            return True
        elif app.data and float(j['data']['temp']) < float(temperature):
            Applet.objects.filter(id=app.id).update(data=None)
    elif app.action == 'below a threshold':
        print("Start test Weather below")
        if float(j['data']['temp']) < float(temperature) and not app.data:
            Applet.objects.filter(id=app.id).update(data=j['data']['temp'])
            return True
        elif app.data and float(j['data']['temp']) > float(temperature):
            Applet.objects.filter(id=app.id).update(data=None)
    return False


def verify_googlemail(app):
    app = app


######## REACTION ######
def reaction_slack(app):
    print("REACTION SLACK !!!", file=stderr)


def reaction_email(app):
    print("REACTION EMAIL !!!", file=stderr)


def reaction_notify(app):
    print("REACTION NOTIF !!!", file=stderr)
    Notif(user_id=app.user_id, message=ParamApplet.objects.get(applet_id=app.id, side=False, name='Message').value).save()
