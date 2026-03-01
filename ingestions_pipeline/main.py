import os
import sqlite3
import requests
import time
from dotenv import load_dotenv

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DB_PATH = os.path.join(BASE_DIR, "..", "storage", "development.sqlite3")

load_dotenv()
UNSPLASH_KEY = os.getenv("UNSPLASH_ACCESS_KEY")
UNSPLASH_SEARCH_URL = "https://api.unsplash.com/search/photos"

WIKI_API_URL = "https://commons.wikimedia.org/w/api.php"


conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
cursor = conn.cursor()

cursor.execute("""
    SELECT c.id, c.name
    FROM cocktails c
    LEFT JOIN photos p ON p.cocktail_id = c.id
    WHERE p.id IS NULL
""")
cocktails = cursor.fetchall()

results = {}

def fetch_photos(cocktail_name):
    query = cocktail_name + " classic cocktail"

    unsplash_results = search_unsplash(query)
    for photo in unsplash_results:
        if is_acceptable_unsplash_photo(photo):
            return extract_unsplash_photo_data(photo)

    wikimedia_results = search_wikimedia(query)
    for page in wikimedia_results:
        if is_acceptable_wikimedia_page(page):
            return extract_wikimedia_photo_data(page)
        
    print(f"Skipping {cocktail_name}: no acceptable images found")
    return None   

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

def is_acceptable_unsplash_photo(photo):
    return photo.get("width", 0) >= 800

def search_wikimedia(query, limit=5):
    params = {
        "action": "query",
        "format": "json",
        "generator": "search",
        "gsrsearch": query,
        "gsrlimit": limit,
        "gsrnamespace": 6,
        "prop": "imageinfo",
        "iiprop": "url|extmetadata"
    }

    response = requests.get(WIKI_API_URL, params=params)
    response.raise_for_status()

    pages = response.json().get("query", {}).get("pages", {})
    return pages.values()

def extract_unsplash_photo_data(photo):
    return {
        "url": photo["urls"]["regular"],
        "photographer": photo["user"]["name"],
        "source": photo["links"]["html"],
        "license": "Unsplash License"
    }

def extract_wikimedia_photo_data(page):
    info = page["imageinfo"][0]
    meta = info.get("extmetadata", {})

    def get_meta(key):
        return meta.get(key, {}).get("value")

    return {
        "url": info["url"],
        "photographer": get_meta("Artist"),
        "source": info["descriptionurl"],
        "license": get_meta("LicenseShortName") or "Unknown"
    }

def is_acceptable_wikimedia_page(page):
    title = page.get("title", "").lower()

    bad_keywords = [
        "logo",
        "diagram",
        "svg",
        "illustration",
        "bottle",
        "label"
    ]

    if any(word in title for word in bad_keywords):
        return False

    imageinfo = page.get("imageinfo", [])
    if not imageinfo:
        return False

    mime = imageinfo[0].get("mime", "")
    if mime not in ["image/jpeg", "image/png"]:
        return False

    return True

def main():

    for cocktail in cocktails:
        print(cocktail["id"], cocktail["name"])
        results[cocktail["id"]] = fetch_photos(cocktail["name"])
        time.sleep(90)

if __name__ == 'main':
    main()