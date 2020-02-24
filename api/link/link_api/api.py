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
        'enable': True if app.enable else False,
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


def request_to_json(request):
    string = request.body.decode('utf8').replace("'", '"')
    print(string)
    return json.loads(string)


##### APPLET #####
@csrf_exempt
@require_http_methods(['GET'])
def get_applets(request):
    user_id = util.firebase_get_user_id(request.META['HTTP_AUTHORIZATION'])
    result = []
    for app in Applet.objects.filter(user_id=user_id):
        temp = applet_to_json(app)
        result.append(temp)
    return JsonResponse(result)


@csrf_exempt
@require_http_methods(['GET'])
def get_applet(request, id):
    user_id = util.firebase_get_user_id(request.META['HTTP_AUTHORIZATION'])
    app = Applet.objects.filter(user_id=user_id, id_applet=id).get()
    return JsonResponse(applet_to_json(app))


@csrf_exempt
@require_http_methods(['POST'])
def set_applet(request, id):

    data = request_to_json(request)
    user_id = util.firebase_get_user_id(request.META['HTTP_AUTHORIZATION'])
    
    def fill_applet(param):
        p = ParamApplet()
        p.name = param['name']
        p.type = False if param['type'] == 'int' else True
        p.value = param['value']
        p.id_applet = app.id
        return p

    with transaction.atomic():
        app = Applet.objects.select_for_update().get(user_id=user_id, id_applet=int(id))
        app.enable = True
        app.action_service = data['action']['service']
        app.action = data['action']['action']
        app.reaction_service = data['reaction']['service']
        app.reaction = data['reaction']['reaction']
        app.save()

    for param in ParamApplet.objects.filter(applet_id=app.id):
        param.delete()

    for param in data['action']['param']:
        p = fill_applet(param)
        p.side = True
        p.applet_id = app.id
        p.save()

    for param in data['reaction']['param']:
        p = fill_applet(param)
        p.side = False
        p.applet_id = app.id
        p.save()

    return HttpResponse('Ok')


@csrf_exempt
@require_http_methods(['POST'])
def activate_applet(request, id):
    user_id = util.firebase_get_user_id(request.META['HTTP_AUTHORIZATION'])
    Applet.objects.filter(user_id=user_id, id_applet=id).update(enable=True)
    return HttpResponse('Ok')


@csrf_exempt
@require_http_methods(['POST'])
def desactivate_applet(request, id):
    user_id = util.firebase_get_user_id(request.META['HTTP_AUTHORIZATION'])
    Applet.objects.filter(user_id=user_id, id_applet=id).update(enable=False)
    return HttpResponse('Ok')


@csrf_exempt
@require_http_methods(['GET'])
def get_applet_by_action(request, service, action):
    result = []
    user_id = util.firebase_get_user_id(request.META['HTTP_AUTHORIZATION'])
    for app in Applet.objects.filter(user_id=user_id):
        if (app.action_service == service and app.action == action) or (app.reaction_service == service and app.reaction == action):
            result.append(app)
    return JsonResponse([applet_to_json(a) for a in result])


@csrf_exempt
@require_http_methods(['GET'])
def search_applets(request):
    if not request.GET['stringTosearch']:
        return HttpResponse('Ko, need string search')
    user_id = util.firebase_get_user_id(request.META['HTTP_AUTHORIZATION'])
    applets = []
    for s in Applet.objects.filter(action_service__icontains=request.GET['stringTosearch'], user_id=user_id):
        applets.append(s)
    for s in Applet.objects.filter(reaction_service__icontains=request.GET['stringTosearch'], user_id=user_id):
        applets.append(s)
    for s in Applet.objects.filter(action__icontains=request.GET['stringTosearch'], user_id=user_id):
        applets.append(s)
    for s in Applet.objects.filter(reaction__icontains=request.GET['stringTosearch'], user_id=user_id):
        applets.append(s)
    return JsonResponse([applet_to_json(s) for s in applets])


## SERVICE ##
@csrf_exempt
@require_http_methods(['POST'])
def sync_token(request, service):
    user_id = util.firebase_get_user_id(request.META['HTTP_AUTHORIZATION'])
    if service == settings.SERVICE_NAME[0]:
        Github.objects.filter(user_id=user_id).update(token=request.POST.get('token'), refresh=request.POST.get('refresh'))
    elif service == settings.SERVICE_NAME[1]:
        Intra.objects.filter(user_id=user_id).update(token=request.POST.get('token'), refresh=request.POST.get('refresh'))
    elif service == settings.SERVICE_NAME[2]:
        Slack.objects.filter(user_id=user_id).update(token=request.POST.get('token'), refresh=request.POST.get('refresh'))
    elif service == settings.SERVICE_NAME[3]:
        Microsoft.objects.filter(user_id=user_id).update(token=request.POST.get('token'), refresh=request.POST.get('refresh'))
    return HttpResponse('Ok')


## USERS ##
@csrf_exempt
@require_http_methods(['POST'])
def create_user(request):
    user_id = util.firebase_get_user_id(request.META['HTTP_AUTHORIZATION'])
    util.create_user(user_id)
    return HttpResponse('Ok')


@csrf_exempt
@require_http_methods(['POST'])
def update_user(request, user_id):
    user_id = util.firebase_get_user_id(request.META['HTTP_AUTHORIZATION'])
    try:
        user = get_object_or_404(User, user_id=user_id)
    except User.DoesNotExist:
        return Http404("User not found.")
    return HttpResponse('Ok')
