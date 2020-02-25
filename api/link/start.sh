set -e

while ! mysqladmin ping -h"db" --silent; do
  >&2 echo "Mysql is unavailable - sleeping"
  sleep 1
done

python3 manage.py migrate

echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'bleemoe@bleemoe.com', 'admin')" | python3 manage.py shell 2> /dev/null || echo "Ok"

python3 -u manage.py runserver --verbosity 3 0.0.0.0:9000