from django.http import HttpResponse
import json
from link_api.models import Intra, Applet, ParamApplet, Github, Intra, Slack, Microsoft
from link_api import settings
from link_api import util
from django.db import transaction
from django.views.decorators.http import require_http_methods


class JsonResponse(HttpResponse):
    def __init__(self, data, **kwargs):
        if settings.DEBUG:
            data = json.dumps(data, indent=4, sort_keys=True)
        else:
            data = json.dumps(data)
        super(JsonResponse, self).__init__(content=data, content_type='application/json', **kwargs)


def applet_to_json(app):
    return {
        'id': app.applet_id,
        'title': util.applet_id_to_name(app.applet_id),
        'description': util.applet_id_to_description(app.applet_id),
        'color': util.applet_id_to_color(app.applet_id),
        'enable': 'True' if app.enable else 'False',
        'action': {
            'service': app.action_service,
            'logo': app.action_logo,
            'action': app.action,
            'param': [
                {
                    'name': p.name,
                    'type': 'string' if p.type else 'int',
                    'value': p.value
                } for p in ParamApplet.objects.filter(applet_id=app.id, side=True)
            ]
        },
        'reaction': {
            'service': app.reaction_service,
            'logo': app.reaction_logo,
            'reaction': app.reaction,
            'param': [
                {
                    'name': p.name,
                    'type': 'string' if p.type else 'int',
                    'value': p.value
                } for p in ParamApplet.objects.filter(applet_id=app.id, side=False)
            ]
        }
    }


##### APPLET #####
@require_http_methods(['GET'])
def get_applets(request):
    result = []
    for app in Applet.objects.filter(user_id=request.GET['user_id']):
        temp = applet_to_json(app)
        result.append(temp)
    print(result)
    return JsonResponse(result)


@require_http_methods(['GET'])
def get_applet(request, id):
    app = Applet.objects.filter(user_id=request['user_id'], applet_id=id)
    return JsonResponse(applet_to_json(app))


@require_http_methods(['POST'])
def set_applet(request, id):
    if request.method == 'POST':
        with transaction.atomic():
            app = Applet.objects.get(user_id=request.POST['user_id'], id_applet=int(id)).select_for_update()
            app.enable = True
            app.action_service = request.POST['action']['service']
            app.action = request.POST['action']['action']
            app.reaction_service = request.POST['reaction']['service']
            app.reaction = request.POST['reaction']['reaction']
            app.save()

        for param in ParamApplet.objects.filter(applet_id=app.id):
            param.delete()

        for param in request.POST['action']['param']:
            p = ParamApplet()
            p.name = param['name']
            p.type = False if param['type'] == 'int' else True
            p.value = param['value']
            p.applet_id = app.id
            p.side = True
            p.save()

        for param in request.POST['reaction']['param']:
            p = ParamApplet()
            p.name = param['name']
            p.type = False if param['type'] == 'int' else True
            p.value = param['value']
            p.applet_id = app.id
            p.side = False
            p.save()

        return HttpResponse('Ok')
    return HttpResponse('Ko')


@require_http_methods(['POST'])
def activate_applet(request, id):
    Applet.objects.filter(user_id=request['user_id'], applet_id=id).update(enable=True)
    return HttpResponse('Ok')


@require_http_methods(['POST'])
def desactivate_applet(request, id):
    Applet.objects.filter(user_id=request['user_id'], applet_id=id).update(enable=False)
    return HttpResponse('Ok')


## SERVICE ##
@require_http_methods(['POST'])
def sync_token(request, service):
    if service == settings.SERVICE_NAME[0]:
        Github.objects.filter(user_id=request['user_id']).update(token=request['token'])
    elif service == settings.SERVICE_NAME[1]:
        Intra.objects.filter(user_id=request['user_id']).update(token=request['token'])
    elif service == settings.SERVICE_NAME[2]:
        Slack.objects.filter(user_id=request['user_id']).update(token=request['token'])
    elif service == settings.SERVICE_NAME[3]:
        Microsoft.objects.filter(user_id=request['user_id']).update(token=request['token'])
    return HttpResponse('Ok')
