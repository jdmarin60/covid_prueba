#!/bin/bash
mkdir /home/app/logs > /dev/null 2>&1

touch /home/app/logs/gunicorn-access.log
touch /home/app/logs/gunicorn.log
#touch /home/app/logs/app.log
tail -n 0 -f /home/app/logs/*.log &

#python manage.py migrate
python3 manage.py collectstatic --clear --noinput > /dev/null 2>&1
python3 manage.py collectstatic --noinput > /dev/null 2>&1

exec gunicorn $PROJECT_NAME.wsgi -w 2 -b :8002 \
    --access-logfile /home/app/logs/gunicorn-access.log \
    --error-logfile /home/app/logs/gunicorn.log --reload 

