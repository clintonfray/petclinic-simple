from locust import HttpUser, task, between
import urllib3
import random, string
import time
from bs4 import BeautifulSoup
from urllib import parse

urllib3.disable_warnings()

            
class User(HttpUser):


    wait_time = between(1, 5)

    files = [
            {'title': (None, 'file1'), 'status': (None, 1)}
        ]
    data = []


    pets = [
        {
            "name": "Codi",
            "birthDate": "2023-04-11",
            "type": "dog"
        },
        {
            "name": "Skye",
            "birthDate": "2023-04-11",
            "type": "dog"
        },
        {
            "name": "Jack",
            "birthDate": "2023-04-11",
            "type": "bird"
        },
        {
            "name": "Susie",
            "birthDate": "2023-04-11",
            "type": "cat"
        },
    ]

    def on_start(self):
        """ on_start is called when a Locust start before any task is scheduled """
        self.client.verify = False
    
    @task(7)
    def home(self):
        self.client.get('/')
    
    @task(7)
    def find_owners(self):
        self.client.get('/owners/find')
        self.client.get('/owners?page=1')
        self.client.get('/owners?page=2')

    @task(1)
    def select_owner(self):
        owner_id = random.randint(1, 3)
        self.client.get(f'/owners/{owner_id}')

    @task(1)
    def edit_owner(self):
        owner_id = random.randint(1, 3)
        self.client.get('/owners/1/edit')

    @task(5)
    def list_vets(self):
        self.client.get('/vets.html')
        self.client.get('/vets.html?page=2')

    @task(2)
    def generate_error(self):
        r = random.randint(1, 10)
        if r == 3:
            self.client.get('/oups')
