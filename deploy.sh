#!/bin/bash

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN} Начинаем развертывание DoodleJump...${NC}"

# Проверяем наличие .env файла
if [ ! -f .env ]; then
    echo -e "${RED} Файл .env не найден!${NC}"
    exit 1
fi

# Останавливаем существующие контейнеры
echo -e "${YELLOW} Останавливаем существующие контейнеры...${NC}"
docker-compose down

# Собираем и запускаем контейнеры
echo -e "${YELLOW} Собираем и запускаем контейнеры...${NC}"
docker-compose up --build -d

# Ждем запуска сервисов
echo -e "${YELLOW} Ждем запуска сервисов...${NC}"
sleep 15

# Показываем статус
echo -e "${GREEN} Статус контейнеров:${NC}"
docker-compose ps

echo -e "${GREEN} Развертывание завершено!${NC}"
echo -e "${GREEN} Фронтенд: http://your-domain.com${NC}"
echo -e "${GREEN} API: http://your-domain.com/api${NC}"