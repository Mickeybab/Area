FROM debian:latest AS build-env

RUN apt-get update 
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean

RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

RUN /usr/local/flutter/bin/flutter doctor -v
RUN export PATH=$PATH:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:

RUN /usr/local/flutter/bin/flutter channel master
RUN /usr/local/flutter/bin/flutter upgrade
RUN /usr/local/flutter/bin/flutter config --enable-web

WORKDIR /area_front
COPY . .
RUN /usr/local/flutter/bin/flutter build web

FROM nginx
COPY --from=build-env /area_front/build/web /usr/share/nginx/html