"""link_api URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from link_api import api

urlpatterns = [
    path('admin/', admin.site.urls),

    path('applets/', api.get_applets),
    path('applets/<int:id>', api.get_applet),
    path('applets/<int:id>/add', api.set_applet),
    path('applets/<int:id>/activate', api.activate_applet),
    path('applets/<int:id>/desactivate', api.desactivate_applet),
    path('applets/<str:service>/<str:action>', api.get_applet_by_action),
    path('applets/search', api.search_applets),

    path('users/create', api.create_user),
    path('users/<str:user_id>', api.update_user),

    path('services/<str:service>', api.sync_token),
]
