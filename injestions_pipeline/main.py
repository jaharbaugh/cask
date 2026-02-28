import os
import sqlite3
import requests
from dotenv import load_dotenv

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DB_PATH = os.path.join(BASE_DIR, "..", "storage", "development.sqlite3")

load_dotenv()
UNSPLASH_KEY = os.getenv("UNSPLASH_ACCESS_KEY")
UNSPLASH_SEARCH_URL = "https://api.unsplash.com/search/photos"

conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
cursor = conn.cursor()

cursor.execute("SELECT id, name FROM cocktails")
cocktails = cursor.fetchall()

def fetch_photos(cocktail):
    query = cocktail + " classic cocktail"
    results = search_unsplash(query)

    if not results:
        return None
    return extract_photo_data(results[0])

def search_unsplash(query, per_page=3):
    headers = {
        "Authorization": f"Client-ID {UNSPLASH_KEY}"
    }

    params = {
        "query": query,
        "per_page": per_page,
        "orientation": "squarish"
    }

    response = requests.get(UNSPLASH_SEARCH_URL, headers=headers, params=params)
    response.raise_for_status()
    return response.json()["results"]

def extract_photo_data(photo):
    return {
        "url": photo["urls"]["regular"],
        "photographer": photo["user"]["name"],
        "source": photo["links"]["html"],
        "license": "Unsplash License"
    }

print(fetch_photos('espresso martini'))

'''
for cocktail in cocktails:
    print(cocktail["id"], cocktail["name"])
    print(fetch_photos(cocktail))
'''