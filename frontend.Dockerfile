# Build stage
FROM node:18-alpine as builder

WORKDIR /app

# Копируем исходный код
COPY frontend-source/ .

# Устанавливаем зависимости
RUN npm ci --no-audit --no-fund

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