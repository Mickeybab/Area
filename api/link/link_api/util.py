from link_api.models import Intra, Applet, ParamApplet, Github, Intra, Slack, Google, User, Notif, Service, Title, Description, Color
from firebase_admin import auth
from django.shortcuts import get_object_or_404
from link_api import settings
import requests
import urllib
from sys import stderr
import json


def applet_id_to_name(id):
    return Title.objects.get(id=int(id) + 1).value


def applet_id_to_description(id):
    return Description.objects.get(id=int(id) + 1).value


def applet_id_to_color(id):
    return Color.objects.get(id=int(id) + 1).value


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
    Applet(id_applet=0, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[0], action=settings.GITHUB_ACTION[0], action_logo=settings.MY_IP + 'static/github.png',
        reaction_service=settings.SERVICE_NAME[2], reaction=settings.SLACK_REACTION[0], reaction_logo=settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Owner Name", type=True, side=True, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=0).get().id).save()
    ParamApplet(name="Repository Name", type=True, side=True, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=0).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="New commit on [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=0).get().id).save()

    ## Exchange
    Applet(id_applet=1, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[0], action=settings.GITHUB_ACTION[0], action_logo=settings.MY_IP + 'static/github.png',
        reaction_service=settings.SERVICE_NAME[7], reaction=settings.GOOGLE_REACTION[0], reaction_logo=settings.MY_IP + 'static/mail.png').save()
    ParamApplet(name="Owner Name", type=True, side=True, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=1).get().id).save()
    ParamApplet(name="Repository Name", type=True, side=True, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=1).get().id).save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=1).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="New commit", applet_id=Applet.objects.filter(user_id=user_id, id_applet=1).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="New commit on [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=1).get().id).save()

    ## Notify
    Applet(id_applet=2, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[0], action=settings.GITHUB_ACTION[0], action_logo=settings.MY_IP + 'static/github.png',
        reaction_service=settings.SERVICE_NAME[6], reaction=settings.NOTIFICATION_REACTION[0], reaction_logo=settings.MY_IP + 'static/notification.png').save()
    ParamApplet(name="Owner Name", type=True, side=True, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=2).get().id).save()
    ParamApplet(name="Repository Name", type=True, side=True, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=2).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="New commit on [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=2).get().id).save()


    #### The temperature exceeds a threshold ####
    ## Slack
    Applet(id_applet=3, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[4], action=settings.WEATHER_ACTION[1], action_logo=settings.MY_IP + 'static/weather.png',
        reaction_service=settings.SERVICE_NAME[2], reaction=settings.SLACK_REACTION[0], reaction_logo=settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Temperature", type=False, side=True, value="20", applet_id=Applet.objects.filter(user_id=user_id, id_applet=3).get().id).save()
    ParamApplet(name="City", type=True, side=True, value="Toulouse", applet_id=Applet.objects.filter(user_id=user_id, id_applet=3).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="The temperature is above [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=3).get().id).save()

    ## Exchange
    Applet(id_applet=4, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[4], action=settings.WEATHER_ACTION[1], action_logo=settings.MY_IP + 'static/weather.png',
        reaction_service=settings.SERVICE_NAME[7], reaction=settings.GOOGLE_REACTION[0], reaction_logo=settings.MY_IP + 'static/mail.png').save()
    ParamApplet(name="Temperature", type=False, side=True, value="20", applet_id=Applet.objects.filter(user_id=user_id, id_applet=4).get().id).save()
    ParamApplet(name="City", type=True, side=True, value="Toulouse", applet_id=Applet.objects.filter(user_id=user_id, id_applet=4).get().id).save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=4).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="Temperature", applet_id=Applet.objects.filter(user_id=user_id, id_applet=4).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="The temperature is above [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=4).get().id).save()

    ## Notify
    Applet(id_applet=5, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[4], action=settings.WEATHER_ACTION[1], action_logo=settings.MY_IP + 'static/weather.png',
        reaction_service=settings.SERVICE_NAME[6], reaction=settings.NOTIFICATION_REACTION[0], reaction_logo=settings.MY_IP + 'static/notification.png').save()
    ParamApplet(name="Temperature", type=False, side=True, value="20", applet_id=Applet.objects.filter(user_id=user_id, id_applet=5).get().id).save()
    ParamApplet(name="City", type=True, side=True, value="Toulouse", applet_id=Applet.objects.filter(user_id=user_id, id_applet=5).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="The temperature is above [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=5).get().id).save()


    #### The temperature is below a threshold ####
    ## Slack
    Applet(id_applet=6, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[4], action=settings.WEATHER_ACTION[0], action_logo=settings.MY_IP + 'static/weather.png',
        reaction_service=settings.SERVICE_NAME[2], reaction=settings.SLACK_REACTION[0], reaction_logo=settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Temperature", type=False, side=True, value="20", applet_id=Applet.objects.filter(user_id=user_id, id_applet=6).get().id).save()
    ParamApplet(name="City", type=True, side=True, value="Toulouse", applet_id=Applet.objects.filter(user_id=user_id, id_applet=6).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="The temperature is below [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=6).get().id).save()

    ## Exchange
    Applet(id_applet=7, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[4], action=settings.WEATHER_ACTION[0], action_logo=settings.MY_IP + 'static/weather.png',
        reaction_service=settings.SERVICE_NAME[7], reaction=settings.GOOGLE_REACTION[0], reaction_logo=settings.MY_IP + 'static/mail.png').save()
    ParamApplet(name="Temperature", type=False, side=True, value="20", applet_id=Applet.objects.filter(user_id=user_id, id_applet=7).get().id).save()
    ParamApplet(name="City", type=True, side=True, value="Toulouse", applet_id=Applet.objects.filter(user_id=user_id, id_applet=7).get().id).save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=7).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="Temperature", applet_id=Applet.objects.filter(user_id=user_id, id_applet=7).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="The temperature is below [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=7).get().id).save()

    ## Notify
    Applet(id_applet=8, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[4], action=settings.WEATHER_ACTION[0], action_logo=settings.MY_IP + 'static/weather.png',
        reaction_service=settings.SERVICE_NAME[6], reaction=settings.NOTIFICATION_REACTION[0], reaction_logo=settings.MY_IP + 'static/notification.png').save()
    ParamApplet(name="Temperature", type=False, side=True, value="20", applet_id=Applet.objects.filter(user_id=user_id, id_applet=8).get().id).save()
    ParamApplet(name="City", type=True, side=True, value="Toulouse", applet_id=Applet.objects.filter(user_id=user_id, id_applet=8).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="The temperature is below [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=8).get().id).save()


    #### Receive an email ####
    ## Slack
    Applet(id_applet=9, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[5], action=settings.GOOGLE_ACTION[0], action_logo=settings.MY_IP + 'static/googlemail.png',
        reaction_service=settings.SERVICE_NAME[2], reaction=settings.SLACK_REACTION[0], reaction_logo=settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Message", type=True, side=False, value="You received an email", applet_id=Applet.objects.filter(user_id=user_id, id_applet=9).get().id).save()

    ## Exchange
    Applet(id_applet=10, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[5], action=settings.GOOGLE_ACTION[0], action_logo=settings.MY_IP + 'static/googlemail.png',
        reaction_service=settings.SERVICE_NAME[7], reaction=settings.GOOGLE_REACTION[0], reaction_logo=settings.MY_IP + 'static/mail.png').save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=10).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="Email reception", applet_id=Applet.objects.filter(user_id=user_id, id_applet=10).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="You received an email", applet_id=Applet.objects.filter(user_id=user_id, id_applet=10).get().id).save()

    ## Notify
    Applet(id_applet=11, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[5], action=settings.GOOGLE_ACTION[0], action_logo=settings.MY_IP + 'static/googlemail.png',
        reaction_service=settings.SERVICE_NAME[6], reaction=settings.NOTIFICATION_REACTION[0], reaction_logo=settings.MY_IP + 'static/notification.png').save()
    ParamApplet(name="Message", type=True, side=False, value="You received an email", applet_id=Applet.objects.filter(user_id=user_id, id_applet=11).get().id).save()


    #### Report a mark below a limit ####
    ## Slack
    Applet(id_applet=12, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action=settings.INTRA_ACTION[0], action_logo=settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[2], reaction=settings.SLACK_REACTION[0], reaction_logo=settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='10', applet_id=Applet.objects.filter(user_id=user_id, id_applet=12).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="A note greater than [...] has been added", applet_id=Applet.objects.filter(user_id=user_id, id_applet=12).get().id).save()

    ## Exchange
    Applet(id_applet=13, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action=settings.INTRA_ACTION[0], action_logo=settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[7], reaction=settings.GOOGLE_REACTION[0], reaction_logo=settings.MY_IP + 'static/mail.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='10', applet_id=Applet.objects.filter(user_id=user_id, id_applet=13).get().id).save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=13).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="A note was added", applet_id=Applet.objects.filter(user_id=user_id, id_applet=13).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="A note greater than [...] has been added", applet_id=Applet.objects.filter(user_id=user_id, id_applet=13).get().id).save()

    ## Notify
    Applet(id_applet=14, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action=settings.INTRA_ACTION[0], action_logo=settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[6], reaction=settings.NOTIFICATION_REACTION[0], reaction_logo=settings.MY_IP + 'static/notification.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='10', applet_id=Applet.objects.filter(user_id=user_id, id_applet=14).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="A note greater than [...] has been added", applet_id=Applet.objects.filter(user_id=user_id, id_applet=14).get().id).save()


    #### Report a credit number that exceeds a target ####
    ## Slack
    Applet(id_applet=15, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action=settings.INTRA_ACTION[1], action_logo=settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[2], reaction=settings.SLACK_REACTION[0], reaction_logo=settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='120', applet_id=Applet.objects.filter(user_id=user_id, id_applet=15).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="Your number of credits exceeds [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=15).get().id).save()

    ## Exchange
    Applet(id_applet=16, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action=settings.INTRA_ACTION[1], action_logo=settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[7], reaction=settings.GOOGLE_REACTION[0], reaction_logo=settings.MY_IP + 'static/mail.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='120', applet_id=Applet.objects.filter(user_id=user_id, id_applet=16).get().id).save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=16).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="New credit", applet_id=Applet.objects.filter(user_id=user_id, id_applet=16).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="Your number of credits exceeds [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=16).get().id).save()

    ## Notify
    Applet(id_applet=17, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action=settings.INTRA_ACTION[1], action_logo=settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[6], reaction=settings.NOTIFICATION_REACTION[0], reaction_logo=settings.MY_IP + 'static/notification.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='120', applet_id=Applet.objects.filter(user_id=user_id, id_applet=17).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="Your number of credits exceeds [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=17).get().id).save()


    #### The GPA drops below a threshold ####
    ## Slack
    Applet(id_applet=18, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action=settings.INTRA_ACTION[2], action_logo=settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[2], reaction=settings.SLACK_REACTION[0], reaction_logo=settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='2', applet_id=Applet.objects.filter(user_id=user_id, id_applet=18).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="My GPA went below [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=18).get().id).save()

    ## Exchange
    Applet(id_applet=19, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action=settings.INTRA_ACTION[2], action_logo=settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[7], reaction=settings.GOOGLE_REACTION[0], reaction_logo=settings.MY_IP + 'static/mail.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='2', applet_id=Applet.objects.filter(user_id=user_id, id_applet=19).get().id).save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=19).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="New GPA", applet_id=Applet.objects.filter(user_id=user_id, id_applet=19).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="My GPA went below [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=19).get().id).save()

    ## Notify
    Applet(id_applet=20, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action=settings.INTRA_ACTION[2], action_logo=settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[6], reaction=settings.NOTIFICATION_REACTION[0], reaction_logo=settings.MY_IP + 'static/notification.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='2', applet_id=Applet.objects.filter(user_id=user_id, id_applet=20).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="My GPA went below [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=20).get().id).save()


    #### The GPA exceeds a threshold ####
    ## Slack
    Applet(id_applet=21, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action=settings.INTRA_ACTION[3], action_logo=settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[2], reaction=settings.SLACK_REACTION[0], reaction_logo=settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='3', applet_id=Applet.objects.filter(user_id=user_id, id_applet=21).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="The GPA rose above [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=21).get().id).save()

    ## Exchange
    Applet(id_applet=22, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action=settings.INTRA_ACTION[3], action_logo=settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[7], reaction=settings.GOOGLE_REACTION[0], reaction_logo=settings.MY_IP + 'static/mail.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='3', applet_id=Applet.objects.filter(user_id=user_id, id_applet=22).get().id).save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=22).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="New GPA", applet_id=Applet.objects.filter(user_id=user_id, id_applet=22).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="The GPA rose above [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=22).get().id).save()

    ## Notify
    Applet(id_applet=23, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action=settings.INTRA_ACTION[3], action_logo=settings.MY_IP + 'static/intra.png',
        reaction_service=settings.SERVICE_NAME[6], reaction=settings.NOTIFICATION_REACTION[0], reaction_logo=settings.MY_IP + 'static/notification.png').save()
    ParamApplet(name="Limit", type=False, side=True, value='3', applet_id=Applet.objects.filter(user_id=user_id, id_applet=23).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="The GPA rose above [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=23).get().id).save()


    #### The value of a currency drops below a threshold ####
    ## Slack
    Applet(id_applet=24, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[3], action=settings.CURRENCY_ACTION[0], action_logo=settings.MY_IP + 'static/bitcoin.png',
        reaction_service=settings.SERVICE_NAME[2], reaction=settings.SLACK_REACTION[0], reaction_logo=settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Currency", type=True, side=True, value="USD", applet_id=Applet.objects.filter(user_id=user_id, id_applet=24).get().id).save()
    ParamApplet(name="Value", type=False, side=True, value="200", applet_id=Applet.objects.filter(user_id=user_id, id_applet=24).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="The money [...] has gone below [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=24).get().id).save()

    ## Exchange
    Applet(id_applet=25, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[3], action=settings.CURRENCY_ACTION[0], action_logo=settings.MY_IP + 'static/bitcoin.png',
        reaction_service=settings.SERVICE_NAME[7], reaction=settings.GOOGLE_REACTION[0], reaction_logo=settings.MY_IP + 'static/mail.png').save()
    ParamApplet(name="Currency", type=True, side=True, value="USD", applet_id=Applet.objects.filter(user_id=user_id, id_applet=25).get().id).save()
    ParamApplet(name="Value", type=False, side=True, value="200", applet_id=Applet.objects.filter(user_id=user_id, id_applet=25).get().id).save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=25).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="Bitcoin change in value", applet_id=Applet.objects.filter(user_id=user_id, id_applet=25).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="The money [...] has gone below [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=25).get().id).save()

    ## Notify
    Applet(id_applet=26, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[3], action=settings.CURRENCY_ACTION[0], action_logo=settings.MY_IP + 'static/bitcoin.png',
        reaction_service=settings.SERVICE_NAME[6], reaction=settings.NOTIFICATION_REACTION[0], reaction_logo=settings.MY_IP + 'static/notification.png').save()
    ParamApplet(name="Currency", type=True, side=True, value="USD", applet_id=Applet.objects.filter(user_id=user_id, id_applet=26).get().id).save()
    ParamApplet(name="Value", type=False, side=True, value="200", applet_id=Applet.objects.filter(user_id=user_id, id_applet=26).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="The money [...] has gone below [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=26).get().id).save()


    #### The value of a currency exceeds a threshold ####
    ## Slack
    Applet(id_applet=27, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[3], action=settings.CURRENCY_ACTION[1], action_logo=settings.MY_IP + 'static/bitcoin.png',
        reaction_service=settings.SERVICE_NAME[2], reaction=settings.SLACK_REACTION[0], reaction_logo=settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Currency", type=True, side=True, value="USD", applet_id=Applet.objects.filter(user_id=user_id, id_applet=27).get().id).save()
    ParamApplet(name="Value", type=False, side=True, value="200", applet_id=Applet.objects.filter(user_id=user_id, id_applet=27).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="The money [...] has gone over [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=27).get().id).save()

    ## Exchange
    Applet(id_applet=28, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[3], action=settings.CURRENCY_ACTION[1], action_logo=settings.MY_IP + 'static/bitcoin.png',
        reaction_service=settings.SERVICE_NAME[7], reaction=settings.GOOGLE_REACTION[0], reaction_logo=settings.MY_IP + 'static/mail.png').save()
    ParamApplet(name="Currency", type=True, side=True, value="USD", applet_id=Applet.objects.filter(user_id=user_id, id_applet=28).get().id).save()
    ParamApplet(name="Value", type=False, side=True, value="200", applet_id=Applet.objects.filter(user_id=user_id, id_applet=28).get().id).save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=28).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="Bitcoin change in value", applet_id=Applet.objects.filter(user_id=user_id, id_applet=28).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="The money [...] has gone over [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=28).get().id).save()

    ## Notify
    Applet(id_applet=29, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[3], action=settings.CURRENCY_ACTION[1], action_logo=settings.MY_IP + 'static/bitcoin.png',
        reaction_service=settings.SERVICE_NAME[6], reaction=settings.NOTIFICATION_REACTION[0], reaction_logo=settings.MY_IP + 'static/notification.png').save()
    ParamApplet(name="Currency", type=True, side=True, value="USD", applet_id=Applet.objects.filter(user_id=user_id, id_applet=29).get().id).save()
    ParamApplet(name="Value", type=False, side=True, value="200", applet_id=Applet.objects.filter(user_id=user_id, id_applet=29).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="The money [...] has gone over [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=29).get().id).save()


    #### Receive a slack notification ####
    ## Slack
    Applet(id_applet=30, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[2], action=settings.SLACK_ACTION[0], action_logo=settings.MY_IP + 'static/slack.png',
        reaction_service=settings.SERVICE_NAME[2], reaction=settings.SLACK_REACTION[0], reaction_logo=settings.MY_IP + 'static/slack.png').save()
    ParamApplet(name="Message", type=True, side=False, value="My GPA went below [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=30).get().id).save()

    ## Exchange
    Applet(id_applet=31, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[2], action=settings.SLACK_ACTION[0], action_logo=settings.MY_IP + 'static/slack.png',
        reaction_service=settings.SERVICE_NAME[7], reaction=settings.GOOGLE_REACTION[0], reaction_logo=settings.MY_IP + 'static/mail.png').save()
    ParamApplet(name="Receiver", type=True, side=False, value="", applet_id=Applet.objects.filter(user_id=user_id, id_applet=31).get().id).save()
    ParamApplet(name="Subject", type=True, side=False, value="New GPA", applet_id=Applet.objects.filter(user_id=user_id, id_applet=31).get().id).save()
    ParamApplet(name="Message", type=True, side=False, value="My GPA went below [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=31).get().id).save()

    ## Notify
    Applet(id_applet=32, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[2], action=settings.SLACK_ACTION[0], action_logo=settings.MY_IP + 'static/slack.png',
        reaction_service=settings.SERVICE_NAME[6], reaction=settings.NOTIFICATION_REACTION[0], reaction_logo=settings.MY_IP + 'static/notification.png').save()
    ParamApplet(name="Message", type=True, side=False, value="My GPA went below [...]", applet_id=Applet.objects.filter(user_id=user_id, id_applet=32).get().id).save()


    Github(user_id=user_id).save()
    Intra(user_id=user_id).save()
    Slack(user_id=user_id).save()
    Google(user_id=user_id).save()

    Service(user_id=user_id, name=settings.SERVICE_NAME[0]).save()
    Service(user_id=user_id, name=settings.SERVICE_NAME[1]).save()
    Service(user_id=user_id, name=settings.SERVICE_NAME[2]).save()
    Service(user_id=user_id, name=settings.SERVICE_NAME[3]).save()
    Service(user_id=user_id, name=settings.SERVICE_NAME[4]).save()
    Service(user_id=user_id, name=settings.SERVICE_NAME[5]).save()
    Service(user_id=user_id, name=settings.SERVICE_NAME[6]).save()
    Service(user_id=user_id, name=settings.SERVICE_NAME[7]).save()


def request_create(user_id, url):
    hed = {'Authorization': user_id}
    response = requests.get(url, headers=hed)
    return response


######## ACTION ########
def verify_github(app):
    if app.action == settings.GITHUB_ACTION[0]:
        print("Start test Github", file=stderr)
        token = Github.objects.get(user_id=app.user_id).token
        if not token:
            return False
        owner = ParamApplet.objects.filter(applet_id=app.id, name='Owner Name', side=True).get().value
        repo = ParamApplet.objects.filter(applet_id=app.id, name='Repository Name', side=True).get().value
        if owner == '' or repo == '':
            return False
        r = request_create(token, settings.SERVICE_GITHUB + 'v1/github/' + owner + '/' + repo + '/last/commit')
        j = json.loads(r.text)
        if j['data']['commits'][0]['date'] != app.data:
            Applet.objects.filter(id=app.id).update(data=j['data']['commits'][0]['date'])
            return True
    return False


def verify_intra(app):
    limit = ParamApplet.objects.filter(applet_id=app.id, side=True, name="Limit").get().value
    token = Intra.objects.get(user_id=app.user_id).token
    if token == None:
        return False
    if app.action == settings.INTRA_ACTION[0]:
        print('Start verif mark below a limit', file=stderr)
        r = request_create(token, settings.SERVICE_INTRA + 'v1/intra/marks')
        j = json.loads(r.text)
        if len(j['data']) > 0 and j['data'][0]['title_link'] != app.data:
            Applet.objects.filter(id=app.id).update(data=j['data'][0]['title_link'])
            return True
    elif app.action == settings.INTRA_ACTION[1]:
        print('Start verif credit number that exceeds', file=stderr)
        r = request_create(token, settings.SERVICE_INTRA + 'v1/intra/grade/bachelor')
        j = json.loads(r.text)
        if float(j['data']['credits']) > float(limit):
            ParamApplet.objects.filter(applet_id=app.id, name="Limit").update(value=j['data']['credits'])
            return True
    elif app.action == settings.INTRA_ACTION[2]:
        print('Start verif gpa drop below', file=stderr)
        r = request_create(token, settings.SERVICE_INTRA + 'v1/intra/grade/bachelor')
        j = json.loads(r.text)
        if float(j['data']['gpa']) < float(limit):
            ParamApplet.objects.filter(applet_id=app.id, name='Limit').update(value=j['data']['gpa'])
            return True
    elif app.action == action.INTRA_ACTION[3]:
        print('Start verif gpa exceeds', file=stderr)
        r = request_create(token, settings.SERVICE_INTRA + 'v1/intra/grade/bachelor')
        j = json.loads(r.text)
        if float(j['data']['gpa']) > float(limit):
            ParamApplet.objects.filter(applet_id=app.id, name='Limit').update(value=j['data']['gpa'])
            return True
    return False


def verify_slack(app):
    print("Salut", file=stderr)
    if app.action == settings.SLACK_ACTION[0]:
        print("Start verif slack message", file=stderr)
        r = request_create('', settings.SERVICE_SLACK + 'v1/slack/message')
        j = json.loads(r.text)
        print(j, file=stderr)
        if (j['data'] and len(j['data']) > 0 and json.dumps(j['data'][0]) != app.data):
            Applet.objects.filter(id=app.id).update(data=json.dumps(j['data'][0]))
            return True
    return False


def verify_currency(app):
    currency = ParamApplet.objects.get(applet_id=app.id, side=True, name='Currency').value
    ref = ParamApplet.objects.get(applet_id=app.id, side=True, name='Value').value
    r = request_create('', settings.SERVICE_CURRENCY + 'v1/currency/convert?from=EUR&to=' + currency)
    j = json.loads(r.text)
    if app.action == settings.CURRENCY_ACTION[1]:
        print("Sart test money up")
        if float(j['data']['rates'][currency]) > float(ref):
            ParamApplet.objects.filter(applet_id=app.id, side=True, name='Value').update(value=j['data']['rates'][currency])
            return True
    elif app.action == settings.CURRENCY_ACTION[0]:
        print("Sart test money drop")
        if float(j['data']['rates'][currency]) < float(ref):
            ParamApplet.objects.filter(applet_id=app.id, side=True, name='Value').update(value=j['data']['rates'][currency])
            return True
    return False


def verify_weather(app):
    temperature = ParamApplet.objects.get(applet_id=app.id, name='Temperature').value
    city = ParamApplet.objects.get(applet_id=app.id, name='City').value
    r = request_create('', settings.SERVICE_WEATHER + 'v1/weather/city?city=' + str(city))
    j = json.loads(r.text)
    if app.action == settings.WEATHER_ACTION[1]:
        print("Start test Weather exceeds")
        if float(j['data']['temp']) > float(temperature) and not app.data:
            Applet.objects.filter(id=app.id).update(data=j['data']['temp'])
            return True
        elif app.data and float(j['data']['temp']) < float(temperature):
            Applet.objects.filter(id=app.id).update(data=None)
    elif app.action == settings.WEATHER_ACTION[0]:
        print("Start test Weather below")
        if float(j['data']['temp']) < float(temperature) and not app.data:
            Applet.objects.filter(id=app.id).update(data=j['data']['temp'])
            return True
        elif app.data and float(j['data']['temp']) > float(temperature):
            Applet.objects.filter(id=app.id).update(data=None)
    return False


def verify_googlemail(app):
    token = Google.objects.get(user_id=app.user_id).token
    if app.action == settings.GOOGLE_ACTION[0]:
        print('Start verif google gmail')
        r = request_create('', settings.SERVICE_GOOGLE + 'emails?access_token=' + token)
        print(r.text, file=stderr)
    return False


######## REACTION ######
def reaction_slack(app):
    print("REACTION SLACK !!!", file=stderr)
    msg = ParamApplet.objects.get(applet_id=app.id, side=False, name='Message').value
    requests.post(url=settings.SERVICE_SLACK + 'v1/slack/send?msg=' + msg)


def reaction_email(app):
    print("REACTION EMAIL !!!", file=stderr)
    receiver = ParamApplet.objects.get(applet_id=app.id, side=False, name='Receiver').value
    subject = ParamApplet.objects.get(applet_id=app.id, side=False, name='Subject').value
    msg = ParamApplet.objects.get(applet_id=app.id, side=False, name='Message').value
    if not receiver or receiver == '':
        return
    if not subject or subject == '':
        subject = 'Area'
    print("Send mail", file=stderr)
    requests.post(url=settings.SERVICE_EMAIL + 'v2/email/send', json={"to": receiver, "content": msg, "subject": subject})


def reaction_notify(app):
    print("REACTION NOTIF !!!", file=stderr)
    Notif(user_id=app.user_id, message=ParamApplet.objects.get(applet_id=app.id, side=False, name='Message').value).save()
