# Django Compose

Bootstrap new Django projects for development with Docker Compose.

I can nominate which version of Django I wish to use without it being installed on my host system.

## Requirements

* Git
* Docker

## Usage

Clone this repo to your local system:

    git clone https://github.com/mattrowbum/django-compose.git

Now configure which services and versions you want running:

* Change the Python version in `Dockerfile`
* Change Django version and add/alter python packages in `requirements.txt`
* Change database and add other services in `compose.yaml`

If you are using postgis/postgres, create a `.env` file like the following:

```bash
POSTGRES_DB=mydb
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
```

Navigate to the project folder, then build and start the containers:

    cd django-compose
    docker-compose build
    docker-compose up

Open a second terminal window/tab, access an interactive shell within the `web` container and start a new Django project:

    docker exec -it django-compose-web-1 /bin/bash
    django-admin startproject mysite
    exit

Update the `web` service in `compose.yml` so that the new django project folder (ie: `/mysite`) maps to the `/src` folder in the container. Also, remove `tty: true` and add `command: python manage.py runserver 0.0.0.0:8000`:

```yaml
  web:
    image: django:4.2.2
    build: .
    ports:
      - "8000:8000"
    networks:
      - backend
    volumes:
      - ./mysite:/src
    depends_on:
      - db
    command: python manage.py runserver 0.0.0.0:8000
```

Run docker-compose:

    docker-compose up

You should now be able to access the site in your browser at http://localhost:8000/
