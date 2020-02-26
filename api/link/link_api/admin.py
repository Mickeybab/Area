
from link_api.models import User, Applet, Notif, ParamApplet, Github, Slack, Intra, Google, Service
from django.contrib import admin
from sys import stderr


def delete_model(modeladmin, request, queryset):
    print('DELETE !!!!', file=stderr)
    for user in queryset:
        for app in Applet.objects.filter(user_id=user.user_id):
            ParamApplet.objects.filter(applet_id=app.id).delete()
        Applet.objects.filter(user_id=user.user_id).delete()
        Notif.objects.filter(user_id=user.user_id).delete()
        Github.objects.filter(user_id=user.user_id).delete()
        Google.objects.filter(user_id=user.user_id).delete()
        Slack.objects.filter(user_id=user.user_id).delete()
        Intra.objects.filter(user_id=user.user_id).delete()
        Service.objects.filter(user_id=user.user_id).delete()
        User.objects.filter(user_id=user.user_id).delete()


class UserAdmin(admin.ModelAdmin):
    readonly_fields = ('user_id',)
    fields = ('user_id', 'name', 'last_name')
    empty_value_display = '-empty-'
    actions = [delete_model]
    search_fields = ('name', 'last_name', 'user_id', )

    def has_delete_permission(self, request, obj=None):
        return False
    
    def has_add_permission(self, request):
        return False


admin.site.disable_action('delete_selected')

admin.site.register(User, UserAdmin)

admin.site.site_title = "AREA 2020"
admin.site.site_header = "AREA 2020"
