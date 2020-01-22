#Stage 1 - Install dependencies and build the app
FROM debian:latest AS build-env

# Install flutter dependencies
RUN apt-get update 
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean

# Clone the flutter repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Run flutter doctor and set path
RUN /usr/local/flutter/bin/flutter doctor -v
RUN export PATH=$PATH:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:

# Enable flutter web
RUN /usr/local/flutter/bin/flutter channel master
RUN /usr/local/flutter/bin/flutter upgrade
RUN /usr/local/flutter/bin/flutter config --enable-web

# Copy files to container and build
WORKDIR /area_front
COPY . .
RUN /usr/local/flutter/bin/flutter build web

# Stage 2 - Create the run-time image
FROM nginx
COPY --from=build-env /area_front/build/web /usr/share/nginx/html