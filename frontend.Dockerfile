# Build stage
FROM node:18-alpine as builder

# Устанавливаем git
RUN apk add --no-cache git

WORKDIR /app

# Клонируем репозиторий фронтенда и переключаемся на ветку shop
RUN git clone https://github.com/morislaflame/DoodleTon.git . && \
    git checkout shop

# Устанавливаем зависимости
RUN npm ci

# Собираем приложение
RUN npm run build

# Production stage
FROM nginx:alpine

# Копируем собранное приложение
COPY --from=builder /app/dist /usr/share/nginx/html

# Копируем конфигурацию nginx
COPY frontend-nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]