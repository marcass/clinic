# https://medium.com/swlh/how-to-scrape-email-addresses-from-a-website-and-export-to-a-csv-file-c5d1becbd1a0

# Open asp.net form 9button is called "find a vet"
# Opens on page '1', to interate pages links are in the style of <a title="Go to page 3" href="javascript:__doPostBack('ctl01$TemplateBody$WebPartManager1$gwpciNewQueryMenuCommon$ciNewQueryMenuCommon$ResultsGrid$Grid1$ctl00$ctl03$ctl01$ctl09','')"><span>3</span></a>
# parse each page of the table looking for links starting with "href=/FindAVet?ID1125" as an exxample

# Or: URL for each vet in form of https://www.vetcouncil.org.nz/FindAVet?ID=4197 (number is registratioin number) so could iterate through numbers up to 20000 and dump info if available
# Email field is: 



page = requests.get("https://www.vetcouncil.org.nz/FindAVet?ID=4196")
soup = BeautifulSoup(page.content, 'html.parser')
out = list(soup.children)
content = out[3]
content = list(content.children)
content = content[3] #next layer
content = list(content.children)
content = content[3] #next layer
content = list(content.children)
content = content[3] #next layer
content = list(content.children)
#name and email is in content[21] here
name = list(content[21].children) # need to extract it from here
name = list(name[3].children)
name = list(name[1].children)



import re
import requests
from urllib.parse import urlsplit
from collections import deque
from bs4 import BeautifulSoup
import pandas as pd
from google.colab import files

original_url = input("Enter the website url: ") 

unscraped = deque([original_url])  

scraped = set()  

emails = set()  

while len(unscraped):
    url = unscraped.popleft()  
    scraped.add(url)

    parts = urlsplit(url)
        
    base_url = "{0.scheme}://{0.netloc}".format(parts)
    if '/' in parts.path:
      path = url[:url.rfind('/')+1]
    else:
      path = url

    print("Crawling URL %s" % url)
    try:
        response = requests.get(url)
    except (requests.exceptions.MissingSchema, requests.exceptions.ConnectionError):
        continue

    new_emails = set(re.findall(r"[a-z0-9\.\-+_]+@[a-z0-9\.\-+_]+\.com", response.text, re.I))
    emails.update(new_emails) 

    soup = BeautifulSoup(response.text, 'lxml')

    for anchor in soup.find_all("a"):
      if "href" in anchor.attrs:
        link = anchor.attrs["href"]
      else:
        link = ''

        if link.startswith('/'):
            link = base_url + link
        
        elif not link.startswith('http'):
            link = path + link

        if not link.endswith(".gz"):
          if not link in unscraped and not link in scraped:
              unscraped.append(link)

df = pd.DataFrame(emails, columns=["Email"])
df.to_csv('email.csv', index=False)

files.download("email.csv")