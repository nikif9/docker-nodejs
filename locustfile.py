import random
from locust import HttpUser, task, between

class ComputeUser(HttpUser):
    wait_time = between(1, 2)

    @task
    def compute(self):
        n = random.randint(1, 50)  # Генерируем случайное число от 1 до 100
        self.client.get(f"/api/compute?n={n}")
