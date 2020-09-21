FROM node:alpine
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# ElasticBeanstalk only port expose
EXPOSE 80

# From '0' is the previous 'FROM' build. Can't use FROM node:alpine as NAMED
COPY --from=0 /app/build /usr/share/nginx/html