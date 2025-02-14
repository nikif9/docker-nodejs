# тестове задание
## установка
можено выполнить файл run.sh или команду 
```sh
docker build -t my-app .
docker run -d -p 3000:3000 -p 8089:8089 --name my-app my-app
```
чтобы запустить locust нада выполнить команду 
```sh
docker exec -it my-app sh locust -f locustfile.py --host=http://localhost:3000
```
