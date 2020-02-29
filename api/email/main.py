import os
import pickle
import os.path
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request
# from app import app
 
SCOPES = ['https://www.googleapis.com/auth/gmail.readonly']

if __name__ == "__main__":
    