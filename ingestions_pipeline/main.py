import os
import sqlite3
import requests
import time
import re
import html
from datetime import datetime
from dotenv import load_dotenv

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DB_PATH = os.path.join(BASE_DIR, "..", "storage", "development.sqlite3")

load_dotenv()
UNSPLASH_KEY = os.getenv("UNSPLASH_ACCESS_KEY")
UNSPLASH_SEARCH_URL = "https://api.unsplash.com/search/photos"

WIKI_API_URL = "https://commons.wikimedia.org/w/api.php"
WIKI_USER_AGENT = os.getenv("WIKI_USER_AGENT")

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
        
    #print(f"Skipping {cocktail_name}: no acceptable images found")
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
    if not WIKI_USER_AGENT:
        raise RuntimeError("WIKI_USER_AGENT is not set")
    headers = {
        "User-Agent": WIKI_USER_AGENT
    }
    
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

    response = requests.get(WIKI_API_URL, headers=headers, params=params)
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
    raw_artist = get_meta("Artist")

    return {
        "url": info["url"],
        "photographer": normalize_wikimedia_artist(raw_artist),
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

def normalize_wikimedia_artist(raw_artist):
    if not raw_artist:
        return None

    # Decode HTML entities
    artist = html.unescape(raw_artist)

    # Strip HTML tags
    artist = re.sub(r"<[^>]+>", "", artist)

    # Remove common Wikimedia templates
    artist = re.sub(r"\{\{.*?\}\}", "", artist)

    # Remove "User:" or "Creator:" prefixes
    artist = re.sub(r"^(User|Creator):", "", artist, flags=re.IGNORECASE)

    # Remove common boilerplate phrases
    boilerplate = [
        "own work",
        "self",
        "unknown",
        "photographed by",
        "photo by",
    ]

    lower = artist.lower()
    if any(term in lower for term in boilerplate):
        return None

    # Collapse whitespace
    artist = re.sub(r"\s+", " ", artist).strip()

    # Catch garbage leftovers
    if len(artist) < 3:
        return None

    return artist
from datetime import datetime

def insert_photo(cursor, cocktail_id, photo_or_name):
    """
    Accepts either a photo dict (as returned by fetch_photos) or a cocktail name string.
    If given a cocktail name, this will attempt to fetch a photo itself.
    """
    now = datetime.utcnow().isoformat(sep=" ", timespec="seconds")

    # Normalize input: allow either photo dict or cocktail name
    if isinstance(photo_or_name, dict):
        photo = photo_or_name
        cocktail_name = None
    else:
        cocktail_name = photo_or_name
        photo = fetch_photos(cocktail_name)
        if not photo:
            return None

    name = cocktail_name or photo.get("title") or "cocktail"
    photographer = photo.get("photographer")
    url = photo.get("url")
    source = photo.get("source")
    license_ = photo.get("license")

    cursor.execute("""
        INSERT INTO photos (
            name,
            photographer,
            url,
            source,
            license,
            cocktail_id,
            created_at,
            updated_at
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    """, (
        name,
        photographer,
        url,
        source,
        license_,
        cocktail_id,
        now,
        now
    ))

    return cursor.lastrowid

def main():
    not_found = []
    for cocktail in cocktails:
        cocktail_id = cocktail["id"]
        cocktail_name = cocktail["name"]
        photo = fetch_photos(cocktail_name)
        if photo:
            insert_photo(cursor, cocktail_id, cocktail_name)
        else:
            not_found.append(cocktail_name)
        time.sleep(1)
    conn.commit()

if __name__ == "__main__":
    main()