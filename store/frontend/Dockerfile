# BUILDER STAGE - 1
FROM node:21.7.3-alpine3.19 as builder

ENV NODE_OPTIONS=--openssl-legacy-provider

WORKDIR /build
COPY . .

RUN npm install \
    && npx browserslist@latest --update-db \
    && npm i react-scripts@latest \
    && npm run build

# RELEASE STAGE - 2
FROM nginx:mainline-alpine3.19

ENV NODE_ENV=production
ENV VUE_APP_API_URL=http://backend:8081

WORKDIR /var/www
COPY --from=builder --chown=nginx:www-data /build/dist /opt/www