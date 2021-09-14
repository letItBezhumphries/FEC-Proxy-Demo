FROM node:12

# src code destination in container
COPY . /opt/app

WORKDIR /opt/app

RUN npm install

CMD npm start
