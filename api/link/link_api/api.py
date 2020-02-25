from django.http import HttpResponse, Http404
import json
from link_api.models import Intra, Applet, ParamApplet, Github, Intra, Slack, Google, User, Notif, Service
from link_api import settings
from link_api import util
from django.db import transaction
from django.views.decorators.http import require_http_methods
from django.shortcuts import get_object_or_404
from django.views.decorators.csrf import csrf_exempt
from sys import stderr


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
    print(request.body.decode(), file=stderr)
    return json.loads(request.body.decode())


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

    if data['action']['service'] == settings.SERVICE_NAME[3]:
        for p in data['action']['param']:
            if p['name'] == 'Currency':
                if not p['value'] in settings.CURRENCY_LIST:
                    return HttpResponse('Currency is not valid')

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
        app.action_service = data['action']['service']
        app.action = data['action']['action']
        app.reaction_service = data['reaction']['service']
        app.reaction = data['reaction']['reaction']
        app.data = None
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

    return JsonResponse(applet_to_json(Applet.objects.get(user_id=user_id, id_applet=int(id))))


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


@csrf_exempt
@require_http_methods(['GET'])
def get_applets_by_services(request, service):
    return JsonResponse([applet_to_json(a) for a in Applet.objects.filter(user_id=user_id, action=service)])


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
    elif service == settings.SERVICE_NAME[5]:
        Google.objects.filter(user_id=user_id).update(token=request.POST.get('token'), refresh=request.POST.get('refresh'))
    return HttpResponse('Ok')


@csrf_exempt
@require_http_methods(['GET'])
def get_services(request):
    user_id = util.firebase_get_user_id(request.META['HTTP_AUTHORIZATION'])
    response = [
        {
            "service": "Github",
            "color" : "0xffb74093",
            "logo": 'http://' + settings.MY_IP + 'static/github.png',
            "enable": Service.objects.get(name=settings.SERVICE_NAME[0], user_id=user_id).enable
        },
        {
            "service": "Intra Epitech",
            "color" : "0xffb74093",
            "logo": 'http://' + settings.MY_IP + 'static/intra.png',
            "enable": Service.objects.get(name=settings.SERVICE_NAME[1], user_id=user_id).enable
        },
        {
            "service": "Slack",
            "color" : "0xffb74093",
            "logo": 'http://' + settings.MY_IP + 'static/slack.png',
            "enable": Service.objects.get(name=settings.SERVICE_NAME[2], user_id=user_id).enable
        },
        {
            "service": "Currency",
            "color" : "0xffb74093",
            "logo": 'http://' + settings.MY_IP + 'static/bitcoin.png',
            "enable": Service.objects.get(name=settings.SERVICE_NAME[3], user_id=user_id).enable
        },
        {
            "service": "Weather",
            "color" : "0xffb74093",
            "logo": 'http://' + settings.MY_IP + 'static/weather.png',
            "enable": Service.objects.get(name=settings.SERVICE_NAME[4], user_id=user_id).enable
        },
        {
            "service": "Google Mail",
            "color" : "0xffb74093",
            "logo": 'http://' + settings.MY_IP + 'static/googlemail.png',
            "enable": Service.objects.get(name=settings.SERVICE_NAME[5], user_id=user_id).enable
        },
    ]
    return JsonResponse(response)


@csrf_exempt
@require_http_methods(['POST'])
def activate_service(request, service):
    user_id = util.firebase_get_user_id(request.META['HTTP_AUTHORIZATION'])
    Service.objects.filter(name=service, user_id=user_id).update(enable=True)
    return HttpResponse("Ok")


@csrf_exempt
@require_http_methods(['POST'])
def desactivate_service(request, service):
    user_id = util.firebase_get_user_id(request.META['HTTP_AUTHORIZATION'])
    Service.objects.filter(name=service, user_id=user_id).update(enable=False)
    Applet.objects.filter(user_id=user_id, action_service=service).update(enable=False)
    return HttpResponse("Ok")


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


@csrf_exempt
@require_http_methods(['POST'])
def get_notif(request):
    user_id = util.firebase_get_user_id(request.META['HTTP_AUTHORIZATION'])
    result = []
    for n in Notif.objects.filter(user_id=user_id, send=False):
        result.append(n.message)
        Notif.objects.filter(id=n.id).update(send=True)
    return JsonResponse(result)
