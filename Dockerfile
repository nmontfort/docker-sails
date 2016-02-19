FROM debian:latest

MAINTAINER Nicolas Montfort

# Install dependencies
RUN apt-get update \
&& apt-get install -y curl git \
&& rm -rf /var/lib/apt/lists/*

# Install nodejs
RUN curl -LO "https://nodejs.org/dist/v0.12.5/node-v0.12.5-linux-x64.tar.gz" \
&& tar -xzf node-v0.12.5-linux-x64.tar.gz -C /usr/local --strip-components=1 \
&& rm node-v0.12.5-linux-x64.tar.gz

# Install nodejs dependencies
RUN npm install -g sails sails-mysql pm2 nodemon

RUN sails new app

EXPOSE 1337

VOLUME /app

WORKDIR /app

CMD pm2 start app.js
