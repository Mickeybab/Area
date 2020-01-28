FROM python:3.7

WORKDIR /users_api

COPY requirement.txt .

RUN pip3 install -r requirement.txt

COPY . .

CMD ["python3", "-u", "manage.py", "runserver", "--verbosity", "3", "0.0.0.0:9000"]