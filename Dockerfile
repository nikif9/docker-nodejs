FROM genotek/r-base:20210121
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app
COPY install.R /app/install.R

RUN Rscript /app/install.R && echo "R script completed" 

WORKDIR /app/frontend
# Копируем файлы package.json и package-lock.json (если есть) и устанавливаем зависимости
COPY frontend/package*.json ./
RUN bash -c "source ~/.bashrc && npm install"
# Копируем исходный код фронтенда и выполняем сборку
COPY frontend/ ./
RUN bash -c "source ~/.bashrc && npm run build"

WORKDIR /app/backend
# Копируем файлы package.json и package-lock.json (если есть) и устанавливаем зависимости
COPY backend/package*.json ./

COPY locustfile.py ./
RUN bash -c "source ~/.bashrc && npm install"
RUN pip3 install locust requests
# Копируем исходный код бекенда
COPY backend/ ./
# Открываем порт 3000 для доступа к приложению
EXPOSE 3000 8089

# Переходим в директорию бекенда и запускаем приложение
WORKDIR /app/backend
CMD ["bash", "-c", "source ~/.bashrc && npm start"]