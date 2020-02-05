from django.http import HttpResponse
from link_api import firebase
import json
from link_api.models import Link
from sys import stderr
from link_api import settings


class JsonResponse(HttpResponse):
    def __init__(self, data, **kwargs):
        if settings.DEBUG:
            data = json.dumps(data, indent=4, sort_keys=True)
        else:
            data = json.dumps(data)
        super(JsonResponse, self).__init__(content=data, content_type='application/json', **kwargs)


def get_link(request):
    user_id = request.GET['user_id']
    links = Link.objects.filter(user_id=user_id)
    data = []
    for l in links:
        data.append({'action_name': l.action_name,
                    'reaction_name': l.reaction_name,
                    'value_to_compare': l.value_to_compare,
                    'value': l.value()})
    return JsonResponse({'links': data})
