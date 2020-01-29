# -*- coding: utf-8 -*-

from django.db import models


class Intra(models.Model):
    user_id = models.CharField(max_length=255)
    token = models.CharField(max_length=255)
