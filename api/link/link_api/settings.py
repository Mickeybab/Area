"""
Django settings for link_api project.

Generated by 'django-admin startproject' using Django 3.0.2.

For more information on this file, see
https://docs.djangoproject.com/en/3.0/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/3.0/ref/settings/
"""

import os
import firebase_admin


DEV = False
if os.getenv("DEV"):
    DEV = True

MY_IP = 'mickeudulac.hd.free.fr:8080/'
if DEV:
    MY_IP = 'http://localhost:8080/'

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/3.0/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'gsay@k-dmi!6^s6gg5@p^cd5s!t6c33z-!vzv-!q_pys#8-k^7'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = [
    'link_api',
    'localhost',
    'mickeydulac.hd.free.fr'
    ]


# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'link_api',
    'corsheaders',
]

MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'link_api.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'link_api.wsgi.application'


# Database
# https://docs.djangoproject.com/en/3.0/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'area',
        'USER': 'user',
        'PASSWORD': 'test',
        'HOST': 'db',
        'PORT': '3306',
    }
}


# Password validation
# https://docs.djangoproject.com/en/3.0/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/3.0/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/3.0/howto/static-files/

STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, "static")


## FIREBASE #######

FIREBASE_PATH = "area-a0d38-firebase-adminsdk-jw2de-59a95d0b6f.json"
FIREBASE_CRED = firebase_admin.credentials.Certificate(FIREBASE_PATH)
FIREBASE = firebase_admin.initialize_app(FIREBASE_CRED)

## SERVICE NAME ###
SERVICE_NAME = [
    'github',
    'intraepitech',
    'slack',
    'currency',
    'weather',
    'googlemail',
    'notification',
    'email',
]


## API ############
SERVICE_INTRA = 'http://intra_api:8080/'
SERVICE_GITHUB = 'http://github_api:9000/'
SERVICE_CURRENCY = 'http://currency_api:8080/'
SERVICE_WEATHER = 'http://weather_api:8080/'
SERVICE_EMAIL = 'http://email_backup_api:8080/'
SERVICE_SLACK = 'http://slack_api:8080/'

GITHUB_ID = '70b9d6966be7a0f36da8'
GITHUB_SECRET = 'dbc4e4eaa5fa1e360b2f9dbe4018d0430f53a9e8'

CURRENCY_LIST = [
    'EUR',
    'USD',
    'CAD',
    'CHF',
    'GBP',
    'SEK',
]

CORS_ORIGIN_ALLOW_ALL = True

GITHUB_ACTION = [
    'new commit'
]

SLACK_REACTION = [
    'Slack Message'
]

GOOGLE_REACTION = [
    'Google Mail'
]

NOTIFICATION_REACTION = [
    'notification'
]

WEATHER_ACTION = [
    'below a threshold',
    'exceeds a threshold'
]

GOOGLE_ACTION = [
    'receive email'
]

INTRA_ACTION = [
    'mark below a limit',
    'credit number that exceeds',
    'gpa drop below',
    'gpa exceeds'
]

CURRENCY_ACTION = [
    'money drop',
    'money up'
]

SLACK_ACTION = [
    'receive notification'
]

GITHUB_NUMBER = [
    0,
    1,
    2
]

WEATHER_NUMBER = [
    3,
    4,
    5,
    6,
    7,
    8
]

GOOGLE_NUMBER = [
    9,
    10,
    11
]

INTRA_NUMBER = [
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23
]

CURRENCY_NUMBER = [
    24,
    25,
    26,
    27,
    28,
    29
]

SLACK_NUMBER = [
    30,
    31,
    32
]