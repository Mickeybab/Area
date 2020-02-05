# -*- coding: utf-8 -*-

from django.db import models


class Intra(models.Model):
    user_id = models.CharField(max_length=255)
    token = models.CharField(max_length=255)


class Link(models.Model):
    user_id = models.CharField(max_length=255)
    action_name = models.CharField(max_length=50)
    reaction_name = models.CharField(max_length=50)
    value = models.CharField(max_length=500)
    value_to_compare = models.CharField(max_length=255)
