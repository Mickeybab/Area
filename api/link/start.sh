set -e

while ! mysqladmin ping -h"db" --silent; do
  >&2 echo "Mysql is unavailable - sleeping"
  sleep 1
done

python3 manage.py migrate

python3 -u manage.py runserver --verbosity 3 0.0.0.0:9000