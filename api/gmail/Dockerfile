FROM node:13.8.0

WORKDIR /gmail

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 9000

CMD [ "npm", "start" ]
