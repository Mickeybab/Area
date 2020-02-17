from django.http import HttpResponse, Http404
import json
from link_api.models import Intra, Applet, ParamApplet, Github, Intra, Slack, Microsoft, User
from link_api import settings
from link_api import util
from django.db import transaction
from django.views.decorators.http import require_http_methods
from django.shortcuts import get_object_or_404
from django.views.decorators.csrf import csrf_exempt


class JsonResponse(HttpResponse):
    def __init__(self, data, **kwargs):
        if settings.DEBUG:
            data = json.dumps(data, indent=4, sort_keys=True)
        else:
            data = json.dumps(data)
        super(JsonResponse, self).__init__(content=data, content_type='application/json', **kwargs)


def applet_to_json(app):
    return {
        'id': app.id_applet,
        'title': util.applet_id_to_name(app.id_applet),
        'description': util.applet_id_to_description(app.id_applet),
        'color': util.applet_id_to_color(app.id_applet),
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
@csrf_exempt
@require_http_methods(['GET'])
def get_applets(request):
    if not request.GET['user_id']:
        return HttpResponse('Ko, need user_id')
    result = []
    for app in Applet.objects.filter(user_id=request.GET['user_id']):
        temp = applet_to_json(app)
        result.append(temp)
    print(result)
    return JsonResponse(result)


@csrf_exempt
@require_http_methods(['GET'])
def get_applet(request, id):
    if not request.GET['user_id']:
        return HttpResponse('Ko, need user_id')
    app = Applet.objects.filter(user_id=request.GET['user_id'], id_applet=id).get()
    return JsonResponse(applet_to_json(app))


@csrf_exempt
@require_http_methods(['POST'])
def set_applet(request, id):

    if not request.POST.get('user_id'):
        return HttpResponse('Ko, need user_id')
    
    def fill_applet(param):
        p = ParamApplet()
        p.name = param['name']
        p.type = False if param['type'] == 'int' else True
        p.value = param['value']
        p.id_applet = app.id
        return p

    with transaction.atomic():
        app = Applet.objects.get(user_id=request.POST.get('user_id'), id_applet=int(id)).select_for_update()
        app.enable = True
        app.action_service = request.POST.get('action')['service']
        app.action = request.POST.get('action')['action']
        app.reaction_service = request.POST.get('reaction')['service']
        app.reaction = request.POST.get('reaction')['reaction']
        app.save()

    for param in ParamApplet.objects.filter(applet_id=app.id):
        param.delete()

    for param in request.POST.get('action')['param']:
        p = fill_applet(param)
        p.side = True
        p.save()

    for param in request.POST.get('reaction')['param']:
        p = fill_applet(param)
        p.side = False
        p.save()

    return HttpResponse('Ok')


@csrf_exempt
@require_http_methods(['POST'])
def activate_applet(request, id):
    if not request.POST.get('user_id'):
        return HttpResponse('Ko, need user_id')
    Applet.objects.filter(user_id=request.POST.get('user_id'), id_applet=id).update(enable=True)
    return HttpResponse('Ok')


@csrf_exempt
@require_http_methods(['POST'])
def desactivate_applet(request, id):
    if not request.POST.get('user_id'):
        return HttpResponse('Ko, need user_id')
    Applet.objects.filter(user_id=request.POST.get('user_id'), id_applet=id).update(enable=False)
    return HttpResponse('Ok')


@csrf_exempt
@require_http_methods(['GET'])
def get_applet_by_action(request, service, action):
    if not request.GET['user_id']:
        return HttpResponse('Ko, need user_id')
    result = []
    for app in Applet.objects.filter(user_id=request.GET['user_id']):
        if (app.action_service == service and app.action == action) or (app.reaction_service == service and app.reaction == action):
            result.append(app)
    return JsonResponse([applet_to_json(a) for a in result])


@csrf_exempt
@require_http_methods(['GET'])
def search_applets(request):
    if not request.GET['user_id'] or not request.GET['stringTosearch']:
        return HttpResponse('Ko, need user_id')
    applets = []
    for s in Applet.objects.filter(action_service__icontains=request.GET['stringTosearch']):
        applets.append(s)
    for s in Applet.objects.filter(reaction_service__icontains=request.GET['stringTosearch']):
        applets.append(s)
    for s in Applet.objects.filter(action__icontains=request.GET['stringTosearch']):
        applets.append(s)
    for s in Applet.objects.filter(reaction__icontains=request.GET['stringTosearch']):
        applets.append(s)
    return JsonResponse([applet_to_json(s) for s in applets])


## SERVICE ##
@csrf_exempt
@require_http_methods(['POST'])
def sync_token(request, service):
    if not request.POST.get('user_id'):
        return HttpResponse('Ko, need user_id')
    if service == settings.SERVICE_NAME[0]:
        Github.objects.filter(user_id=request.POST.get('user_id')).update(token=request.POST.get('token'), refresh=request.POST.get('refresh'))
    elif service == settings.SERVICE_NAME[1]:
        Intra.objects.filter(user_id=request.POST.get('user_id')).update(token=request.POST.get('token'), refresh=request.POST.get('refresh'))
    elif service == settings.SERVICE_NAME[2]:
        Slack.objects.filter(user_id=request.POST.get('user_id')).update(token=request.POST.get('token'), refresh=request.POST.get('refresh'))
    elif service == settings.SERVICE_NAME[3]:
        Microsoft.objects.filter(user_id=request.POST.get('user_id')).update(token=request.POST.get('token'), refresh=request.POST.get('refresh'))
    return HttpResponse('Ok')


## USERS ##
@csrf_exempt
@require_http_methods(['POST'])
def create_user(request):
    if not request.POST.get('user_id'):
        return HttpResponse('Ko, need user_id')
    user_id = request.POST.get('user_id')
    User(user_id=user_id).save()
    Applet(id_applet=0, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[0], action='test', action_logo='a', reaction_service=settings.SERVICE_NAME[5], reaction='test', reaction_logo='a').save()
    Applet(id_applet=1, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[1], action='test', action_logo='a', reaction_service=settings.SERVICE_NAME[4], reaction='test', reaction_logo='a').save()
    Applet(id_applet=2, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[2], action='test', action_logo='a', reaction_service=settings.SERVICE_NAME[3], reaction='test', reaction_logo='a').save()
    Applet(id_applet=3, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[3], action='test', action_logo='a', reaction_service=settings.SERVICE_NAME[2], reaction='test', reaction_logo='a').save()
    Applet(id_applet=4, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[4], action='test', action_logo='a', reaction_service=settings.SERVICE_NAME[1], reaction='test', reaction_logo='a').save()
    Applet(id_applet=5, enable=False, user_id=user_id, action_service=settings.SERVICE_NAME[5], action='test', action_logo='a', reaction_service=settings.SERVICE_NAME[0], reaction='test', reaction_logo='a').save()
    Github(user_id=user_id).save()
    Intra(user_id=user_id).save()
    Slack(user_id=user_id).save()
    Microsoft(user_id=user_id).save()
    return HttpResponse('Ok')


@csrf_exempt
@require_http_methods(['POST'])
def update_user(request, user_id):
    if not request.POST.get('user_id'):
        return HttpResponse('Ko, need user_id')
    try:
        user = get_object_or_404(User, user_id=user_id)
    except User.DoesNotExist:
        return Http404("User not found.")
    return HttpResponse('Ok')