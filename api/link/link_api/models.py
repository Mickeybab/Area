# -*- coding: utf-8 -*-

from django.db import models


class Applet(models.Model):
    id_applet = models.IntegerField(default=0)
    enable = models.BooleanField(default=True)
    user_id = models.CharField(max_length=255)
    action_service = models.CharField(max_length=50)
    action = models.CharField(max_length=50)
    action_logo = models.CharField(max_length=100)
    reaction_service = models.CharField(max_length=50)
    reaction = models.CharField(max_length=50)
    reaction_logo = models.CharField(max_length=100)


class ParamApplet(models.Model):
    name = models.CharField(max_length=100)
    type = models.BooleanField(default=True)     # True = string, Flase = int
    side = models.BooleanField(default=True)     # True = action, Flase = reaction
    value = models.CharField(max_length=100)
    applet_id = models.IntegerField(default=0)


class Github(models.Model):
    user_id = models.CharField(max_length=255)
    token = models.CharField(max_length=255)


class Intra(models.Model):
    user_id = models.CharField(max_length=255)
    token = models.CharField(max_length=255)


class Slack(models.Model):
    user_id = models.CharField(max_length=255)
    token = models.CharField(max_length=255)


class Microsoft(models.Model):
    user_id = models.CharField(max_length=255)
    token = models.CharField(max_length=255)


class Value(models.Model):
    name = models.CharField(max_length=255)


class User(models.Model):
    user_id = models.CharField(max_length=255)
    name = models.CharField(max_length=255, null=True)
    last_name = models.CharField(max_length=255, null=True)