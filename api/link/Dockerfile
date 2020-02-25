FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install python3 python3-pip default-mysql-client default-libmysqlclient-dev

WORKDIR /link_api

COPY requirement.txt .

RUN pip3 install -U setuptools
RUN pip3 install -r requirement.txt

CMD ["sh", "start.sh"]