# syntax=docker/dockerfile:1.9

FROM docker.io/node:22-alpine as BUILD
ENV \
  PHANPY_CLIENT_NAME="Phanpy" \
  PHANPY_WEBSITE="https://phanpy.brothertec.eu" \
  PHANPY_DEFAULT_INSTANCE="gts.brothertec.eu" \
  PHANPY_DEFAULT_INSTANCE_REGISTRATION_URL="https://gts.brothertec.eu/login" \
  PHANPY_PRIVACY_POLICY_URL="https://gts.brothertec.eu/about" \
  PHANPY_DEFAULT_LANG="de" \
  PHANPY_LINGVA_INSTANCES="phanpy.brothertec.eu" \
  PHANPY_IMG_ALT_API_URL="" \
  PHANPY_GIPHY_API_KEY=""
WORKDIR /build
COPY package.json package-lock.json ./
RUN npm install
COPY ./ ./
RUN npm run build

FROM caddy:2-alpine
COPY --from=BUILD /build/dist/ /usr/share/caddy
COPY Caddyfile /etc/caddy/Caddyfile
