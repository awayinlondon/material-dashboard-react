FROM node:8 as build

# create app directory
WORKDIR /usr/src/app

# install application dependencies
# a wildcard is used to ensure both package.json AND package-lock.json are copied where available
COPY package*.json ./

RUN npm install

# bundle app source
COPY . .

RUN npm run build

FROM nginx:1.13.12-alpine
# the following line has been commented as it appears it already exists
# RUN mkdir /usr/share/nginx/html
COPY --from=build /usr/src/app/build /usr/share/nginx/html/dashbaord
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]
