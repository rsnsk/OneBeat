 How to display a webapp using HTML5 on Brightsign

In case there is no need for a library or other multi-source-issues, this workflow can be sufficient:

1. create an empty SD card, that contains a folder "dist"

2. in that folder put the index.html and media files

3. add "autorun.brs" to the root of the SD, refer to a minimal version in resources/autorun.brs

4. put SD card in player, fingers crossed

If multiple javascript files need to be included into the webapp, it is necessary to combine them into

one flat single file using webapp or similar tools. A workflow could be like this:

1. Put all webapp files (index.html, *.js, images, ...) into one src folder

2. To include node.js libraries the infamous npm is needed. One approach to avoid version

conflicts is to use a docker container as build machine to create the content of the dist folder:

Dockerfile:

FROM alpine

RUN apk update

RUN apk add nodejs npm

RUN npm install --save-dev webpack

RUN npm install --save-dev webpack-cli

RUN npm i --save-dev html-webpack-plugin

Run and enter the "web app build machine":

$ docker build -t wabmach .

$ docker run --name wabmach -it wabmach sh

# cd /root

in a different terminal copy the content to the container. Also add the web

$ docker cp ./src wabmach:/root

$ docker cp ./webpack.config.js wabmach:/root

$ docker cp ./package.json wabmach:/root

within the container in root folder build the webapp

$ npm run build

3. copy the created webapp from container folder "root/dist" onto SD card, also copy the 