FROM python:3.11-bullseye

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED=1

RUN mkdir /src
WORKDIR /src
COPY requirements.txt .

RUN apt-get -y update
RUN python -m pip install --upgrade pip
RUN python -m pip install -r requirements.txt

# Install GDAL
RUN apt-get install -y binutils libproj-dev gdal-bin python3-gdal
