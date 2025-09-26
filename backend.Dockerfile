FROM node:18-alpine

# Устанавливаем git
RUN apk add --no-cache git

WORKDIR /app

# Клонируем репозиторий бэкенда
RUN git clone https://github.com/morislaflame/doodleServer.git .

# Устанавливаем зависимости
RUN npm ci --only=production

# Создаем пользователя для безопасности
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nodejs -u 1001

# Меняем владельца файлов
RUN chown -R nodejs:nodejs /app
USER nodejs

EXPOSE 5000

CMD ["node", "index.js"]