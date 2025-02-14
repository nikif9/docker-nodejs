import random
from locust import HttpUser, task, between

class LoadTestUser(HttpUser):
    wait_time = between(1, 2)  # Задержка между запросами

    @task
    def compute_request(self):
        n = random.randint(1, 50)
        with self.client.get(f"/api/compute?n={n}", catch_response=True) as response:
            if response.status_code == 200:
                print(f"Response: {response.text}")  # Вывод в консоль
                response.success()
            else:
                error_message = f"Error {response.status_code}: {response.text}"
                print(error_message)  # Вывод в консоль
                response.failure(error_message)