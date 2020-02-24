set -e

while ! mysqladmin ping -h"db" --silent; do
  >&2 echo "Mysql is unavailable - sleeping"
  sleep 1
done

sleep 30

while true; do
    sleep 30
    python3 -u manage.py services
done